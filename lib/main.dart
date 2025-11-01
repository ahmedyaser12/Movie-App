import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/injection_container/injection_container.dart' as di;
import 'core/theme/app_theme.dart';
import 'feature/movies/data/models/movie_model.dart';
import 'feature/movies/presenttion/controller/movie_bloc.dart';
import 'feature/movies/presenttion/controller/movie_event.dart';
import 'feature/movies/presenttion/screens/movie_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive Adapters
  Hive.registerAdapter(MovieModelAdapter());

  // Initialize dependencies
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          di.sl<MovieBloc>()..add(const GetPopularMoviesEvent(page: 1)),
      child: MaterialApp(
        title: 'Movies App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeMode,
        home: MovieListPage(onToggleTheme: _toggleTheme),
      ),
    );
  }
}
