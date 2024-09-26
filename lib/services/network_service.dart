import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_transform_task/ui/utils/toast.dart';

class NetworkService {
  String baseUrl =
      'https://woocommerceapp.setupstaging.com/wp-json/storetransform-hrms/';

  Future<http.Response> post(String path,
      {required Map<String, dynamic> body}) async {
    try {
      var res = await http
          .post(Uri.parse('$baseUrl$path'), body: json.encode(body), headers: {
        'Content-Type': 'application/json',
      });

      if (res.statusCode >= 200 && res.statusCode < 300) {
        return res;
      }

      throw res;
    } catch (e) {
      if (e is http.Response) {
        print(e.body);
        var parsedError = jsonDecode(e.body);
        showToast(
          text: '(${parsedError['statusCode']}) ${parsedError['message']}',
        );
      }
      rethrow;
    }
  }
}

NetworkService sendRequest = NetworkService();
