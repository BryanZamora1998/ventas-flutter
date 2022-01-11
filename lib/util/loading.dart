
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading {
  final BuildContext _context;

  Loading(this._context);

  /// Abrir carga
  void show({Function? onClosed}) {
    showDialog(
      context: _context,
      builder: (context) {
        return Container(
            child: Image.asset(
                'assets/loading.gif', scale: 10, width: 100, height: 200)
        );
      },
    ).then((value) {
      onClosed!(value);
    });
  }

  /// Cerrar carga
  void close() {
    Navigator.of(_context).pop();
  }
}

