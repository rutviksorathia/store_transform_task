import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_corner/smooth_corner.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
    );
    final connectivityController = Get.find<ConnectivityController>();
    return Obx(
      () {
        if (!connectivityController.isConnected.value) {
          return const NoInternetView();
        }

        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  width: double.infinity,
                  color: Colors.black,
                ),
              ),
              Positioned(
                left: -60,
                top: -60,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: ShapeDecoration(
                    shape: SmoothRectangleBorder(
                      borderRadius: BorderRadius.circular(65),
                    ),
                    color: Colors.red,
                  ),
                ),
              ),
              Positioned(
                right: -60,
                bottom: -60,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: ShapeDecoration(
                    shape: SmoothRectangleBorder(
                      borderRadius: BorderRadius.circular(65),
                    ),
                    color: Colors.red,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 18,
                      right: 18,
                      top: MediaQuery.of(context).padding.top + 47,
                      bottom: MediaQuery.of(context).padding.bottom,
                    ),
                    child: OrientationBuilder(
                      builder: (context, orientation) {
                        return orientation == Orientation.portrait
                            ? PortraitView(viewModel: viewModel)
                            : LandscapeView(viewModel: viewModel);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class LandscapeView extends StatelessWidget {
  final HomeViewModel viewModel;
  const LandscapeView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                viewModel
                    .handleProfileCameraOrGalleryButtonTap(ImageSource.gallery);
              },
              child: Container(
                height: 300,
                width: 300,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: SmoothRectangleBorder(
                    borderRadius: BorderRadius.circular(150),
                  ),
                  color: Colors.grey.shade900,
                ),
                child: viewModel.profileImage != null
                    ? Image.file(
                        viewModel.profileImage!,
                      )
                    : const Icon(
                        Icons.camera_alt_outlined,
                        size: 60,
                        color: Color.fromRGBO(66, 66, 66, 1),
                      ),
              ),
            ),
            const SizedBox(width: 30),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 52,
                  ),
                  const SizedBox(height: 12),
                  if (viewModel.selectedScreenShow == ScreenShow.login)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Employee Code",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          color: Colors.grey.shade800,
                          child: TextFormField(
                            cursorColor: Colors.white,
                            controller: viewModel.employeeCodeController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else if (viewModel.selectedScreenShow == ScreenShow.break_in)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RadioMenuButton(
                          value: true,
                          groupValue:
                              viewModel.selectedBreakType == BreakType.lb,
                          onChanged: (val) {
                            viewModel.selectedBreakType = BreakType.lb;
                            viewModel.notifyListeners();
                          },
                          child: const Text(
                            "Long Break (In)",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        RadioMenuButton(
                          value: true,
                          groupValue:
                              viewModel.selectedBreakType == BreakType.sb,
                          onChanged: (val) {
                            viewModel.selectedBreakType = BreakType.sb;
                            viewModel.notifyListeners();
                          },
                          child: const Text(
                            "Short Break (In)",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        RadioMenuButton(
                          value: true,
                          groupValue:
                              viewModel.selectedBreakType == BreakType.logout,
                          onChanged: (val) {
                            viewModel.selectedBreakType = BreakType.logout;
                            viewModel.notifyListeners();
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      viewModel.selectedBreakType == BreakType.lb
                          ? "Long Break (Out)"
                          : "Short Break (Out)",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (!viewModel.busy(viewModel.handleSubmitButtonTap))
                    InkWell(
                      onTap: viewModel.handleSubmitButtonTap,
                      child: Container(
                        color: Colors.red,
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PortraitView extends StatelessWidget {
  final HomeViewModel viewModel;
  const PortraitView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: GestureDetector(
            onTap: () {
              viewModel
                  .handleProfileCameraOrGalleryButtonTap(ImageSource.gallery);
            },
            child: Container(
              height: 200,
              width: 200,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                color: Colors.grey.shade900,
              ),
              child: viewModel.profileImage != null
                  ? Image.file(
                      viewModel.profileImage!,
                    )
                  : const Icon(
                      Icons.camera_alt_outlined,
                      size: 60,
                      color: Color.fromRGBO(66, 66, 66, 1),
                    ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Image.asset(
          "assets/images/logo.png",
          height: 52,
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (viewModel.selectedScreenShow == ScreenShow.login)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Employee Code",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    color: Colors.grey.shade800,
                    child: TextFormField(
                      cursorColor: Colors.white,
                      controller: viewModel.employeeCodeController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else if (viewModel.selectedScreenShow == ScreenShow.break_in)
              Column(
                children: [
                  RadioMenuButton(
                    value: true,
                    groupValue: viewModel.selectedBreakType == BreakType.lb,
                    onChanged: (val) {
                      viewModel.selectedBreakType = BreakType.lb;
                      viewModel.notifyListeners();
                    },
                    child: const Text(
                      "Long Break (In)",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  RadioMenuButton(
                    value: true,
                    groupValue: viewModel.selectedBreakType == BreakType.sb,
                    onChanged: (val) {
                      viewModel.selectedBreakType = BreakType.sb;
                      viewModel.notifyListeners();
                    },
                    child: const Text(
                      "Short Break (In)",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  RadioMenuButton(
                    value: true,
                    groupValue: viewModel.selectedBreakType == BreakType.logout,
                    onChanged: (val) {
                      viewModel.selectedBreakType = BreakType.logout;
                      viewModel.notifyListeners();
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            else
              Text(
                viewModel.selectedBreakType == BreakType.lb
                    ? "Long Break (Out)"
                    : "Short Break (Out)",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            const SizedBox(height: 20),
            if (!viewModel.busy(viewModel.handleSubmitButtonTap))
              InkWell(
                onTap: viewModel.handleSubmitButtonTap,
                child: Container(
                  color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            else
              const CircularProgressIndicator(
                color: Colors.white,
              ),
          ],
        )
      ],
    );
  }
}
