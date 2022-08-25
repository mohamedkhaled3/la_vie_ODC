// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:la_vie/layout/homeLayout/homeLayoutScreen.dart';
import 'package:la_vie/models/login_model.dart';
import 'package:la_vie/shared/components/components.dart';
import 'package:la_vie/shared/cubit/login_cubit/states.dart';
import 'package:la_vie/shared/network/local/sharedpreference/sharedpreference.dart';
import 'package:la_vie/shared/network/remote/dio_Helper/dio_Helper.dart';
import 'package:la_vie/shared/network/remote/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  //vars
  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShow = true;

  void changeSuffixIcon() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(PasswordShow());
  }

  LoginModel? loginModel;

  // void logInn({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     var response = await Dio().post(
  //         'https://lavie.orangedigitalcenteregypt.com/$LOGIN',
  //         data: {"email": email, "password": password});
  //     print(response);
  //   } on DioError catch (e) {
  //     print(e.response);
  //   }
  // }

  void signUpp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      var response = await Dio()
          .post('https://lavie.orangedigitalcenteregypt.com/$SIGNUP', data: {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password
      });
      print(response);
    } on DioError catch (e) {
      print(e.response);
    }
  }

  void signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoadingState());
    DioHelper.postsData(url: SIGNUP, data: {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password
    }).then((value) {
      print(value.data);
      emit(SignUpSuccessState());
    }).catchError((error) {
      emit(SignUpErrorState(error));
    });
  }

  void logIn(context, {required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postsData(
        url: LOGIN, data: {'email': email, 'password': password}).then((value) {
      // print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      navigateTo(context, const HomeLayoutScreen());

      CacheHelper.saveData(key: "token", value: loginModel?.data!.accessToken);
//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJlN2QxZTY2MS1hZjlkLTQ4NTUtYjMyZS1kYWMxYjMwYzMxZjEiLCJpYXQiOjE2NjEyOTk1ODIsImV4cCI6MTY2MTQ3MjM4Mn0.57oIiWBb-1mYXjoh4ehNRhKzlKb5tGAgg8nbOcr-5r0
      // print(loginModel?.data!.userData!.firstMame);
      // print(loginModel!.type);
      // print(loginModel!.data!.accessToken);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Failed Login  ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(LoginErrorState(error));
    });
  }
  // void userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(LoginLoadingState());
  //   // DioHelper.postData(data: {
  //   //   'email': email,
  //   //   'password': password,
  //   // }, endPoint: LOGIN)
  //       .then((value) {
  //     print(value.data);
  //     emit(LoginSuccessState());
  //   }).catchError((error) {
  //     emit(LoginErrorState(error.toString()));
  //   });
  // }
}
