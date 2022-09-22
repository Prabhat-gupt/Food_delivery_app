import 'package:food_delivery_app/colorfile/app_constants.dart';
import 'package:get/get.dart';
import '../api/api_client.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});
  Future<Response> getPopularProductList() async{
      return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URL);
  }
}