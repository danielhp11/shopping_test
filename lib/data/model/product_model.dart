/** Template to item in array
 * 	{
    "id": 1,
    "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
    "price": 109.95,
    "description": "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
    "category": "men's clothing",
    "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png",
    "rating": {
    "rate": 3.9,
    "count": 120
    }
    },
 */

class ProductModel {

  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingModel rate;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
  });

  factory ProductModel.fromJson( Map<String, dynamic> json ){
    return ProductModel(
        id: json['id'],
        title: json['title'],
        price: (json['price'] as num).toDouble(),
        description: json['description'],
        category: json['category'],
        image: json['image'],
        rate: RatingModel.fromJson( json['rating'] )
    );
  }

}

class RatingModel{

  final double rate;
  final int count;

  RatingModel({
    required this.rate,
    required this.count
  });

  factory RatingModel.fromJson( Map<String, dynamic> json ){
    return RatingModel(
        rate: (json['rate'] as num).toDouble(),
        count: json['count'] ?? 0
    );
  }

}