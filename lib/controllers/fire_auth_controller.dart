import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/auth/sign_in_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
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

  _initialScreen(User? user){
    if(user==null){
      print("login page");
      Get.offAll(()=>RouteHelper.getSignIn());
    }else{
      Get.offAll(()=>RouteHelper.getInitial());
    }
  }
  void register(String email, password){
    try{
      auth.createUserWithEmailAndPassword(email: email, password: password);

    }catch(e){
      Get.snackbar("About User", "User message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Account creation failed",
              style: TextStyle(
            color: Colors.white
        ),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        )
      );
    }
  }
}