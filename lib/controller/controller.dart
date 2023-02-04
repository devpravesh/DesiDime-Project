import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:desidime/models/popularmodel.dart';
import 'package:desidime/models/topmodel.dart';
import 'package:desidime/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyController extends GetxController {
  var connectionType = 0.obs;

  final Connectivity _connectivity = Connectivity();
  RxBool isLoading = true.obs;
  RxBool isLoad = false.obs;
  late StreamSubscription _streamSubscription;
  var currentPage = 1.obs;
  var currentPageofpopular = 1.obs;
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 5.0);
  ScrollController scrollControllerpopular =
      ScrollController(initialScrollOffset: 5.0);
  var topdeals = <TopModel>[].obs;
  var populardeals = <PopularModel>[].obs;
  // SharedPreferences shared_User = await SharedPreferences.getInstance();
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
// Map decode_options = jsonDecode(jsonString);
// String user = jsonEncode(User.fromJson(decode_options));
// shared_User.setString('user', user);

  @override
  void onInit() {
    super.onInit();
    fetchTopdeal();
    scrollindecator();
    scrollindecatorpopular();
    fetchPopulardeal();
    getConnectivityType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }

  void scrollindecator() {
    log("scrolle");
    scrollController.addListener(
      () {
        if (scrollController.offset ==
            scrollController.position.maxScrollExtent) {
          try {
            currentPage++;
            log(currentPage.toString());
          } finally {
            loadMore(currentPage.value);
          }
        }
      },
    );
  }

  void scrollindecatorpopular() {
    log("scrolle");
    scrollControllerpopular.addListener(
      () {
        if (scrollControllerpopular.offset ==
            scrollControllerpopular.position.maxScrollExtent) {
          try {
            currentPageofpopular++;
            log(currentPageofpopular.toString());
          } finally {
            loadMorepopular(currentPageofpopular.value);
          }
        }
      },
    );
  }

  void loadMorepopular(int currentpage) async {
    try {
      isLoad(true);
      var resp = await Services().fetchPopularDeals(currentpage);
      if (resp != null) {
        // print(resp.deals);
        populardeals[0].deals!.addAll(resp.deals);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoad(false);
    }
  }

  void loadMore(int currentpage) async {
    try {
      isLoad(true);
      var resp = await Services().fetchTopDeals(currentpage);
      if (resp != null) {
        // print(resp.deals);
        topdeals[0].deals!.addAll(resp.deals);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoad(false);
    }
  }

  Future<void> getConnectivityType() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return _updateState(connectivityResult);
  }

  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;

        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        break;
      default:
        Fluttertoast.showToast(msg: 'Failed to get connection type');
        break;
    }
  }

// }

  fetchTopdeal() async {
    try {
      isLoading(true);
      var response = await Services().fetchTopDeals(1);
      if (response != null) {
        topdeals.assign(response);
      }
    } finally {
      isLoading(false);
    }
  }

  fetchPopulardeal() async {
    try {
      isLoading(true);
      var response = await Services().fetchPopularDeals(1);
      if (response != null) {
        populardeals.assign(response);
      }
    } finally {
      isLoading(false);
    }
  }
}
