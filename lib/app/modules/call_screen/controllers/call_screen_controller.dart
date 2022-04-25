import 'package:agora_uikit/agora_uikit.dart';
import 'package:get/get.dart';
import 'package:video_call_v2/app/config/constants.dart';

class CallScreenController extends GetxController {
  late final AgoraClient client;
  late final String channeName;
  late final String token;
  late final int uid;

  late final Future initAgoraClient;

  @override
  void onInit() {
    channeName = Get.arguments['channel'] as String;
    token = Get.arguments['token'] as String;
    uid = Get.arguments['uid'] as int;

    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: APP_ID,
        channelName: channeName,
        tempToken: token,
        uid: uid,
      ),
      enabledPermission: [
        Permission.camera,
        Permission.microphone,
      ],
    );

    initAgoraClient = client.initialize();
    super.onInit();
  }
}
