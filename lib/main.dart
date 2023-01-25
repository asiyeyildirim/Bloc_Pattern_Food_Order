import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order/ui/cubit/anasayfa_cubit.dart';
import 'package:food_order/ui/cubit/sepet_cubit.dart';
import 'package:food_order/ui/cubit/yemek_detay_cubit.dart';
import 'package:food_order/ui/screen/anasayfa.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
   BlocProvider(create: (context) => AnasayfaCubit()),
   BlocProvider(create: (context) => YemekDetayCubit()),
   BlocProvider(create: (context) => SepetCubit()),
        ],

      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Anasayfa(),
      ),
    );
  }
}

