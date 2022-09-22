import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/colorfile/colors.dart';
import 'package:food_delivery_app/colorfile/dimensions.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/widgets/account_widget.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile",size: 24,color: Colors.white,
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
          children: [
            //profile icon
            AppIcon(icon: Icons.person,
              backgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              iconSize: Dimensions.height45+Dimensions.height30,
              size: Dimensions.height15*10,
            ),
            SizedBox(height: Dimensions.height30,),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  //name
                  AccountWidget(
                      appIcon: AppIcon(icon: Icons.person,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize:Dimensions.height10*5/2 ,
                        size: Dimensions.height10*5,
                      ),
                      bigText: BigText(text: "Prabhat",)
                  ),
                  SizedBox(height: Dimensions.height20,),
                  //phone
                  AccountWidget(
                      appIcon: AppIcon(icon: Icons.phone,
                        backgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        iconSize:Dimensions.height10*5/2 ,
                        size: Dimensions.height10*5,
                      ),
                      bigText: BigText(text: "7909870317",)
                  ),
                  SizedBox(height: Dimensions.height20,),
                  //email
                  AccountWidget(
                      appIcon: AppIcon(icon: Icons.email,
                        backgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        iconSize:Dimensions.height10*5/2 ,
                        size: Dimensions.height10*5,
                      ),
                      bigText: BigText(text: "prabhatgupta7909@gmail.com",)
                  ),
                  SizedBox(height: Dimensions.height20,),
                  //address
                  AccountWidget(
                      appIcon: AppIcon(icon: Icons.location_on,
                        backgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        iconSize:Dimensions.height10*5/2 ,
                        size: Dimensions.height10*5,
                      ),
                      bigText: BigText(text: "Fill in your address",)
                  ),
                  SizedBox(height: Dimensions.height20,),
                  //message
                  AccountWidget(
                      appIcon: AppIcon(icon: Icons.message_outlined,
                        backgroundColor: Colors.redAccent,
                        iconColor: Colors.white,
                        iconSize:Dimensions.height10*5/2 ,
                        size: Dimensions.height10*5,
                      ),
                      bigText: BigText(text: "message",)
                  ),
                  SizedBox(height: Dimensions.height20,),
                  //message
                  GestureDetector(
                    onTap: (){
                      if(Get.find<AuthController>().userLoggedIN()){
                      Get.find<AuthController>().clearSharedData();
                      Get.find<CartController>().clear();
                      Get.find<CartController>().clearCartHistory();
                      Get.offNamed(RouteHelper.getSignIn());
                      }else{
                        print("you logged out");
                      }
                    },
                    child: AccountWidget(
                        appIcon: AppIcon(icon: Icons.logout,
                          backgroundColor: Colors.redAccent,
                          iconColor: Colors.white,
                          iconSize:Dimensions.height10*5/2 ,
                          size: Dimensions.height10*5,
                        ),
                        bigText: BigText(text: "Logout",)
                    ),
                  ),
                  SizedBox(height: Dimensions.height20,),
                  //message

                ],
              ),
            ))


          ],
        ),
      ),
    );
  }
}
