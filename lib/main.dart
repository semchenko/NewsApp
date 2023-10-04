import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/routes.dart';
import 'package:news_app/features/news/presentation/bloc/article_event.dart';
import 'package:news_app/features/news/presentation/pages/news.dart';
import 'features/news/presentation/bloc/article_bloc.dart';
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArticlesBloc>(
      create: (context) => getIt()..add(const GetArticles()),
      child: const MaterialApp(
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: NewsScreen(),
      ),
    );
  }
}
