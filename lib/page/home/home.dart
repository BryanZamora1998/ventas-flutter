import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:venta/page/home/modulos/seguridad/seguridad.dart';

import 'modulos/modulos.dart';

class Home extends StatefulWidget {
  @override
  HomeFormState createState() {
    return HomeFormState();
  }
}

class HomeFormState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: "hola");
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  child: Column(children: <Widget>[
                Image(
                  image: AssetImage('assets/Avatar_Male_4.png'),
                  width: 100,
                  height: 100,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text("Bryan Zamora"))
              ])),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Módulos'),
                onTap: () {
                  item(0);
                },
              ),
              ListTile(
                  leading: Icon(Icons.shield),
                  title: Text('Seguridad'),
                  onTap: () {
                    item(1);
                  })
            ],
          ),
        ),
        body: Modulos(index: this.index));
  }

  item(index) {
    setState(() {
      this.index = index;
    });
  }
}
