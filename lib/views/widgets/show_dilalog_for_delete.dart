import 'package:cars_list/controller/car_controller.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShowDilalogForDelete extends StatefulWidget {
  String id;
  CarController carController;
  ShowDilalogForDelete({
    super.key,
    required this.carController,
    required this.id,
  });

  @override
  State<ShowDilalogForDelete> createState() => _ShowDialogForDeleteState();
}

class _ShowDialogForDeleteState extends State<ShowDilalogForDelete> {
  bool isLoading = false;

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

          Text(
            "You Realy Delete this date ",
            style: TextStyle(
              color: Colors.pinkAccent,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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
                  await widget.carController.deleteTodo(id: widget.id);
                  setState(() {
                    isLoading = true;
                    Navigator.pop(context, true);
                  });
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
