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
            case HomeStatus.initial: // but if need will add more actions
            case HomeStatus.loading: // view to circule loading
              return const Center(child: CircularProgressIndicator());
            case HomeStatus.failure: // show Error
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.errorMessage ?? 'Error'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<HomeBloc>().add(HomeFetchProducts()),
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              );
            case HomeStatus.success:
              if (state.products.isEmpty) {
                return const Center(child: Text('No hay productos'));
              }

              final mediaQuery = MediaQuery.of(context);
              final isLandscape = mediaQuery.orientation == Orientation.landscape;
              final isPortrait = mediaQuery.orientation != Orientation.portrait;

              final isTablet = mediaQuery.size.shortestSide > 600;
              final isWideScreen = mediaQuery.size.width > 600;
              final columns = isTablet && isPortrait ? 3 : 2;
              final aspect = isLandscape ? 2.0 : 2.0;

              return Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: TextField(
                  //           decoration: InputDecoration(
                  //             hintText: 'Buscar productos...',
                  //             prefixIcon: const Icon(Icons.search, color: Color(0xFF1E3A8A)),
                  //             contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  //             border: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(12),
                  //               borderSide: BorderSide(color: Colors.grey.shade300),
                  //             ),
                  //             enabledBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(12),
                  //               borderSide: BorderSide(color: Colors.grey.shade300),
                  //             ),
                  //             filled: true,
                  //             fillColor: Colors.grey.shade100,
                  //           ),
                  //           onChanged: (value) {
                  //             context.read<HomeBloc>().add(HomeSearchChanged(value));
                  //           },
                  //         ),
                  //       ),
                  //       const SizedBox(width: 10),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           color: const Color(0xFF1E3A8A).withOpacity(0.1),
                  //           borderRadius: BorderRadius.circular(12),
                  //         ),
                  //         child: PopupMenuButton<ProductOrder>(
                  //           icon: const Icon(Icons.sort, color: Color(0xFF1E3A8A)),
                  //           onSelected: (order) {
                  //             context.read<HomeBloc>().add(HomeProductOrderChanged(order));
                  //           },
                  //           itemBuilder: (context) => [
                  //             const PopupMenuItem(
                  //               value: ProductOrder.defaultOrder,
                  //               child: Text('Default'),
                  //             ),
                  //             const PopupMenuItem(
                  //               value: ProductOrder.priceLow,
                  //               child: Text('Price: Low'),
                  //             ),
                  //             const PopupMenuItem(
                  //               value: ProductOrder.priceHigh,
                  //               child: Text('Price: High'),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: 8),
                  Expanded(
                      child:
                      isWideScreen ?
                      GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          childAspectRatio: aspect,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ProductCard(product: product);
                        },
                      ) :
                      ListView.builder(
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ProductCard(product: product);
                        },
                      )
                  )
                ],
              );
          }
        },
      ),
    );
  }
}
