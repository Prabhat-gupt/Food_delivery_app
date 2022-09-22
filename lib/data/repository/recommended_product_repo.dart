import 'package:food_delivery_app/colorfile/app_constants.dart';
import 'package:get/get.dart';
import '../api/api_client.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});
  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URL);
  }
}