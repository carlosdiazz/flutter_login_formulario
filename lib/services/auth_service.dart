import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseTOken = 'AIzaSyDHaMmD9tWgX8_fAv-xbH-K1bySaBAg8CY';
  final storage = FlutterSecureStorage();

  //Si retonarmos algo es un error
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseTOken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      //Token hay que guardar en un lugar seguro
      //return decodedResp['idToken'];
      storage.write(key: 'TOKEN', value: decodedResp['idToken']);
      return null;
      //return null;
    } else {
      print(decodedResp);
      return decodedResp['error']['message'];
    }
  }

  //Si retonarmos algo es un error
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseTOken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      //Token hay que guardar en un lugar seguro
      storage.write(key: 'TOKEN', value: decodedResp['idToken']);
      return null;
    } else {
      print(decodedResp);
      return decodedResp['error']['message'];
    }
  }

  Future logout() async {
    await storage.deleteAll();
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
