// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/models/plants_model.dart';
import 'package:la_vie/models/seed_model.dart';
import 'package:la_vie/models/tools_model.dart';
import 'package:la_vie/modules/home/homescreen.dart';
import 'package:la_vie/modules/notification/notificationScreen.dart';
import 'package:la_vie/modules/profile/profileScreen.dart';
import 'package:la_vie/modules/qr/qrScreen.dart';
import 'package:la_vie/modules/question/questionScreen.dart';
import 'package:la_vie/shared/cubit/appCubit/states.dart';
import 'package:la_vie/shared/network/local/sharedpreference/sharedpreference.dart';
import 'package:la_vie/shared/network/remote/dio_Helper/dio_Helper.dart';
import 'package:la_vie/shared/network/remote/end_points.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

//part of BottomNavigation Bar
  int currentIndex = 2;
  var navigation = GlobalKey<CurvedNavigationBarState>();

  List<Widget> screens = [
    QuestionScreen(),
    QrScreen(),
    HomeScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];

  void bottomNav(int index) {
    currentIndex = index;
    emit(AppBottomNavBarState());
  }

  String token = CacheHelper.get(key: "token");

  // List<dynamic> seedsData = [];
  SeedModel? seedModel;
  void getDataSeeds() {
    emit(SeedsGetDataLoading());

    DioHelper.getData(
      url: SEEDS,
      token: token,
    ).then((value) {
      seedModel = SeedModel.fromJson(value.data);
      emit(SeedsGetDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(SeedsGetDataError(error));
    });
  }

  PlantsModel? plantModel;
  void getDataPlants() {
    emit(PlantsGetDataLoading());

    DioHelper.getData(
      url: PLANTS,
      token: token,
    ).then((value) {
      plantModel = PlantsModel.fromJson(value.data);
      emit(PlantsGetDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(PlantsGetDataError(error));
    });
  }

  ToolsModel? toolsModel;
  void getDataTools() {
    emit(ToolsGetDataLoading());

    DioHelper.getData(
      url: TOOLS,
      token: token,
    ).then((value) {
      toolsModel = ToolsModel.fromJson(value.data);
      emit(ToolsGetDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(ToolsGetDataError(error));
    });
  }
}
