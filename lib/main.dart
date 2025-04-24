import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:list_rick_and_morty/model/person.dart';
import 'package:list_rick_and_morty/view/home_view.dart';
import 'package:list_rick_and_morty/view_model/list_person_view_model.dart';
import 'package:list_rick_and_morty/view_model/setting_model.dart';
import 'package:provider/provider.dart';
import 'services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hiveService = HiveService();
  await hiveService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingModel>(
          create: (context) => SettingModel(),
        ),
        ChangeNotifierProvider<ListPersonViewModel>(
          create: (context) => ListPersonViewModel(hiveService),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingModel>(
      builder: (context, settingModel, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: settingModel.theme,
          home: HomeView(),
        );
      },
    );
  }
}
