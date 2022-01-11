import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:venta/page/home/modulos/seguridad/seguridad.dart';
import 'package:venta/services/modulosService.dart';
import 'package:venta/util/cardAlert.dart';

int myIndex = 0;

class Modulos extends StatefulWidget {
  var index;
  Modulos({Key? key, required this.index}) : super(key: key);

  @override
  ModulosState createState() => ModulosState();
}

class ModulosState extends State<Modulos> {
  int _selectedDestination = 0;
  int index = 0;
  bool isParent = true;
  refresh() {
    setState(() {
      index = myIndex;
      isParent = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isParent == true) {
      index = widget.index;
    }

    isParent = true;

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
        body: index == 0 ? ModuloForm(notifyParent: refresh) : Seguridad());
  }
}

class ModuloForm extends StatefulWidget {
  final Function() notifyParent;

  ModuloForm({Key? key, required this.notifyParent}) : super(key: key);

  @override
  ModuloFormState createState() {
    return ModuloFormState();
  }
}

class ModuloFormState extends State<ModuloForm> {
  ModulosService _modulosService = new ModulosService();
  var json;

  Future<void> getModulos() async {
    json = await _modulosService.getModulos();
  }

  @override
  void initState() {
    super.initState();
    getModulos();
  }

  refresh() {
    setState(() {
      widget.notifyParent();
    });
  }

  @override
  build(BuildContext context) {
    return FutureBuilder(
        future: getModulos(),
        builder: (context, snapshot) {
          if (snapshot.hasData == ConnectionState.waiting) {
            return Center(child: Text('Espere por favor...'));
          } else {
            if (snapshot.hasError || json == null) {
              return Text("");
            } else {
              Map<String, dynamic> data = jsonDecode(json);

              if (data['code'] as int == 200) {
                final children = <Widget>[];
                data['data'].forEach((subItem) {
                  children.add(new ItemModuloForm(
                      nombre: subItem['nombre'],
                      img: "assets/ventas.png",
                      notifyParent: refresh));
                });

                return ListView(
                  padding: EdgeInsets.only(top: 40),
                  children: children,
                );
              } else if (data['code'] as int == 400) {
                return CardAlert(descripcion: data['message']);
              } else {
                return Text("");
              }
            }
          }
        });
  }
}

class ItemModuloForm extends StatefulWidget {
  final String nombre;
  final String img;
  final Function() notifyParent;

  const ItemModuloForm(
      {Key? key,
      required this.nombre,
      required this.img,
      required Function() this.notifyParent})
      : super(key: key);

  @override
  ItemModuloFormState createState() {
    return ItemModuloFormState();
  }
}

class ItemModuloFormState extends State<ItemModuloForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: InkWell(
                onTap: () {
                  setState(() {
                    myIndex = 1;
                  });
                  widget.notifyParent();
                },
                child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListView(
                      children: [
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                              color: Colors.blue,
                              style: BorderStyle.solid,
                              width: 1.0,
                            )),
                          ),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(widget.nombre)),
                        ),
                        Center(
                            child: Container(
                                height: 70,
                                child: Image(
                                  image: AssetImage(widget.img),
                                  width: 40,
                                  height: 40,
                                )))
                      ],
                    )))));
  }
}
