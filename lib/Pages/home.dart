import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../Widgets/connectivity_snackbar.dart';
import '../Widgets/home_body.dart';

class HomeP extends StatefulWidget {
  const HomeP({super.key});
  @override
  State<HomeP> createState() => _HomePState();
}

class _HomePState extends State<HomeP> {
late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
        subscription = Connectivity().onConnectivityChanged.listen(showSnackBar);
  }
  
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        body:HomeBodyW()
      ),
    );
  }
   void showSnackBar(ConnectivityResult res) {
    InternetConnectivity.showConnectivitySnackBar(res, context: context);
  }
}
