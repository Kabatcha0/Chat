import 'package:chatapp/components/components.dart';
import 'package:chatapp/cubit/cubit.dart';
import 'package:chatapp/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController country = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
        builder: (context, state) {
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
                        height: 300,
                        width: 300,
                      ),
                      textFeild(
                          controller: email,
                          type: TextInputType.emailAddress,
                          colorSide: Colors.deepOrange,
                          hint: "Enter your Email",
                          color: Colors.deepOrange,
                          icon: Icons.email),
                      const SizedBox(
                        height: 10,
                      ),
                      textFeild(
                          controller: user,
                          type: TextInputType.name,
                          colorSide: Colors.deepOrange,
                          hint: "Enter your Username",
                          color: Colors.deepOrange,
                          icon: Icons.person),
                      const SizedBox(
                        height: 10,
                      ),
                      textFeild(
                          controller: phone,
                          type: TextInputType.phone,
                          colorSide: Colors.deepOrange,
                          hint: "Enter your phone",
                          color: Colors.deepOrange,
                          icon: Icons.phone),
                      const SizedBox(
                        height: 10,
                      ),
                      textFeild(
                          controller: country,
                          type: TextInputType.name,
                          colorSide: Colors.deepOrange,
                          hint: "Enter your Country",
                          color: Colors.deepOrange,
                          icon: Icons.location_city),
                      const SizedBox(
                        height: 10,
                      ),
                      textFeild(
                          controller: pass,
                          type: TextInputType.number,
                          obscure: true,
                          colorSide: Colors.deepOrange,
                          hint: "Enter your Pass",
                          color: Colors.deepOrange,
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
                          text: "Register",
                          function: () {
                            cubit.auth(
                                email: email.text,
                                password: pass.text,
                                phone: phone.text,
                                user: user.text,
                                country: country.text,
                                context: context);
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
        },
        listener: (context, state) {});
  }
}
