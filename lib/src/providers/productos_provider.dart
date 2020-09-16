
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_form_validation_app/src/models/producto_model.dart';

class ProductoProvider {
  final String _url = 'https://flutterfirstproyect.firebaseio.com';

  Future<bool>crearProducto(ProductModel producto) async{
    final url ='$_url/productos.json';
    final resp = await http.post(url, body: productModelToJson(producto));
    final decodedData = json.decode(resp.body);
    //print(decodedData);
    return true;
  }
  Future<bool>editarProducto(ProductModel producto) async{
    final url ='$_url/productos/${producto.id}.json';
    final resp = await http.put(url, body: productModelToJson(producto));
    final decodedData = json.decode(resp.body);
    //print(decodedData);
    return true;
  }



  Future<List<ProductModel>> cargaProductos() async{
    final url ='$_url/productos.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List <ProductModel> productos = new List();
     //print(decodeData);
    if(decodeData == null) return[];
    decodeData.forEach((id,producto){
     // print(id);
      final prodTemp = ProductModel.fromJson(producto);
      prodTemp.id = id;
      productos.add(prodTemp);
    });
    //print(productos[0].id);
    return productos;
  }

  Future<int> borrarProducto (String id) async{
    final url ='$_url/productos/${id}.json';
    final resp = await http.delete(url);
    //print(jsonDecode(resp.body));
    return 1;
  }
}