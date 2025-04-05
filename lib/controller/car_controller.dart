import 'dart:convert';

import 'package:cars_list/models/car_model.dart';
import 'package:http/http.dart' as http;

class CarController {
  static final String _urlBase =
      "https://cars-list-85289-default-rtdb.asia-southeast1.firebasedatabase.app";

  List<CarModel> cars = [];
  Future<List<CarModel>> getCarList() async {
    final url = Uri.parse("$_urlBase/cars.json");

    final response = await http.get(url);
    final decodedDate = jsonDecode(response.body) as Map;
    final List<CarModel> allCars = [];
    decodedDate.forEach((key, value) {
      final date = value;
      date["id"] = key;
      allCars.add(CarModel.fromJson(date));
    });

    cars = allCars;
    return cars;
  }

  Future<void> addTodo({
    required String image,
    required String name,
    required double price,
    required int speed,
    required int year,
  }) async {
    final url = Uri.parse("$_urlBase/cars.json");
    final newCar = {
      "image": image,
      "name": name,
      "price": price,
      "speed": speed,
      "year": year,
    };
    final response = await http.post(url, body: jsonEncode(newCar));
    final decodedData = jsonDecode(response.body);
    newCar['id'] = decodedData["name"];

    cars.add(CarModel.fromJson(newCar));
  }

  Future<void> editTodo({required String id, required String newTitle}) async {
    final url = Uri.parse("$_urlBase/todos/$id.json");
    final updatingTodo = {"title": newTitle};
    final response = await http.patch(url, body: jsonEncode(updatingTodo));

    print(response.body);
  }

  Future<void> deleteTodo({required String id}) async {
    final url = Uri.parse("$_urlBase/todos/$id.json");
    final response = await http.delete(url);

    print(response.body);
  }
}
