import 'dart:convert';

import 'package:store_transform_task/services/network_service.dart';

class ApiEmployeeStatusGetRequestBody {
  String empCode;
  String? empBreak;
  String? breakStatus;
  String? logout;

  ApiEmployeeStatusGetRequestBody({
    required this.empCode,
    this.empBreak,
    this.breakStatus,
    this.logout,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map["emp_code"] = empCode.toString();

    if (empBreak != null) {
      map["break"] = empBreak.toString();
    }
    if (breakStatus != null) {
      map["break-status"] = breakStatus.toString();
    }
    if (logout != null) {
      map["logout"] = logout.toString();
    }
    return map;
  }
}

Future<ApiEmployeeStatusGetResponseBody> apiEmployeeStatusGet(
    {required ApiEmployeeStatusGetRequestBody body}) async {
  var response = await sendRequest.post(
    "emp-code",
    body: body.toMap(),
  );

  return ApiEmployeeStatusGetResponseBody.fromMap(jsonDecode(response.body));
}

class ApiEmployeeStatusGetResponseBody {
  String message;
  String status;
  String? empCode;
  int userId;

  ApiEmployeeStatusGetResponseBody({
    required this.message,
    required this.status,
    this.empCode,
    required this.userId,
  });

  factory ApiEmployeeStatusGetResponseBody.fromMap(Map<String, dynamic> map) {
    return ApiEmployeeStatusGetResponseBody(
      message: map["message"],
      status: map["status"],
      empCode: map["emp_code"],
      userId: map["user_id"],
    );
  }
}
