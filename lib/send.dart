import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/code.ino');
  }

  Future<File> writeCode(List<String> blocksCode) async {
    final file = await _localFile;
    final String code = blocksCode.map((e) => e).join("\n");

    // Write the file.
    return file.writeAsString(code);
  }

  Future<String> readCode() async {
    try {
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return the error.
      return e.toString();
    }
  }
}
