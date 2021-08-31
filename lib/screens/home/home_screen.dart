import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:message_sent_app/ad_helper.dart';
import 'package:message_sent_app/constants.dart';
import 'package:message_sent_app/widgets/ChangeThemeButtonWidget.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var ddi = TextEditingController();
  var phone = TextEditingController();
  var message = TextEditingController();

  bool _isAdLoaded = false;

  final BannerAd myBanner = BannerAd(
    size: AdSize.banner,
    adUnitId: AdHelper.bannerAdUnitId,
    listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('_isAdLoaded = true'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('Ad failed to load: $error');
        }),
    request: AdRequest(),
  );

  @override
  void initState() {
    super.initState();
    myBanner.load();
  }

  Widget checkForAd() {
    if (_isAdLoaded == true) {
      return Container(
        child: AdWidget(ad: myBanner),
        width: myBanner.size.width.toDouble(),
        height: myBanner.size.height.toDouble(),
        alignment: Alignment.center,
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    ddi.clear();
    phone.clear();
    message.clear();

    launchWhatsApp() async {
      final link = WhatsAppUnilink(
        phoneNumber: ddi.text + phone.text,
        text: message.text,
      );

      await launch('$link');
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => exit(0), icon: Icon(Icons.logout)),
        actions: [
          ChangeThemeButtonWidget(),
          SizedBox(
            width: defaultPadding,
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Spacer(flex: 1),
                Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 230,
                  ),
                ),
                Spacer(flex: 1),
                Row(children: [
                  Flexible(
                    flex: 1,
                    child: TextFormField(
                      controller: ddi,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) return 'Campo obrigatório';

                        return null;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'DDI',
                      ),
                    ),
                  ),
                  SizedBox(width: defaultPadding),
                  Flexible(
                    flex: 2,
                    child: TextFormField(
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) return 'Campo obrigatório';

                        return null;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Phone',
                      ),
                    ),
                  ),
                ]),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  controller: message,
                  minLines: 1,
                  maxLines: 8,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Message (Optional)',
                  ),
                ),
                Spacer(flex: 1),
                Container(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        launchWhatsApp();

                        // FlutterOpenWhatsapp.sendSingleMessage(
                        //     ddi.text + phone.text, message.text);
                      },
                      icon: Icon(Icons.check),
                      label: Text("Send")),
                ),
                Spacer(flex: 2),
                Container(
                  child: AdWidget(ad: myBanner),
                  width: myBanner.size.width.toDouble(),
                  height: myBanner.size.height.toDouble(),
                  alignment: Alignment.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
