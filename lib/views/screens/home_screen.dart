import 'package:cars_list/controller/car_controller.dart';
import 'package:cars_list/models/car_model.dart';
import 'package:cars_list/views/widgets/show_dilalog_for_add.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarController carController = CarController();
  List<CarModel> cars = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Mahshinalar Royhati",
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await showDialog(
                context: context,
                builder: (context) {
                  return ShowDialogForAdd(carController: carController);
                },
              );
              if (result == true) {
                setState(() {});
              }
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: carController.getCarList(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          cars = snapshot.data ?? [];

          if (cars.isEmpty) {
            Center(child: Text("Malumot topilmadi"));
          }
          return ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(height: 20);
            },
            itemCount: cars.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                  width: 120,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(cars[index].image, fit: BoxFit.cover),
                ),
                title: Text(
                  cars[index].name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("\$${cars[index].price}"),
                    Text("Car make year ${cars[index].year}"),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
