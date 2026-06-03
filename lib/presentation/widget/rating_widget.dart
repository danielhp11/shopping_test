import 'package:flutter/material.dart';
import 'package:shopping_app/data/model/product_model.dart';

class RatingWidget extends StatelessWidget {
  final RatingModel rating;

  const RatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    // Generamos la lista de estrellas dinámicamente
    List<Widget> stars = List.generate(5, (index) {
      if (rating.rate >= index + 1) {
        return const Icon(Icons.star, color: Colors.amber, size: 18);
      } else if (rating.rate >= index + 0.5) {
        return const Icon(Icons.star_half, color: Colors.amber, size: 18);
      } else {
        return const Icon(Icons.star_border, color: Colors.grey, size: 18);
      }
    });

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: stars),
        const SizedBox(width: 8),
        Text(
          '(${rating.count} reviews)',
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
