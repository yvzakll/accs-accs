import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_generator/homePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool _isPlaying = false;
  AnimationController _animationController;
  Animation<double> _pulseAnimation;
  Animation<double> _opacityAnimation;
  @override
  void initState() {
    void animate() {
      if (_isPlaying)
        _animationController.stop();
      else
        _animationController.forward();

      setState(() {
        _isPlaying = !_isPlaying;
      });
    }

    super.initState();
    //_navigateToHome();

    Timer(
      const Duration(milliseconds: 3000),
      () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          )),
    );
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2700));

    _pulseAnimation = Tween<double>(begin: 5.0, end: 5.5).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));

    _opacityAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _pulseAnimation.addStatusListener((status) {
      // if (status == AnimationStatus.completed)
      //   _animationController.reverse();
      // else if (status == AnimationStatus.dismissed)
      //   _animationController.forward();
      _animationController.forward();
    });

    animate();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /*  _navigateToHome() async {
    await Future.delayed(
      const Duration(milliseconds: 2000),
      () {},
    );
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
  } */

  @override
  Widget build(BuildContext context) {
    Color appcolor = const Color.fromRGBO(58, 66, 86, 1.0);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: appcolor,
        body: Center(
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: ScaleTransition(
              scale: _pulseAnimation,
              child: Image.asset(
                "assets/images/logo.png",
                height: 30,
                width: 50,
              ),
            ),
          ),
        ),

        /* Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: FadeTransition(
            opacity: _opacityAnimation,
            child: ScaleTransition(
                scale: _pulseAnimation,
                child: Image.asset(
                  "assets/images/ERPMOBILE.png",
                  height: 25,
                  width: 55,
                )),
          )),
        ), */
      ),
    );
  }

/*Image.asset(
              "assets/images/ERPMOBILE.png",
              height: 120,
              width: 250,
            ),*/
  Future<bool> _onWillPop() {
    return Future.value(false);
  }
}
