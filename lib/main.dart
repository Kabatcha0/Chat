import 'package:chatapp/cubit/cubit.dart';
import 'package:chatapp/cubit/states.dart';
import 'package:chatapp/modules/chat.dart';
import 'package:chatapp/modules/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              theme: ThemeData(scaffoldBackgroundColor: Colors.white),
              title: 'Chat App',
              debugShowCheckedModeBanner: false,
              home: const Splash());
        },
      ),
    );
  }
}
