import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:meditation/pages/welcome/welcome_page.dart';
import 'package:meditation/utils/app_colors.dart';
import 'package:meditation/utils/app_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../connectivity/connection_singleton.dart';
import '../utils/routes.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // ignore: unused_field
  StreamSubscription? _connectionChangeStream;
    Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
  startTime() async {
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token2");
    if (token == null) {
      Navigator.pushNamedAndRemoveUntil(
          context, MyRoutes.welcome, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, MyRoutes.homeRoute, (route) => false);
    }
  }
@override
  void initState() {
    
    super.initState();
    //navigationPage();
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
        connectionStatus.initialize();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
    startTime();

  }
void connectionChanged(dynamic hasConnection) {
    if (hasConnection) {
     log('Connected'); 
    } else {
    log('no connection');
    }
}
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash:Image.asset(AppImages.splashicon) , 
      splashIconSize: 200,
      nextScreen: WelcomePage(),
      splashTransition: SplashTransition.scaleTransition,
      duration: 100,
      backgroundColor: AppColors.appColor,
      animationDuration: const Duration(seconds: 2),
      disableNavigation: true,
      //pageTransitionType:PageTransitionType.scale, ,
    );
  }
}