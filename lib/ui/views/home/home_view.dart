import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:store_transform_task/services/connectivity_service.dart';
import 'package:store_transform_task/ui/views/no_internet/no_internet_view.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    final connectivityController = Get.find<ConnectivityController>();
    return Obx(
      () {
        if (!connectivityController.isConnected.value) {
          return const NoInternetView();
        }

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Container(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (viewModel.selectedScreenShow == ScreenShow.login)
                  TextField(
                    controller: viewModel.employeeCodeController,
                  )
                else if (viewModel.selectedScreenShow == ScreenShow.break_in)
                  Column(
                    children: [
                      RadioListTile(
                        value: true,
                        title: const Text(
                          "Long Break (In)",
                        ),
                        groupValue: viewModel.selectedBreakType == BreakType.lb,
                        onChanged: (val) {
                          viewModel.selectedBreakType = BreakType.lb;
                          viewModel.notifyListeners();
                        },
                      ),
                      RadioListTile(
                        value: true,
                        title: const Text(
                          "Short Break (In)",
                        ),
                        groupValue: viewModel.selectedBreakType == BreakType.sb,
                        onChanged: (val) {
                          viewModel.selectedBreakType = BreakType.sb;
                          viewModel.notifyListeners();
                        },
                      ),
                      RadioListTile(
                        value: true,
                        title: const Text(
                          "Logout",
                        ),
                        groupValue:
                            viewModel.selectedBreakType == BreakType.logout,
                        onChanged: (val) {
                          viewModel.selectedBreakType = BreakType.logout;
                          viewModel.notifyListeners();
                        },
                      ),
                    ],
                  )
                else
                  Text(
                    viewModel.selectedBreakType == BreakType.lb
                        ? "Long Break (Out)"
                        : "Short Break (Out)",
                  ),
                ElevatedButton(
                  onPressed: viewModel.handleSubmitButtonTap,
                  child: const Text(
                    "Submit",
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
