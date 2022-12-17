import 'package:chatapp/components/components.dart';
import 'package:chatapp/cubit/cubit.dart';
import 'package:chatapp/cubit/states.dart';
import 'package:chatapp/modules/login.dart';
import 'package:chatapp/shared/const.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

class Chat extends StatefulWidget {
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ChatCubit.get(context).getUser();
      ChatCubit.get(context).getMessage();
      return BlocConsumer<ChatCubit, ChatStates>(
          builder: (context, state) {
            var cubit = ChatCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    Image.asset(
                      "assets/chat.jpg",
                      height: 55,
                    ),
                    const Text(
                      "Chat App",
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        cubit.signOut(context: context);
                      },
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.deepOrange,
                      ))
                ],
                automaticallyImplyLeading: false,
              ),
              body: Column(
                children: [
                  Expanded(
                      child: ConditionalBuilder(
                    builder: (context) => ListView.separated(
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (cubit.getChat[index].senderId == uiD) {
                          return mySend(
                              text: cubit.getChat[index].text,
                              date: cubit.getChat[index].dateTime
                                  .replaceRange(5, 8, "")
                              //  DateTime.now().hour.toString()
                              );
                        } else {
                          return hisSend(
                              text: cubit.getChat[index].text,
                              date: cubit.getChat[index].dateTime);
                        }
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 0,
                      ),
                      itemCount: cubit.getChat.length,
                      // cubit.getChat.length,
                    ),
                    fallback: (context) => Container(),
                    condition: cubit.getChat.isNotEmpty,
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: textEditingController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.deepOrange,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.deepOrange)),
                              border: OutlineInputBorder(),
                              hintText: "Write...",
                              suffixIcon: Icon(
                                Icons.chat,
                                color: Colors.deepOrange,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              cubit.sendMessage(
                                  text: textEditingController.text,
                                  receiveId: cubit.users!,
                                  dateTime: Jiffy().jms);
                              textEditingController.text = "";
                            },
                            child: const Text(
                              "Send",
                              style: TextStyle(color: Colors.deepOrange),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          listener: (context, state) {});
    });
  }

  Widget mySend({required String text, required String date}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: 200,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(7),
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(7))),
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              date,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget hisSend({required String text, required String date}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: AlignmentDirectional.topEnd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            UnconstrainedBox(
              child: Container(
                padding: const EdgeInsets.all(10),
                width: 200,
                decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7))),
                child: Text(
                  text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              date,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
