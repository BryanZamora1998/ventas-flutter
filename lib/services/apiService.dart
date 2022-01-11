import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:venta/environmentConfig/url.dart';
import 'package:http/http.dart' as http;

class ApiService{

  Url _url=new Url();

  dynamic ApiCallSpring(String method,String endpoint,data,headers) async {

    if(headers!=null){

    }else{
      headers={
        'Authorization': "Bearer "+await getToken(),
        'Accept-Language': 'es'
      };
    }

    switch (method) {
      case "GET":
        return await http.get(Uri.parse(_url.URL_API_SPRING+endpoint),headers: headers);
      case "POST":
        return await http.post(Uri.parse(_url.URL_API_SPRING+endpoint),headers: headers,body:data);
      case "PUT":
        return await http.put(Uri.parse(_url.URL_API_SPRING+endpoint),headers: headers,body:data);
      case "DELETE":
        return await http.delete(Uri.parse(_url.URL_API_SPRING+endpoint),headers: headers,body:data);
    }
    return null;
  }

  getToken() async{
    final LocalStorage storage = new LocalStorage('auth');
    Map<String, dynamic> data = storage.getItem('data');
    return await data['token'];
  }

}