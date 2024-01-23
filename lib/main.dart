import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber/common/controlrer/provider/authProvider.dart';
import 'package:uber/common/view/registrationScreen/registrationScreen.dart';
import 'package:uber/common/view/signInLogic/signInLogin.dart';
import 'package:uber/constant/utils/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:uber/firebase_options.dart';
import 'package:uber/rider/controller/bottomNavBarRiderProvider/bottomNavBarRiderProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Uber());
}

class Uber extends StatefulWidget {
  const Uber({super.key});

  @override
  State<Uber> createState() => _UberState();
}

class _UberState extends State<Uber> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, _, __) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<BottomNavbarRiderProvider>(
              create: (_) => BottomNavbarRiderProvider(),
            ),
            ChangeNotifierProvider<MobileAuthProvider>(
              create: (_) => MobileAuthProvider(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:
                ThemeData(appBarTheme: AppBarTheme(color: white, elevation: 0)),
            home: const SignInLogic(),
          ),
        );
      },
    );
  }
}
