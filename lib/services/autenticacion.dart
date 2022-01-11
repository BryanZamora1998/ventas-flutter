import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:venta/environmentConfig/url.dart';

import 'package:http/http.dart' as http;

class Autenticacion{
  Url _url=new Url();

  /**
   *Usuario inicia sesion
   *
   * @author Bryan Zamora
   * @param strUsuario
   * @param strPassword
   */
  dynamic postAutenticacion(String strUsuario,String strPassword) async {
    String credentials=strUsuario+":"+strPassword;
    Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);
    String encoded = stringToBase64Url.encode(credentials);
    final response =
    await http.post(Uri.parse(_url.URL_API_SPRING+'/autenticacion/login'),
      headers: <String, String>{
        'Authorization': "Basic "+encoded,
      },
      body: null
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    if (data['code'] as int == 200) {
      final LocalStorage storage = new LocalStorage("auth");
      storage.setItem('data',data['data']);
    }
    return response.body;
  }
}