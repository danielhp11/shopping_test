import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shopping_app/data/datasources/request_serv.dart';
import 'package:shopping_app/data/repositories/product_repository.dart';
import 'package:shopping_app/presentation/home/bloc/home_bloc.dart';
import 'package:shopping_app/presentation/home/view/home_view.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ProductRepository()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: RequestServ.isDebugMode,
        title: 'Shopping App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E3A8A)),
          useMaterial3: true,
        ),
        home: BlocProvider(
          create: (context) => HomeBloc(
            productRepository: context.read<ProductRepository>(),
          )..add(HomeFetchProducts()),
          child: const HomeView(),
        ),
      ),
    );
  }
}
