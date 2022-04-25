import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          TextFormField(
            controller: controller.channelTextController,
            decoration: InputDecoration(
              labelText: 'Channel Name',
            ),
          ),
          GetBuilder<HomeController>(
            builder: (_) {
              return ElevatedButton(
                onPressed: _.inAsyncCall ? null : _.joinChannel,
                child: _.inAsyncCall
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(),
                      )
                    : Text('Join Channel'),
              );
            },
          )
        ],
      ),
    );
  }
}
