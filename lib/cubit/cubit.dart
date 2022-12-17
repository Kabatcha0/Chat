import 'package:bloc/bloc.dart';
import 'package:chatapp/cubit/states.dart';
import 'package:chatapp/models/chatdetails.dart';
import 'package:chatapp/models/firestoreregister.dart';
import 'package:chatapp/models/getchat.dart';
import 'package:chatapp/models/getuser.dart';
import 'package:chatapp/modules/chat.dart';
import 'package:chatapp/modules/login.dart';
import 'package:chatapp/shared/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());
  static ChatCubit get(context) => BlocProvider.of(context);
  void auth(
      {required String email,
      required String password,
      required String phone,
      required String user,
      required String country,
      required BuildContext context}) {
    emit(ChatRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uiD = value.user!.uid;
      print(uiD);
      store(
          email: email,
          password: password,
          phone: phone,
          user: user,
          uid: value.user!.uid,
          country: country);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Chat()));
    }).catchError((e) {
      emit(ChatRegisterErrorState());
    });
  }

  void store({
    required String email,
    required String password,
    required String phone,
    required String user,
    required String uid,
    required String country,
  }) {
    FireStoreRegister model = FireStoreRegister(
        email: email,
        user: user,
        password: password,
        country: country,
        phone: phone,
        uid: uid);
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(ChatRegisterSuccessState(id: uid));
    }).catchError((e) {
      print(e.toString());
    });
  }

  void signOut({required BuildContext context}) {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    });
    emit(ChatSignOutState());
  }

  void logIn(
      {required String email,
      required String password,
      required BuildContext context}) {
    emit(ChatLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uiD = value.user!.uid;
      // print(uiD);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Chat()));
      emit(ChatLoginSuccessState(id: uiD));
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("please check your email or pass")));
      emit(ChatLoginErrorState());
    });
  }

  String? users;
  void getUser() {
    if (users == null) {
      FirebaseFirestore.instance.collection("users").get().then((value) {
        value.docs.forEach((element) {
          if (element.data()["uid"] != uiD) {
            users = element.data()["uid"];
            print(users);
          }
          emit(ChatGetUserSuccessState());
        });
      }).catchError((e) {
        print(e.toString());
        emit(ChatGetUserErrorState());
      });
    }
  }

  ChatDetails? details;
  void sendMessage({
    required String text,
    required String receiveId,
    required String dateTime,
  }) {
    emit(ChatSendChatLoadingState());
    details = ChatDetails(
        text: text, senderId: uiD!, receiveId: receiveId, dateTime: dateTime);
    FirebaseFirestore.instance
        .collection("users")
        .doc(uiD)
        .collection("chat")
        .add(details!.toMap())
        .then((value) {
      emit(ChatSendChatSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(ChatSendChatErrorState());
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(receiveId)
        .collection("chat")
        .add(details!.toMap())
        .then((value) {
      emit(ChatSendChatSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(ChatSendChatErrorState());
    });
  }

  List<GetChat> getChat = [];
  void getMessage() {
    // getChat = [];
    emit(ChatGetChatLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(uiD)
        .collection("chat")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      getChat = [];
      event.docs.forEach((element) {
        getChat.add(GetChat.fromJson(element.data()));
      });
      emit(ChatGetChatSuccessState());
    });
  }
}
