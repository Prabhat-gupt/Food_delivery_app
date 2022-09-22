import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/base/show_custom_snackbar.dart';
import 'package:food_delivery_app/colorfile/colors.dart';
import 'package:food_delivery_app/colorfile/dimensions.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/models/signup_body_model.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "twitter.png",
      "facebook.png",
      "google.jpg",
    ];
    void _registration(AuthController authController){

      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
          showCustomSnackBar("Type in your name",title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number",title: "Phone number");
      }else if(email.isEmpty){
        showCustomSnackBar("Type in your email number",title: "Email number");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email number",title: "Valid email number");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password",title: "Password");
      }else if(password.length<6){
        showCustomSnackBar("Password can not be less than six characters",title: "Password");
      }else{
        // showCustomSnackBar("All went well",title: "Perfect");
        SignUpBody signUpBody = SignUpBody(name: name,
            phone: phone,
            email: email,
            password: password);
            authController.registration(signUpBody).then((status){
              if(status.isSucces){
                print("Success registration");
              }else{
                showCustomSnackBar(status.message);
              }
            });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
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
              // your email
              AppTextField(
                  textController: emailController,
                  hintText: "Email",
                  icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              // your password
              AppTextField(textController: passwordController,
                  hintText: "Password",
                  icon: Icons.password_sharp,isObscure: true,),
              SizedBox(height: Dimensions.height20,),
              // your name
              AppTextField(textController: nameController,
                  hintText: "Name",
                  icon: Icons.person),
              SizedBox(height: Dimensions.height20,),
              // your phone
              AppTextField(textController: phoneController,
                  hintText: "Phone",
                  icon: Icons.phone),
              SizedBox(height: Dimensions.height20,),
              // sign up button
              GestureDetector(
                onTap: (){
                  _registration(_authController);
                  // AuthController.instance.register(emailController.text.trim(),passwordController.text.trim());
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
                      text: "Sign up",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              // tag line
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text: "Have an account already?",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,
                      )
                  )
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              // sign up options
              RichText(
                  text: TextSpan(
                      text: "Sign up using one of the following methods",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font16,
                      )
                  )
              ),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: Dimensions.radius30,
                    backgroundImage: AssetImage(
                        "assets/images/${signUpImages[index]}"
                    ),
                  ),
                )),
              )


            ],
          ),
        ):const CustomLoader();
      },),
    );




  }
}
