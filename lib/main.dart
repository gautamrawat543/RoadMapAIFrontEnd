import 'package:flutter/material.dart';
import 'package:path_finder/pages/bottomnav_controller.dart';
import 'package:path_finder/pages/roadmap.dart';
import 'package:path_finder/pages/login.dart';
import 'package:path_finder/provider/roadmap_provider.dart';
import 'package:path_finder/provider/theme_provider.dart';
import 'package:path_finder/styles/color_styles.dart';
import 'package:path_finder/styles/text_styles.dart';
import 'package:path_finder/util/shared_pref_helper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isRegistered = await SharedPrefHelper.getRegistered();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => RoadmapProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ],
    child: MyApp(isRegistered: isRegistered),
  ));
}

class MyApp extends StatelessWidget {
  final bool isRegistered;
  MyApp({super.key, this.isRegistered = false});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.currentTheme,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: primaryColor,
          centerTitle: true,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: AppTextStyles.whiteText.copyWith(fontSize: 20),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        appBarTheme: AppBarTheme(
          color: Colors.grey[900],
          centerTitle: true,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: whiteText.copyWith(fontSize: 20),
        ),
      ),
      title: 'RoadMap.AI',
      home: isRegistered ? BottomNavController() : Login(),
    );
  }
}
