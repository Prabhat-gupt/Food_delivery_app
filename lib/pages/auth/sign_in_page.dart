import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/colorfile/colors.dart';
import 'package:food_delivery_app/colorfile/dimensions.dart';
import 'package:food_delivery_app/pages/auth/sign_up_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../models/signup_body_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    void _login(AuthController authController){


      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();

       if(email.isEmpty){
        showCustomSnackBar("Type in your email number",title: "Email number");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email number",title: "Valid email number");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password",title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("Password can not be less than six characters",title: "Password");
      }else{
         // authController.registration(email,password);
        showCustomSnackBar("All went well",title: "Perfect");
        SignUpBody signUpBody = SignUpBody(name: name,
            phone: phone,
            email: email,
            password: password);
        authController.login(email,password).then((status){
          if(status.isSucces){
            Get.toNamed(RouteHelper.getInitial());

          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }




    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              // app logo
              Container(
                height:  Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                        "assets/images/i12.png"
                    ),
                  ),
                ),
              ),
              //welcome
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: Dimensions.font20*3 + Dimensions.font20/2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Sign into your account",
                      style: TextStyle(
                        fontSize: Dimensions.font20,
                        // fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              // your email
              AppTextField(textController: emailController,
                  hintText: "Email",
                  icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              // your password
              AppTextField(textController: passwordController,
                hintText: "Password",
                icon: Icons.password_sharp,isObscure: true,),

              SizedBox(height: Dimensions.height20,),
              // tag line
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(
                      text: TextSpan(

                          text: "Sign into your account",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20,
                          )
                      )
                  ),
                  SizedBox(width: Dimensions.width20,)
                ],),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //sign in
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign in",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              // sign up options
              RichText(
                  text: TextSpan(
                      text: "Don\'t an account?",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                          text: " Create",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainBlackColor,
                            fontSize: Dimensions.font20,
                          ),)
                      ]
                  )
              ),



            ],
          ),
        ): const CustomLoader();
      },),
    );
  }
}
