class CarModel {
  final String name;
  final double price;
  final String id;
  final String image;
  final int speed;
  final int year;

  CarModel({
    required this.name,
    required this.price,
    required this.id,
    required this.speed,
    required this.image,
    required this.year,
  });

  factory CarModel.fromJson(Map map) {
    return CarModel(
      name: map["name"],
      price: map["price"],
      id: map["id"],
      speed: map["speed"],
      image: map["image"],
      year: map["year"],
    );
  }

  Map toJson(CarModel car) {
    return {
      "name": car.name,
      "price": car.price,
      "speed": car.speed,
      "image": car.image,
      "year": car.year,
    };
  }
}
