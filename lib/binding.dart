import 'package:desidime/controller/controller.dart';
import 'package:get/get.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MyController>(MyController());
  }
}
