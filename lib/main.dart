import 'package:dash_bubble/dash_bubble.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workmanager/workmanager.dart';
import 'functions/functions.dart';
import 'functions/notifications.dart';
import 'pages/loadingPage/loadingpage.dart';
import 'package:firebase_core/firebase_core.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Your background task logic goes here
//  if(userData.userDetails.isNotEmpty){
//  GetUserData().currentPositionUpdate();
//  }
    try {
      await Firebase.initializeApp();
      var val = await Geolocator.getCurrentPosition();
      // ignore: prefer_typing_uninitialized_variables
      var id;
      if (inputData != null) {
        id = inputData['id'];
      }
      FirebaseDatabase.instance.ref().child('drivers/driver_$id').update({
        'lat-lng': val.latitude.toString(),
        'l': {'0': val.latitude, '1': val.longitude},
        'updated_at': ServerValue.timestamp
      });
      // ignore: empty_catches
    } catch (e) {}

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp();
  initMessaging();
  checkInternetConnection();

  currentPositionUpdate();

  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final platforms = const MethodChannel('flutter.app/awake');
  // This widget is the root of your application.

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Workmanager().cancelAll();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      if (userDetails.isNotEmpty &&
          userDetails['role'] == 'driver' &&
          userDetails['active'] == true) {
        // service.startService();
        updateLocation(10);
        startBubble(
          context,
          notificationOptions: NotificationOptions(icon: 'dash_bubble'),
          bubbleOptions: BubbleOptions(
            bubbleIcon: 'dash_bubble',
            startLocationX: 20,
            startLocationY: 100,
            bubbleSize: 60,
            opacity: 1,
            enableClose: false,
            closeBehavior: CloseBehavior.fixed,
            distanceToClose: 100,
            enableAnimateToEdge: true,
            enableBottomShadow: true,
            keepAliveWhenAppExit: false,
          ),
          onTap: () {
            DashBubble.instance.stopBubble();
            platforms.invokeMethod('awakeapp');
          },
        );
      } else {}
    }
    if (state == AppLifecycleState.resumed) {
      Workmanager().cancelAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    platform = Theme.of(context).platform;

    return GestureDetector(
        onTap: () {
          //remove keyboard on touching anywhere on the screen.
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'product name',
            theme: ThemeData(),
            home: const LoadingPage()));
  }
}

Future<void> startBubble(
  BuildContext context, {
  BubbleOptions? bubbleOptions,
  NotificationOptions? notificationOptions,
  VoidCallback? onTap,
  Function(double x, double y)? onTapDown,
  Function(double x, double y)? onTapUp,
  Function(double x, double y)? onMove,
}) async {
  await _runMethod(
    context,
    () async {
      await DashBubble.instance.startBubble(
        bubbleOptions: bubbleOptions,
        notificationOptions: notificationOptions,
        onTap: onTap,
        onTapDown: onTapDown,
        onTapUp: onTapUp,
        onMove: onMove,
      );

      // SnackBars.show(
      //   context: context,
      //   status: SnackBarStatus.success,
      //   message: hasStarted ? 'Bubble Started' : 'Bubble has not Started',
      // );
    },
  );
}

Future<void> _runMethod(
  BuildContext context,
  Future<void> Function() method,
) async {
  try {
    await method();
  } catch (error) {
    // SnackBars.show(
    //   context: context,
    //   status: SnackBarStatus.error,
    //   message: 'Error: ${error.runtimeType}',
    // );
  }
}

void updateLocation(duration) {
  for (var i = 0; i < 15; i++) {
    Workmanager().registerPeriodicTask('locs_$i', 'update_locs_$i',
        initialDelay: Duration(minutes: i),
        frequency: const Duration(minutes: 15),
        constraints: Constraints(
            networkType: NetworkType.connected,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresDeviceIdle: false,
            requiresStorageNotLow: false),
        inputData: {'id': userDetails['id'].toString()});
  }
}
