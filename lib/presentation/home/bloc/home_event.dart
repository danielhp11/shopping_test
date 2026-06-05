part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeFetchProducts extends HomeEvent {}

class HomeProductOrderChanged extends HomeEvent {
  final ProductOrder productOrder;

  const HomeProductOrderChanged(this.productOrder);

  @override
  List<Object> get props => [productOrder];

}

class HomeSearchChanged extends HomeEvent {
  final String textSearch;

  const HomeSearchChanged( this.textSearch );

  @override
  List<Object> get props => [textSearch];

}