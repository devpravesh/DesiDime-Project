import 'package:desidime/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Top extends StatefulWidget {
  const Top({super.key});

  @override
  State<Top> createState() => _TopState();
}

var _controller = Get.find<MyController>();

class _TopState extends State<Top> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _controller.topdeals[0].deals!.length,
      itemBuilder: (context, index) => Card(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.15,
              width: Get.width * 0.9,
              child: Row(children: [
                Image.network(_controller.topdeals[0].deals![index].imageMedium
                    .toString()),
                const Text("Some Name of Product")
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.comment,
                    size: 20,
                  ),
                  Text(_controller.topdeals[0].deals![index].commentsCount
                      .toString())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
