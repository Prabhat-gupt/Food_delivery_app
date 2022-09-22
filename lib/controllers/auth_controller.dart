
import 'package:food_delivery_app/data/repository/auth_repo.dart';
import 'package:food_delivery_app/models/response_model.dart';
import 'package:food_delivery_app/models/signup_body_model.dart';
import 'package:get/get.dart';

import '../colorfile/app_constants.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if(response.statusCode==200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email , String password) async {

    _isLoading = true;
    update();
    Response response = await authRepo.login(email,password);
    late ResponseModel responseModel;
    if(response.statusCode==200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number,String password)  {
      authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIN()  {
    return authRepo.userLoggedIN();
  }

  bool clearSharedData(){
    return authRepo.clearSharedData();
  }
}


/*

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/auth/sign_in_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/data/repository/auth_repo.dart';

import '../models/response_model.dart';
import '../models/signup_body_model.dart';

class AuthController extends GetxController{
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
  });
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  //AuthController.instance..
  static AuthController instance = Get.find();
  // email , password , name
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    // our user would be notified
    _user.bindStream(auth.userChanges());
    ever(_user,_initialScreen);

  }

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if(response.statusCode==200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }



  _initialScreen(User? user){
    if(user==null){
      print("login page");
      Get.offAll(()=>RouteHelper.getSignIn());
    }else{
      Get.offAll(()=>RouteHelper.getInitial());
    }
  }
  void register(String email, password)async{
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);

    }catch(e){
      Get.snackbar("About User", "User message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Account creation failed",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          )
      );
    }
  }

  void login(String email, password)async{
    try{
      await  auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Login failed",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          messageText: Text(
              e.toString(),
              style: TextStyle(
                  color: Colors.white
              )
          )
      );
    }
  }
  bool userLoggedIN()  {
    return authRepo.userLoggedIN();
  }

  bool clearSharedData(){
    return authRepo.clearSharedData();
  }

}


 */