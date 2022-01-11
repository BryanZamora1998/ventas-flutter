/// Flutter code sample for AlertDialog

// This demo shows a [TextButton] which when pressed, calls [showDialog]. When called, this method
// displays a Material dialog above the current contents of the app and returns
// a [Future] that completes when the dialog is dismissed.

import 'package:flutter/material.dart';

/// This is the stateless widget that the main application instantiates.
class CardAlert extends StatelessWidget {

  String descripcion;
  CardAlert({Key? key,required this.descripcion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tarjeta'),
      content: Text(this.descripcion),
      actions: <Widget>[

      ],
    );
  }
}