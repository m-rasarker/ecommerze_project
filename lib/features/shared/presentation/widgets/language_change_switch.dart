import 'package:ecommerce_project/app/app.dart';
import 'package:ecommerce_project/app/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class LanguageChangeSwitch extends StatelessWidget {
  const LanguageChangeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(context.localization.selectLanguage),
      trailing: DropdownMenu<Locale>(
        dropdownMenuEntries: CraftyBay.languageController.supportedLocales.map((
            locale,
            ) {
          return DropdownMenuEntry(value: locale, label: locale.languageCode);
        }).toList(),
        onSelected: (Locale? locale) {
          CraftyBay.languageController.changeLocale(locale!);
        },
      ),
    );
  }
}