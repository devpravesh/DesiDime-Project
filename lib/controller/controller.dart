import 'dart:developer';

import 'package:desidime/services/services.dart';
import 'package:get/get.dart';

class MyController extends GetxController {
  fetchTopdeal() async {
    var response = await Services.fetchTopDeals();
    // log(response.toString());
  }
}
