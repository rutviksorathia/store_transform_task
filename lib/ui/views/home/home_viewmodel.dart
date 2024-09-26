import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:store_transform_task/models/employee/apiEmployeeStatusGet.dart';
import 'package:store_transform_task/ui/utils/toast.dart';

enum ScreenShow {
  login,
  break_in,
  break_out,
}

enum BreakType {
  lb,
  sb,
  logout,
}

class HomeViewModel extends BaseViewModel {
  TextEditingController employeeCodeController = TextEditingController();

  ScreenShow selectedScreenShow = ScreenShow.login;

  BreakType selectedBreakType = BreakType.lb;

  Future<void> handleSubmitButtonTap() async {
    try {
      setBusyForObject(handleSubmitButtonTap, true);

      ApiEmployeeStatusGetRequestBody? body;

      if (selectedScreenShow == ScreenShow.login) {
        body = ApiEmployeeStatusGetRequestBody(
          empCode: employeeCodeController.text,
        );
      } else if (selectedScreenShow == ScreenShow.break_in) {
        if (selectedBreakType == BreakType.logout) {
          body = ApiEmployeeStatusGetRequestBody(
            empCode: employeeCodeController.text,
            logout: "Yes",
          );
        } else {
          body = ApiEmployeeStatusGetRequestBody(
            empCode: employeeCodeController.text,
            breakStatus: "IN",
            empBreak: selectedBreakType.name,
          );
        }
      } else {
        body = ApiEmployeeStatusGetRequestBody(
          empCode: employeeCodeController.text,
          breakStatus: "OUT",
          empBreak: selectedBreakType.name,
        );
      }

      var response = await apiEmployeeStatusGet(
        body: body,
      );

      showToast(text: response.message);

      if (response.message == "Already logged IN") {
        selectedScreenShow = ScreenShow.break_in;
      } else if (response.message == "Your are In Long Break") {
        selectedScreenShow = ScreenShow.break_out;
        selectedBreakType = BreakType.lb;
      } else if (response.message == "Your are In Short Break") {
        selectedScreenShow = ScreenShow.break_out;
        selectedBreakType = BreakType.sb;
      } else {
        selectedScreenShow = ScreenShow.login;
        employeeCodeController.clear();
      }
      notifyListeners();
    } catch (e) {
      showToast(text: e.toString());
    } finally {
      setBusyForObject(handleSubmitButtonTap, false);
    }
  }
}
