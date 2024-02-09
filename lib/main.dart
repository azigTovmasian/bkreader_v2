import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'Pages/home.dart';
import 'package:provider/provider.dart';
import '../Providers/home.dart';
import 'Providers/Connectivity_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => HomeProv()),
    ChangeNotifierProvider(create: (context) => ConnectivityProv()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState()  {
  initializer();
    super.initState();
  }

  Future<void> initializer() async {
    final assetPlayer = AudioPlayer();
    await assetPlayer.setAudioSource(AudioSource.asset('assets/audios/intro.mp3'));
    await assetPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: child!);
      },
      debugShowCheckedModeBanner: false,
      home: HomeP(),
    );
  }
}
