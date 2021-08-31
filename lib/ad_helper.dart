import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      // return "ca-app-pub-3940256099942544/6300978111";
      return "ca-app-pub-3233936660028706/6021458886";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3233936660028706/4199819750";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
