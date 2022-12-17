import 'package:chatapp/components/components.dart';
import 'package:chatapp/cubit/cubit.dart';
import 'package:chatapp/cubit/states.dart';
import 'package:chatapp/modules/register.dart';
import 'package:chatapp/shared/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(builder: (context, state) {
      var cubit = ChatCubit.get(context);
      return Scaffold(
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/chat.jpg",
                    height: 350,
                    width: 350,
                  ),
                  textFeild(
                      controller: email,
                      colorSide: Colors.blue,
                      hint: "Enter your Email",
                      type: TextInputType.emailAddress,
                      color: Colors.blue,
                      icon: Icons.email),
                  const SizedBox(
                    height: 10,
                  ),
                  textFeild(
                      controller: pass,
                      colorSide: Colors.blue,
                      type: TextInputType.phone,
                      hint: "Enter your Pass",
                      obscure: true,
                      color: Colors.blue,
                      icon: Icons.password),
                  const SizedBox(
                    height: 15,
                  ),
                  if (state is ChatLoginLoadingState)
                    const LinearProgressIndicator(),
                  if (state is ChatLoginLoadingState)
                    const SizedBox(
                      height: 15,
                    ),
                  button(
                      text: "Login",
                      function: () {
                        cubit.logIn(
                            email: email.text,
                            password: pass.text,
                            context: context);
                      },
                      color: Colors.blue),
                  const SizedBox(
                    height: 15,
                  ),
                  button(
                      text: "Register",
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      color: Colors.deepOrange),
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Container(),
                  )
                ],
              ),
            ),
          ),
        )),
      );
    }, listener: (context, state) {
      if (state is ChatLoginSuccessState) {
        uiD = state.id;
      }
    });
  }
}
