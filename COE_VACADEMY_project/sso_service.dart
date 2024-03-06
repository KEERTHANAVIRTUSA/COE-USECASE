import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SSOService {
  final String clientId;
  final String redirectUri;
  final String authorizeUrl;
  final String tokenUrl;

  SSOService({
    required this.clientId,
    required this.redirectUri,
    required this.authorizeUrl,
    required this.tokenUrl,
  });

  Future<void> signIn(BuildContext context) async {
    final flutterWebviewPlugin = new FlutterWebviewPlugin();

    flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      if (url.startsWith(redirectUri)) {
        flutterWebviewPlugin.close();
        final code = Uri.parse(url).queryParameters['code'];
        final response = await http.post(
          tokenUrl,
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {
            'client_id': clientId,
            'client_secret': 'YOUR_CLIENT_SECRET',
            'code': code!,
            'redirect_uri': redirectUri,
            'grant_type': 'authorization_code',
          },
        );
        final accessToken = json.decode(response.body)['access_token'];

        // Use the accessToken to fetch user data or validate
        // Here we assume the response has an email field
        final emailResponse = await http.get(
          'https://api.sso_provider.com/user',
          headers: {'Authorization': 'Bearer $accessToken'},
        );
        final email = json.decode(emailResponse.body)['email'];

        // Call your AdminBloc or set the user data
        // adminBloc.add(SSOLoginSuccess(email));
      }
    });

    flutterWebviewPlugin.launch(
      authorizeUrl +
          '?client_id=$clientId&redirect_uri=$redirectUri&response_type=code',
      clearCookies: true,
      hidden: true,
      rect: Rect.fromLTWH(0, 0, 0, 0),
    );
  }
}
