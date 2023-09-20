import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:tistepsdemo/splash.dart';
import 'package:tistepsdemo/userlist/UserList.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Colors.pink, // Set your desired primary color
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: const Color(0xffe0e0e0),
        scaffoldBackgroundColor: const Color(0xffeef6f6),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff007399),
        ),
      ),

      routes: {
        '/': (context) =>
        const Splashscreen(), // Set the splash screen as the initial route
        '/home': (context) =>
            UserListing(), // Replace with your home screen route
      },
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      //    home: LoginScreen(),
      //   home: pendingScreen(),
    );
  }
}

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // debugShowCheckedModeBanner: false,

     // backgroundColor: const Color.fromARGB(255, 250, 255, 250),
          backgroundColor: const Color(0xFFFFFFFF),
       // backgroundColor: const Color(0xFFF7FFE5),
      body: Stack(
        children: <Widget>[
          Center(
              child: WidgetRingAnimator(
                size: 120,
                ringIcons: const [
                ],
                ringIconsSize: 3,
                //   ringIconsColor: Colors.grey[200],
                ringAnimation: Curves.linear,
                ringColor: Colors.green,
                reverse: false,
                ringAnimationInSeconds: 10,
                child: Container(
                  child: Material(
                    elevation: 8.0,
                    shape: const CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        'assets/download.png',
                       // color: Colors.green,
                        height: 65,
                      ),
                      radius: 45.0,
                    ),
                  ),
                ),
              )),
          Center(
            child: AvatarGlow(
              glowColor: Colors.orangeAccent,
              endRadius: 200.0,
              duration: const Duration(milliseconds: 1000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: const Duration(milliseconds: 100), child: Container(),

              
            ),
          ),
        ],
      ),
    );
  }
}


