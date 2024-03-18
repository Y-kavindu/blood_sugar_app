import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Blood Sugar App",
      home: InputScreen(),
      getPages: [
        GetPage(name: '/result', page: () => const ResultScreen()),
      ],
    );
  }
}

class InputScreen extends StatelessWidget {
  final TextEditingController beforeController = TextEditingController();
  final TextEditingController afterController = TextEditingController();

  InputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar
      appBar: AppBar(
        title: const Text("Test Your Blood Sugar"),
        backgroundColor: Color.fromARGB(255, 50, 134, 230),
        actions: [
          Icon(Icons.menu),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
    
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 98, 93, 179),
              ),
             
              child: const Padding(
                padding: EdgeInsets.all(2.0),
                child: Text(
                  'Transform Your Health, One Glucose Reading at a Time: Glu-coSense',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            // add 1st image 
            Image.asset(
              "assets/415.jpg",
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
            // sizebox
            const SizedBox(height: 20),
            // add input
            Padding(
              padding: const EdgeInsets.all(17.0),
            
              child: TextField(
                controller: beforeController,
                decoration: InputDecoration(
          
                  labelText: "Enter your before blood sugar level",
                  hintText: "e.g. 100",
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: Color.fromARGB(255, 6, 154, 240),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: TextField(
                controller: afterController,
                decoration: InputDecoration(
                  labelText: "Enter your after blood sugar level",
                  hintText: "e.g. 10",
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: Color.fromARGB(255, 6, 154, 240),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            // add button
            ElevatedButton(
              
              onPressed: () {
                double before = double.tryParse(beforeController.text) ?? 0;
                double after = double.tryParse(afterController.text) ?? 0;
                Get.toNamed('/result', arguments: {'before': before, 'after': after});
              },
              child: Text('Validate'),
            ),
          ],
        ),
      ),
    );
  }
}
// result screen
class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) ;
//add condition
  String determineCategory(double before, double after) {
    if (before == 0 || after == 0) {
      return 'Invalid Data';
    }

    if (before >= 80 && before <= 130) {
      if (after < 180) {
        return 'Normal';
      }
    }

    if (before >= 90 && before <= 130) {
      if (after >= 90 && after <= 150) {
        return 'Children with type 1 diabetes';
      }
    }

 

    return 'Other';
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final before = arguments['before'] ?? 0;
    final after = arguments['after'] ?? 0;

    String category = determineCategory(before, after);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 50, 134, 230),
        title: const Text('Result'),
       
        
      ),
      
       body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            // add 2nd image
            Image.asset(
              "assets/3.png",
              height: 250,
              width: 350,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 10, 143, 220),
              ),
              child: Center(
                child: Text(
                  'Category: $category',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}