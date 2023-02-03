import 'dart:developer';

import 'package:desidime/models/topmodel.dart';
import 'package:desidime/services/services.dart';
import 'package:get/get.dart';

class MyController extends GetxController {
  var topdeals = <TopModel>[].obs;
  fetchTopdeal() async {
    var response = await Services.fetchTopDeals();
    if (response != null) {
      topdeals.assign(response);
    }
  }
}
