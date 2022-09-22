import 'package:food_delivery_app/colorfile/app_constants.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/models/signup_body_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo{
  final ApiClient appClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.appClient,
    required this.sharedPreferences,
});
  
  Future<Response> registration(SignUpBody signUpBody)async{
    return await appClient.postData(AppConstants.REGISTRATION_URL, signUpBody.toJson());
  }

  bool userLoggedIN()  {
    return  sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }

  Future<Response> login(String email, String password)async{
    return await appClient.postData(AppConstants.LOGIN_URL, {"email":email,"password":password});
  }
  Future<bool> saveUserToken(String token) async {
    appClient.token = token;
    appClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

Future<void> saveUserNumberAndPassword(String number,String password) async{
    try{
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
}

bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    appClient.token = '';
    appClient.updateHeader('');
    return true;
}
}