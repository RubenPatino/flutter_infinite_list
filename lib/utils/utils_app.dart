import 'dart:io';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class UtilsApp {
  static String getYear(String date) {
    try {
      final formatter = DateFormat('yyyy');
      final dateParse = DateTime.parse(date);
      final dateYear = formatter.format(dateParse);
      return dateYear;
    } catch (ex) {
      Logger().d(ex);
      return '';
    }
  }

  static Future<bool> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
