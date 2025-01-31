import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope_app/models/login_model.dart';
import 'package:shope_app/modules/categories/categories_screen.dart';
import 'package:shope_app/modules/favorites/favorites_screen.dart';
import 'package:shope_app/modules/products/products_screen.dart';
import 'package:shope_app/modules/search/search_screen.dart';
import 'package:shope_app/network/remote/dio_helper.dart';
import 'package:shope_app/shared/cubit/states.dart';

import '../../components/constans.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';
import '../../network/endpoint.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  ShopAppCubit() : super(ShopAppInitialState());

  static ShopAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SearchScreen(),
    //const SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopAppChangeBottomNavState());
  }

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      print(homeModel?.data?.banners[0].image);

      print(homeModel?.status);
      //printFullText(homeModel.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }


  CategoriesModel? categoriesModel;
  void getCategories() {

    DioHelper.getData(
      url: GET_GATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }



  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopAppLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      debugPrint(loginModel!.status.toString());
      emit(ShopAppSuccessState(loginModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopAppErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopAppChangePasswordVisibilityState());
  }
}
