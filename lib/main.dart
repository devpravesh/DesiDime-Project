import 'dart:developer';

import 'package:desidime/controller/controller.dart';
import 'package:desidime/view/popular.dart';
import 'package:desidime/view/top.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DesiDime',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DefaultTabController(length: 3, child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deals"),
        actions: [
          MaterialButton(
            onPressed: () {
              _controller.fetchTopdeal();
            },
            color: Colors.red,
          ),
          MaterialButton(
            onPressed: () {
              log(_controller.topdeals[0].deals![0].imageMedium.toString());
            },
            color: Colors.green,
          )
        ],
        bottom: TabBar(
          tabs: [
            const Tab(text: "TOP"),
            Tab(
              text: "Popular".toUpperCase(),
            ),
            Tab(
              text: "Featured".toUpperCase(),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("Pravesh Vishwakarma"),
              accountEmail: Text("pravesh2655@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.purple,
                child: Text(
                  "P",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.support),
              title: const Text("Support"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          Top(),
          Popular(),
          Icon(Icons.directions_bike),
        ],
      ),
    );
  }
}
