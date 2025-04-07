import 'package:cars_list/controller/car_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class ShowDialogForAdd extends StatefulWidget {
  CarController carController;
  ShowDialogForAdd({super.key, required this.carController});

  @override
  State<ShowDialogForAdd> createState() => _ShowDialogForAddState();
}

class _ShowDialogForAddState extends State<ShowDialogForAdd> {
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
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        spacing: 20,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: Colors.green.withOpacity(0.2),
            child: Icon(Icons.car_repair, color: Colors.blue, size: 42),
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
                        : 
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  if (chekTextController()) {
                    await widget.carController.addTodo(
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
                      SnackBar(content: Text("Malumotlarni kiriting !....")),
                    );
                  }
                },

                child:CircleAvatar(
                          radius: 38,
                          backgroundColor: Colors.grey.withOpacity(0.2),
                          child: Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 38,
                          ),
                        ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
