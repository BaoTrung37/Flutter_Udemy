// ignore_for_file: unnecessary_string_escapes

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:section8/providers/auth.dart';

import '../models/http_exception.dart';
import 'product.dart';

class Products with ChangeNotifier {
  late List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  final String? authToken;
  final String? userId;
  Products(
    this.authToken,
    this.userId,
    this._items,
  );

  var showFavoriteOnly = false;

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  List<Product> get items {
    return [..._items];
  }

  // * Note filter with http
  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    var filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    final url = Uri.parse(
        "https://flutter-app-82f7b-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString");
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final favoriteResponse = await http.get(Uri.parse(
          "https://flutter-app-82f7b-default-rtdb.firebaseio.com/userPavorites/$userId.json?auth=$authToken"));
      final favoriteData = json.decode(favoriteResponse.body);
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      extractedData.forEach((proId, proData) {
        loadedProducts.add(Product(
          id: proId,
          title: proData['title'],
          description: proData['description'],
          price: double.parse(proData['price'].toString()),
          imageUrl: proData['imageUrl'],
          isFavorite:
              favoriteData == null ? false : favoriteData[proId] ?? false,
        ));
      });
      _items = loadedProducts;
      notifyListeners();
      // print(json.decode(response.body));
    } on Exception catch (exception) {
      print(exception);
      throw Exception(exception);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        "https://flutter-app-82f7b-default-rtdb.firebaseio.com/products.json?auth=$authToken");
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'creatorId': userId,
            // 'isFavorite': product.isFavorite,
          },
        ),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
      // return Future.value();
    } on Exception catch (exception) {
      throw Exception(exception);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          "https://flutter-app-82f7b-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken");
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
            'favorite': newProduct.isFavorite,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else
      print('...');
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        "https://flutter-app-82f7b-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken");
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    try {
      final response = await http.delete(url);
      if (response.statusCode >= 400) {
        _items.insert(existingProductIndex, existingProduct);
        notifyListeners();
        throw HttpException(message: 'Could not delete product.');
      }
    } catch (e) {
      print(e);
    }
    // final response = await http.delete(url);
    // if (response.statusCode >= 400) {
    //   _items.insert(existingProductIndex, existingProduct);
    //   notifyListeners();
    //   throw HttpException(message: 'Could not delete product.');
    // }
    // ? ??i???u n??y th???c s??? c???n thi???t khi s??? d???ng Future.
    existingProduct = null;
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }
}
