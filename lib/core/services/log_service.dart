import 'package:flutter_mvvm_starter/utils/config/env.dart';
import 'package:logger/logger.dart';
import 'dart:io';

class Log {
  static final logger = Logger(printer: PrettyPrinter());
  static File? logFile;

  static Future<void> init() async {
    if (Env().envType == "dev") {
      final directory = await Directory.systemTemp.createTemp();
      logFile = File('${directory.path}/app_logs.txt');
    }
  }

  static void create(Level level, String message) async {
    if (Env().envType == "dev") {
      final pattern = RegExp('.{1,1200}');
      for (var chunk in pattern.allMatches(message)) logger.log(level, chunk.group(0));

      if (logFile != null) await logFile!.writeAsString('$message\n\n', mode: FileMode.append);
    }
  }
}
