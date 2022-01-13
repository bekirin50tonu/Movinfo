import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movinfo/core/constants/app_constants.dart';
import 'package:movinfo/core/constants/theme_constant.dart';
import 'package:movinfo/core/extensions/context_entensions.dart';
import 'package:movinfo/core/init/cache/locale_manager.dart';
import 'package:movinfo/core/state/theme_state.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: context.dynamicHeight(0.2),
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
              decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            )),
            title: Text('Ayarlar'),
          ),
          SliverList(delegate: SliverChildListDelegate([CountriesSettings()]))
        ],
      ),
    );
  }
}

class CountriesSettings extends StatefulWidget {
  const CountriesSettings({Key? key}) : super(key: key);

  @override
  _CountriesSettingsState createState() => _CountriesSettingsState();
}

class _CountriesSettingsState extends State<CountriesSettings> {
  @override
  Widget build(BuildContext context) {
    ///////////////////////////////////////////////////////////////////////
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    List languages = [];
    List countries = [];
    String language = LocaleManager.getString('language') ?? "Türkiye";
    String country = LocaleManager.getString('country') ?? "Turkey";
    var rawLanguages = AppConstants.DATA_LANGUAGES;
    var rawCountries = AppConstants.DATA_COUNTRIES;
    rawLanguages.forEach((element) {
      languages.add(element['name']!.isNotEmpty
          ? element['name']
          : element['english_name']);
    });
    rawCountries.forEach((element) {
      countries.add(element['name']!.isNotEmpty
          ? element['name']
          : element['english_name']);
    });
///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
    bool darkTheme = LocaleManager.getBool('darkTheme') ?? false;

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingHeader(
              title: Text(
                'Bölge ve Dil',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.start,
              ),
              children: [
                SettingBottomSheet(
                  title: 'Dil',
                  subtitle: language,
                  onTab: (variable) async => {
                    language = variable,
                    await LocaleManager.setString('language', variable),
                    setState(() {}),
                  },
                  variables: languages,
                ),
                SettingBottomSheet(
                  title: 'Bölge',
                  subtitle: country,
                  onTab: (variable) async => {
                    country = variable,
                    await LocaleManager.setString('country', variable),
                    setState(() {}),
                  },
                  variables: countries,
                )
              ]),
          SettingHeader(
              title: Text(
                'Görünüş',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.start,
              ),
              children: [
                SettingSwitch(
                  title: 'Karanlık Tema',
                  onChanged: (bool value) async {
                    darkTheme = value;
                    await LocaleManager.setBool('darkTheme', value);
                    themeNotifier.setTheme(value
                        ? ThemeConstants.darkTheme
                        : ThemeConstants.lightTheme);
                    setState(() {});
                  },
                  value: darkTheme,
                )
              ])
        ]);
  }
}

class SettingHeader extends StatelessWidget {
  final Text title;
  final List<Widget> children;
  const SettingHeader({Key? key, required this.title, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    children.insert(0, title);
    return SizedBox(child: Column(children: children));
  }
}

class SettingTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Function? onTab;
  const SettingTile({Key? key, required this.title, this.subtitle, this.onTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTab,
      child: SizedBox(
        height: context.dynamicHeight(0.1),
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle!),
          trailing: Icon(
            Icons.keyboard_arrow_right_outlined,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class SettingSwitch extends StatelessWidget {
  final String title;
  final Function(bool value) onChanged;
  final bool value;
  const SettingSwitch(
      {Key? key,
      required this.title,
      required this.onChanged,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.1),
      child: ListTile(
        title: Text(title),
        trailing: Switch(
          onChanged: onChanged,
          value: value,
        ),
      ),
    );
  }
}

class SettingBottomSheet extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<dynamic> variables;
  final Function(String) onTab;
  const SettingBottomSheet(
      {Key? key,
      required this.title,
      this.subtitle,
      required this.variables,
      required this.onTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(0.1),
      child: ListTile(
        onTap: () => showBottomSheet(context, variables, onTab),
        title: Text(title),
        subtitle: Text(subtitle!),
        trailing: Icon(
          Icons.keyboard_arrow_right_outlined,
          color: Colors.black,
        ),
      ),
    );
  }

  showBottomSheet(
      BuildContext context, List<dynamic> variables, Function(String) onTab) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ListView.builder(
              itemCount: variables.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Center(child: Text(variables[index])),
                    onTap: () {
                      onTab(variables[index]);
                      Navigator.pop(context);
                    });
              });
        });
  }
}
