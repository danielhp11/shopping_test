import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/presentation/home/bloc/home_bloc.dart';
import 'package:shopping_app/presentation/widget/app_bar_widget.dart';
import 'package:shopping_app/presentation/widget/product_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        actions: [
          IconButton(
            icon: const Icon(Icons.update),
            onPressed: () => context.read<HomeBloc>().add(HomeFetchProducts()),
          )
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state.status) {
            case HomeStatus.initial:
            case HomeStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case HomeStatus.failure:
              return Center(child: Text(state.errorMessage ?? 'Error'));
            case HomeStatus.success:
              if (state.products.isEmpty) {
                return const Center(child: Text('No hay productos'));
              }
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ProductCard(product: product);
                },
              );
          }
        },
      ),
    );
  }
}
