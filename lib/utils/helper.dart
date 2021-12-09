import 'dart:io';

import 'package:logger/logger.dart';

class Helper {
  static Future<bool> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (ex) {
      Logger().d(ex);
      return false;
    }
  }
}
