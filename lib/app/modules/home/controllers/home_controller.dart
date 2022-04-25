import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../services/videocall_services.dart';

class HomeController extends GetxController {
  final channelTextController = TextEditingController();
  bool _inAsyncCall = false;

  bool get inAsyncCall => _inAsyncCall;
  set inAsyncCall(bool inAsyncCall) => {_inAsyncCall = inAsyncCall, update()};

  Future<void> joinChannel() async {
    try {
      if (channelTextController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter channle name');
        return;
      }

      final uid = Random.secure().nextInt(1000000);

      inAsyncCall = true;
      final token = await VideocallServices().getToken(
        channelName: channelTextController.text,
        uid: uid,
      );
      inAsyncCall = false;

      if (token == null) {
        Get.snackbar('Error', 'Failed to get token');
        return;
      }

      Get.toNamed(Routes.CALL_SCREEN, arguments: {
        'channel': channelTextController.text,
        'token': token,
        'uid': uid,
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to get token');
    }
  }
}
