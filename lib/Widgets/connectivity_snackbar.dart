import 'package:bk_reader_v2/Providers/home.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../Providers/Connectivity_provider.dart';
import 'package:provider/provider.dart';
import '../Services/snackbar.dart';

class InternetConnectivity {
  static void showConnectivitySnackBar(ConnectivityResult result,
      {required BuildContext context}) {
    final hasInterenet = result != ConnectivityResult.none;
    final message = hasInterenet
        ? 'We got Wi-Fi connection back'
        : 'We have lost internet connection';
    final color = hasInterenet ? Colors.green : Colors.red;
    final backgroundColor = hasInterenet
        ? Color.fromARGB(255, 213, 251, 213)
        : Color.fromARGB(255, 252, 208, 205);
    if (hasInterenet == false) {
      Provider.of<ConnectivityProv>(context, listen: false)
          .setHasEntredApp(true);
    }
    if (hasInterenet == false) {
      Provider.of<HomeProv>(context, listen: false).setIsSuccess(false);
    }
    if ((Provider.of<ConnectivityProv>(context, listen: false).hasEntredApp() ==
        true)) {
      Utils.showTopSnackBar(context, message, color, backgroundColor);
    }
  }
}
