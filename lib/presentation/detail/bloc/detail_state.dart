part of 'detail_bloc.dart';

class DetailState extends Equatable {
  final ProductModel? product;

  const DetailState({this.product});

  DetailState copyWith({ProductModel? product}) {
    return DetailState(
      product: product ?? this.product,
    );
  }

  @override
  List<Object?> get props => [product];
}
