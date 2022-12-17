import 'package:chatapp/shared/const.dart';

abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class ChatRegisterSuccessState extends ChatStates {
  String? id;
  ChatRegisterSuccessState({required this.id});
}

class ChatRegisterLoadingState extends ChatStates {}

class ChatRegisterErrorState extends ChatStates {}

class ChatSignOutState extends ChatStates {}

class ChatLoginLoadingState extends ChatStates {}

class ChatLoginSuccessState extends ChatStates {
  String? id;
  ChatLoginSuccessState({required this.id});
}

class ChatLoginErrorState extends ChatStates {}

class ChatSendChatLoadingState extends ChatStates {}

class ChatSendChatSuccessState extends ChatStates {}

class ChatSendChatErrorState extends ChatStates {}

class ChatGetChatLoadingState extends ChatStates {}

class ChatGetChatSuccessState extends ChatStates {}

class ChatGetChatErrorState extends ChatStates {}

class ChatGetUserSuccessState extends ChatStates {}

class ChatGetUserErrorState extends ChatStates {}
