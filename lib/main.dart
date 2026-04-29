import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "User Profile App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  String name = "No Name";
  String age = "No Age";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // LOAD DATA
  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? "No Name";
      age = prefs.getString('age') ?? "No Age";
    });
  }

  // SAVE DATA
  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('age', ageController.text);

    loadData();
  }

  // CLEAR DATA
  void clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.purple.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      // TITLE
                      Text(
                        "User Profile",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 20),

                      // NAME FIELD
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      // AGE FIELD
                      TextField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Age",
                          prefixIcon: Icon(Icons.cake),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      // SAVE BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            saveData();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Data Saved")),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text("Save Data"),
                        ),
                      ),

                      SizedBox(height: 10),

                      // CLEAR BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            clearData();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Data Cleared")),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text("Clear Data"),
                        ),
                      ),

                      SizedBox(height: 20),

                      Divider(),

                      SizedBox(height: 10),

                      // DISPLAY DATA
                      Text(
                        "Saved Data",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Name: $name",
                        style: TextStyle(fontSize: 16),
                      ),

                      Text(
                        "Age: $age",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}