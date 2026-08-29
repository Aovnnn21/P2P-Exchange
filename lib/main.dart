import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/supabase_config.dart';
import 'providers/theme_provider.dart';
import 'services/localization_service.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Initialize Firebase (Crashlytics & Analytics)
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  
  // 2. Initialize Supabase
  await SupabaseConfig.initialize();
  
  // 3. Initialize Hive (Offline Mode)
  await Hive.initFlutter();
  await Hive.openBox('transactions');
  await Hive.openBox('messages');
  await Hive.openBox('profiles');
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      title: 'P2P Exchange',
      debugShowCheckedModeBanner: false,
      // Localization Settings
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('my'),
      ],
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), useMaterial3: true),
      darkTheme: ThemeData(brightness: Brightness.dark, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark), useMaterial3: true),
      themeMode: themeProvider.themeMode,
      home: SupabaseConfig.client.auth.currentUser != null ? const HomeScreen() : const LoginScreen(),
    );
  }
}

  }
}
