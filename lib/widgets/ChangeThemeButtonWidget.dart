import 'package:flutter/material.dart';
import 'package:message_sent_app/theme.dart';
import 'package:provider/provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
        child: Row(
      children: [
        IconButton(
            onPressed: () {
              final provider =
                  Provider.of<ThemeProvider>(context, listen: false);
              provider.toggleTheme(!themeProvider.isDarkMode);
            },
            icon: themeProvider.isDarkMode
                ? Icon(Icons.wb_sunny)
                : Icon(Icons.dark_mode))
      ],
    ));
  }

  void setState(Null Function() param0) {}
}

changeTheme(BuildContext context, bool isDarkMode) {}
