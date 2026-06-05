import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shopping_app/data/model/product_model.dart';
import 'package:shopping_app/data/repositories/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository _productRepository;

  HomeBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(const HomeState()) {
    on<HomeFetchProducts>(_onFetchProducts);
    on<HomeProductOrderChanged>(_onOrderChanged);
    on<HomeSearchChanged>(_onSearchChanged);
  }

  Future<void> _onFetchProducts(
    HomeFetchProducts event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      final products = await _productRepository.getProducts();

      emit(state.copyWith(
        status: HomeStatus.success,
        products: products,
        filterProduct: products
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: e.toString(),
      ));
    } finally {
      FlutterNativeSplash.remove();
    }
  }

  void _onOrderChanged(
    HomeProductOrderChanged event,
    Emitter<HomeState> emit
  ){
    List <ProductModel> productOrder = List.from(state.products);

    switch (event.productOrder){
      case ProductOrder.defaultOrder:
        productOrder.sort( (a,b) => a.id.compareTo(b.id) );
        break;
      case ProductOrder.priceLow:
        productOrder.sort( (a,b) => a.price.compareTo(b.price) );
        break;
      case ProductOrder.priceHigh:
        productOrder.sort( (a,b) => b.price.compareTo(a.price) );

    }

    emit(
      state.copyWith(
        products: productOrder,
        productOrder: event.productOrder
      )
    );

  }

  void _onSearchChanged(HomeSearchChanged event, Emitter<HomeState> emit) {
    final query = event.textSearch.toLowerCase();

    if (query.isEmpty) {
      emit(state.copyWith(products: state.filterProduct));
    } else {
      final filtered = state.products.where((p) =>
          p.title.toLowerCase().contains(query)
      ).toList();

      emit(state.copyWith(products: filtered));
    }
  }

}
