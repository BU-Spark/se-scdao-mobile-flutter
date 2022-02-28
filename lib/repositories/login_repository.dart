import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:scdao_mobile/constants/api_constants.dart';
import 'package:scdao_mobile/models/token.dart';

class LoginRepository {
  var url = Uri.parse("$BASE_API_URL/token");
  Future<http.Response> login(String username, String password) async {
    Map<String, String> bodyParams = new Map();
    bodyParams["username"] = username;
    bodyParams["password"] = password;
    Map<String, String> headersMap = new Map();
    headersMap["content-type"] = "application/x-www-form-urlencoded";

    final http.Response res = await http
        .post(url, headers: headersMap, body: bodyParams, encoding: Utf8Codec())
        .then((res) {
      if (res.statusCode == 200) {
        print(res.body);
        return res;
      } else {
        print("error");
        return res;
      }
    });

    return res;
  }
}

final loginStateProvider =
    StateNotifierProvider<LoginAsyncNotifier, AsyncValue<Token>>(
        (ref) => LoginAsyncNotifier(ref));

class LoginAsyncNotifier extends StateNotifier<AsyncValue<Token>> {
  LoginAsyncNotifier(this.ref) : super(AsyncLoading()) {
    _init();
  }
  final Ref ref;

  void _init() async {
    state = AsyncValue.error(0);
  }

  Future<void> login(String username, String password) async {
    var url = Uri.parse("$BASE_API_URL/token");
    Map<String, String> bodyParams = new Map();
    bodyParams["username"] = username;
    bodyParams["password"] = password;
    Map<String, String> headersMap = new Map();
    headersMap["content-type"] = "application/x-www-form-urlencoded";
    final http.Response res = await http.post(url,
        headers: headersMap, body: bodyParams, encoding: Utf8Codec());

    if (res.statusCode != 200) {
      // Some error
      // state = AsyncValue.error(res.statusCode);
      state = AsyncData(new Token(token: "dummy_token"));
    } else {
      // Update state with token
      var json = jsonDecode(res.body);
      var token = Token.fromJson(json);
      state = AsyncData(token);
    }
  }
}
