import 'package:cars_list/controller/car_controller.dart';
import 'package:cars_list/models/car_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class ShowDialogForEdit extends StatefulWidget {
  CarModel carModel;
  CarController carController;
  ShowDialogForEdit({
    super.key,
    required this.carController,
    required this.carModel,
  });

  @override
  State<ShowDialogForEdit> createState() => _ShowDialogForEditState();
}

class _ShowDialogForEditState extends State<ShowDialogForEdit> {
  bool isLoading = false;
  TextEditingController textControllerName = TextEditingController();
  TextEditingController textControllerImage = TextEditingController();
  TextEditingController textControllerPrice = TextEditingController();
  TextEditingController textControllerYear = TextEditingController();
  TextEditingController textControllerSpeed = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    textControllerName.dispose();
    textControllerImage.dispose();
    textControllerPrice.dispose();
    textControllerYear.dispose();
  }

  bool chekTextController() {
    if (textControllerImage.text.isNotEmpty &&
        textControllerName.text.isNotEmpty &&
        textControllerPrice.text.isNotEmpty &&
        textControllerYear.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    CarModel car = widget.carModel;
    textControllerImage.text = car.image;
    textControllerName.text = car.name;
    textControllerPrice.text = car.price.toString();
    textControllerSpeed.text = car.speed.toString();
    textControllerYear.text = car.year.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          spacing: 20,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 42,
              backgroundColor: Colors.green.withOpacity(0.2),
              child: Icon(Icons.car_repair, color: Colors.blue, size: 42),
            ),
            Text(
              "Kerakli Joyini O'zgartiring",
              style: TextStyle(
                color: Colors.amber,
                fontSize: 37,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: textControllerImage,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.car_crash),

                hintText: "Car Image... [Net-Work]",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
            TextField(
              controller: textControllerName,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.car_crash),
                hintText: "Car Name...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),

            TextField(
              controller: textControllerPrice,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.car_crash),

                hintText: "Car Price...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),

            TextField(
              controller: textControllerYear,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.car_crash),

                hintText: "Car Year...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
            TextField(
              controller: textControllerSpeed,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.car_crash),

                hintText: "Car Speed...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    dispose();
                  },
                  child: CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    child: Icon(Icons.close, color: Colors.red, size: 38),
                  ),
                ),
                isLoading
                    ? CircularProgressIndicator()
                    : GestureDetector(
                      onTap: () async {
                        if (chekTextController()) {
                          setState(() {
                            isLoading = true;
                          });
                          await widget.carController.editCar(
                            id: widget.carModel.id,
                            image: textControllerImage.text,
                            name: textControllerName.text,
                            price: double.parse(textControllerPrice.text),
                            speed: int.parse(textControllerSpeed.text),
                            year: int.parse(textControllerYear.text),
                          );

                          setState(() {
                            isLoading = false;
                            Navigator.pop(context, true);
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Malumotlarni kiriting !...."),
                            ),
                          );
                        }
                      },

                      child: CircleAvatar(
                        radius: 38,
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        child: Icon(Icons.check, color: Colors.green, size: 38),
                      ),
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
