part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }
enum ProductOrder { defaultOrder, priceLow, priceHigh }

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.products = const <ProductModel>[],
    this.filterProduct = const <ProductModel>[],
    this.productOrder = ProductOrder.defaultOrder,
    this.errorMessage,
  });

  final HomeStatus status;
  final List<ProductModel> filterProduct;
  final List<ProductModel> products;
  final String? errorMessage;
  final ProductOrder productOrder;

  HomeState copyWith({
    HomeStatus? status,
    List<ProductModel>? products,
    List<ProductModel>? filterProduct,
    ProductOrder? productOrder,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      products: products ?? this.products,
      filterProduct: filterProduct ?? this.filterProduct,
      productOrder: productOrder ?? this.productOrder,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage];
}
