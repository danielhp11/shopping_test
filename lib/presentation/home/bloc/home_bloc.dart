import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shopping_app/data/model/product_model.dart';

import '../../../data/datasources/request_serv.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeFetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(
    HomeFetchProducts event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      final response = await RequestServ.instance.handlingRequest(
        urlParam: RequestServ.urlProduct,
      );

      if (response != null) {
        final List<dynamic> jsonList = jsonDecode(response);
        final products = jsonList
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();

        emit(state.copyWith(
          status: HomeStatus.success,
          products: products,
        ));
      } else {
        emit(state.copyWith(
          status: HomeStatus.failure,
          errorMessage: 'No se pudieron cargar los productos',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: e.toString(),
      ));
    }
    finally{
      FlutterNativeSplash.remove();
    }
  }
}
