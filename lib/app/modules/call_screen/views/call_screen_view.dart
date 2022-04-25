import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_call_v2/app/routes/app_pages.dart';

import '../controllers/call_screen_controller.dart';

class CallScreenView extends GetView<CallScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: controller.initAgoraClient,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Stack(
                children: [
                  AgoraVideoViewer(client: controller.client),
                  AgoraVideoButtons(
                    client: controller.client,
                    enabledButtons: [
                      BuiltInButtons.switchCamera,
                      BuiltInButtons.toggleCamera,
                      BuiltInButtons.toggleMic,
                    ],
                    extraButtons: [
                      FloatingActionButton(
                        child: Icon(Icons.videocam_off),
                        onPressed: () {
                          controller.client.sessionController.endCall();
                          WidgetsBinding.instance?.addPostFrameCallback((_) {
                            Get.offNamedUntil(Routes.HOME, (route) => false);
                          });
                          // Get.back();
                        },
                      ),
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}
