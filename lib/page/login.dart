import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:venta/services/autenticacion.dart';
import 'package:venta/util/dialogAlert.dart';
import 'package:venta/util/loading.dart';

import 'home/home.dart';

class Login extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final appTitle = 'Ventas';
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        home:
            Scaffold(body: Container(color: Colors.blue, child: LoginForm())));
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  Autenticacion _autenticacion = new Autenticacion();
  final _formKey = GlobalKey<FormState>();

  var strUsuario = TextEditingController();
  var strPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: <
        Widget>[
      Center(
          child: Container(
              margin: const EdgeInsets.all(50.0),
              color: Colors.blue,
              child: Image(
                image: AssetImage('assets/ventas.png'),
                width: 100,
                height: 100,
              ))),
      Expanded(
          child: Center(
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50)),
                  ),
                  child: Container(
                      margin: const EdgeInsets.only(left: 50.0, right: 50.0),
                      child: Form(
                          key: _formKey,
                          child: ListView(children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(top: 10.0),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text("¡Bienvenido!",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.blue))),
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Inicie Sesión",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue)))),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 19),
                                decoration: InputDecoration(
                                    labelText: "Ingrese su usuario",
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide())),
                                controller: strUsuario,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Por favor ingrese su usuario.";
                                  }
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(fontSize: 19),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Por favor ingrese su contraseña.";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Ingrese su Contraseña",
                                      prefixIcon: Icon(Icons.password),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide())),
                                  controller: strPassword,
                                  obscureText: true),
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: SizedBox(
                                  width: 250.0,
                                  height: 50.0,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      Loading _loading = new Loading(context);

                                      if (_formKey.currentState!.validate()) {
                                       _loading.show();
                                        var json = await postAutenticacion(
                                            strUsuario.text, strPassword.text);
                                        Map<String, dynamic> data =
                                            jsonDecode(json);
                                        if (data['code'] as int == 200) {
                                          _loading.close();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()),
                                          );
                                        } else {
                                          _loading.close();
                                          DialogAlert _dialogAlert =new DialogAlert(context);
                                          _dialogAlert.show(data['message']);
                                        }
                                      }
                                    },
                                    child: Text('Iniciar Sesión'),
                                    style: ElevatedButton.styleFrom(
                                      shape: BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                    ),
                                  ),
                                )),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: TextButton(
                                        onPressed: () {},
                                        child: Text("Recuperar Contraseña",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(fontSize: 15)))))
                          ]))))))
    ]);
  }

  /**
   * Inicia sesion
   *
   * @author Bryan Zamora
   * @param strUsuario
   * @param strPassword
   */
  postAutenticacion(String strUsuario, String strPassword) async {
    return await this._autenticacion.postAutenticacion(strUsuario, strPassword);
  }
}
