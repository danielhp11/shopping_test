import 'dart:convert';
import 'package:shopping_app/data/datasources/request_serv.dart';
import 'package:shopping_app/data/model/product_model.dart';

class ProductRepository {
  final RequestServ _service = RequestServ.instance;

  Future<List<ProductModel>> getProducts() async {
    final response = await _service.handlingRequest(
      urlParam: RequestServ.urlProduct,
    );

    if (response != null) {
      final List<dynamic> jsonList = jsonDecode(response);
      return jsonList
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('No se pudieron cargar los productos');
    }
  }
}
