# Exemple

## main.dart
```
import 'package:flutter/material.dart';
import 'package:deivao_drawer/deivao_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deivão Drawer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final drawerController = DeivaoDrawerController();

  @override
  Widget build(BuildContext context) {
    return DeivaoDrawer(
      controller: drawerController,
      drawer: _buildDrawer(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Deivão Drawer Exemple"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: drawerController.toggle,
          ),
        ),
        body: Center(child: Text("My Content")),
      ),
    );
  }

  ListView _buildDrawer() {
    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 50, bottom: 20),
          color: Colors.blue,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipOval(
                child: Image.network(
                  "https://avatars3.githubusercontent.com/u/16373553?s=460&v=4",
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "David Araujo",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                "davidsdearaujo@gmail.com",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        ListTile(leading: Icon(Icons.all_inclusive), title: Text("Item 1")),
        ListTile(leading: Icon(Icons.all_inclusive), title: Text("Item 2")),
        ListTile(leading: Icon(Icons.all_inclusive), title: Text("Item 3")),
        ListTile(leading: Icon(Icons.all_inclusive), title: Text("Item 4")),
      ],
    );
  }
}
```

## pubspec.yaml
```
name: exemple
description: Deivao drawer exemple

version: 1.0.0+1

environment:
  sdk: ">=2.1.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
    
  cupertino_icons: ^0.1.2
  deivao_drawer: ^1.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
```
