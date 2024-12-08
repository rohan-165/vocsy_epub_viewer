import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'model/enum/epub_scroll_direction.dart';
part 'model/epub_locator.dart';
part 'utils/util.dart';

class VocsyEpub {
  static const MethodChannel _channel =
      const MethodChannel('vocsy_epub_viewer');
  static const EventChannel _pageChannel = const EventChannel('page');

  /// Configure Viewer's with available values
  ///
  /// themeColor is the color of the reader
  /// scrollDirection uses the [EpubScrollDirection] enum
  /// allowSharing
  /// enableTts is an option to enable the inbuilt Text-to-Speech
  static void setConfig(
      {Color themeColor = Colors.blue,
      String identifier = 'book',
      bool nightMode = false,
      EpubScrollDirection scrollDirection = EpubScrollDirection.ALLDIRECTIONS,
      bool allowSharing = false,
      bool enableTts = false}) async {
    Map<String, dynamic> agrs = {
      "identifier": identifier,
      "themeColor": Util.getHexFromColor(themeColor),
      "scrollDirection": Util.getDirection(scrollDirection),
      "allowSharing": allowSharing,
      'enableTts': enableTts,
      'nightMode': nightMode
    };
    await _channel.invokeMethod('setConfig', agrs);
  }

  /// Opens the book.
  /// `bookPath` should be a local file.
  /// `lastLocation` is only available for Android.
  static Future<void> open(String bookPath, {EpubLocator? lastLocation}) async {
    Map<String, dynamic> args = {
      "bookPath": bookPath,
      'lastLocation':
          lastLocation == null ? '' : jsonEncode(lastLocation.toJson()),
    };

    try {
      // Fetch the Android version
      String? version;
      try {
        version = await _channel.invokeMethod('getAndroidVersion');
      } on PlatformException catch (e) {
        print("Failed to get Android version: ${e.message}");
        return;
      }

      if (version == null || version.isEmpty) {
        throw Exception("Unable to fetch Android version.");
      }

      // Extract major version
      String majorVersion = version.split(".").first;
      int intValue = int.parse(majorVersion);

      // Handle Android 13+ or below 13 logic
      if (intValue >= 13) {
        await _openBook(args);
      } else {
        final PermissionStatus status = await Permission.storage.request();
        if (status == PermissionStatus.granted) {
          await _openBook(args);
        } else if (status == PermissionStatus.denied) {
          print("Storage permission denied by user.");
          throw Exception("Storage permission is required to proceed.");
        } else if (status == PermissionStatus.permanentlyDenied) {
          print("Storage permission permanently denied.");
          await openAppSettings(); // Suggest user to change permissions in app settings
        }
      }

      print("Android Version: $intValue");
    } catch (e) {
      // Catch and log any exceptions
      print("Error occurred: $e");
    }
  }

  /// Helper method to invoke `_channel` methods for opening the book
  static Future<void> _openBook(Map<String, dynamic> args) async {
    try {
      _channel.invokeMethod('setChannel');
      await _channel.invokeMethod('open', args);
      print("Book opened successfully.");
    } catch (e) {
      print("Error while opening book: $e");
    }
  }

  static void closeReader() async {
    _channel.invokeMethod('setChannel');
    await _channel.invokeMethod('close');
  }

  /// bookPath should be an asset file path.
  /// Last location is only available for android.
  static Future openAsset(String bookPath, {EpubLocator? lastLocation}) async {
    if (extension(bookPath) == '.epub') {
      Map<String, dynamic> agrs = {
        "bookPath": (await Util.getFileFromAsset(bookPath)).path,
        'lastLocation':
            lastLocation == null ? '' : jsonEncode(lastLocation.toJson()),
      };
      _channel.invokeMethod('setChannel');
      await _channel.invokeMethod('open', agrs);
    } else {
      throw ('${extension(bookPath)} cannot be opened, use an EPUB File');
    }
  }

  static Future setChannel() async {
    await _channel.invokeMethod('setChannel');
  }

  /// Stream to get EpubLocator for android and pageNumber for iOS
  static Stream get locatorStream {
    print("In stream");
    Stream pageStream =
        _pageChannel.receiveBroadcastStream().map((value) => value);

    return pageStream;
  }
}
