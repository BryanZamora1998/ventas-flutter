// /// Flutter code sample for AlertDialog
//
// // This demo shows a [TextButton] which when pressed, calls [showDialog]. When called, this method
// // displays a Material dialog above the current contents of the app and returns
// // a [Future] that completes when the dialog is dismissed.
//
// import 'package:flutter/material.dart';
//
// /// This is the stateless widget that the main application instantiates.
// class DialogAlert extends StatelessWidget {
//
//   String descripcion;
//   DialogAlert({Key? key,required this.descripcion}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//           title: const Text('Alerta'),
//           content: Text(this.descripcion),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Cancelar'),
//             ),
//             TextButton(
//               onPressed: () =>Navigator.of(context).pop(),
//               child: const Text('OK'),
//             ),
//           ],
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogAlert {

  final BuildContext _context;

  DialogAlert(this._context);


  /// Abrir carga
  void show(String descripcion) {
    showDialog(
      context: _context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alerta'),
          content: Text(descripcion),
          actions: <Widget>[
            TextButton(
              onPressed: () { Navigator.of(context).pop(true); },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () { Navigator.of(context).pop(true); },
              child: const Text('OK'),
            ),
          ],
        );
      }
    );
  }
}


