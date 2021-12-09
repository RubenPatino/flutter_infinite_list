import 'package:aflore_flutter/constants/page_constant.dart';
import 'package:aflore_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
              title: "Aflore Movie",
              routes: Routes.getRoute(),
              debugShowCheckedModeBanner: false,
              initialRoute: PageConstant.homeScreen);
        },
      ),
    );
  }
}
