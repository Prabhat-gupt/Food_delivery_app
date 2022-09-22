import 'package:flutter/material.dart';
import 'package:food_delivery_app/colorfile/colors.dart';
import 'package:food_delivery_app/colorfile/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/popular_product_controller.dart';
// import '../../controllers/popular_product_controller.dimport';
import '../../controllers/recommended_product_controller.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget{
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  _MainFoodPageState createState() => _MainFoodPageState();

}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  Widget build(BuildContext context) {
    // print("Current height is "+ MediaQuery.of(context).size.height.toString());
   return RefreshIndicator(
       onRefresh: _loadResource,
       child: Column(
     children: [
       Container(
         margin: EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height15),
         padding: EdgeInsets.only(left:Dimensions.width20,right:Dimensions.width20),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Column(
               children: [
                 BigText(text: "Bangladesh",color: AppColors.mainColor,),
                 Row(
                   children: [
                     SmallText(text: "Narsingdi",color: Colors.black54,),
                     Icon(Icons.arrow_drop_down_rounded),
                   ],
                 )
               ],
             ),
             Center(
               child: Container(
                 child: Icon(Icons.search,color:Colors.white,size: Dimensions.iconSize24,),
                 width: Dimensions.height45,
                 height: Dimensions.height45,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(Dimensions.radius15),
                   color: AppColors.mainColor,

                 ),
               ),
             )
           ],
         ),
       ),
       const Expanded(child: SingleChildScrollView(
         child: FoodPageBody(),
       )),
     ],
   ));

  }

}