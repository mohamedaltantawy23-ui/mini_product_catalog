import 'package:flutter/material.dart';
import 'details_page.dart';
import 'product_widgets.dart';

class ProductsPage extends StatefulWidget {
  final String username;

  const ProductsPage({super.key, required this.username});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int favoritesCount = 0;
  String cartMessage = '';
  double currentWidth = 0.0;

  final List<Map<String, dynamic>> products = const [
    {"name": "Laptop", "price": 1200},
    {"name": "Smartphone", "price": 800},
    {"name": "Headphones", "price": 150},
    {"name": "Smartwatch", "price": 250},
    {"name": "Mechanical Keyboard", "price": 100},
    {"name": "Gaming Mouse", "price": 70},
  ];

  @override
  void initState() {
    super.initState();
    print("ProductsPage: initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final size = MediaQuery.sizeOf(context);
    currentWidth = size.width;
    print("ProductsPage: didChangeDependencies -> width: ${size.width}, height: ${size.height}");
  }

  @override
  void deactivate() {
    print("ProductsPage: deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("ProductsPage: dispose");
    super.dispose();
  }

  Future<void> _handleProductTap(int index) async {
    final product = products[index];

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          productName: product['name'].toString(),
          productPrice: product['price'].toString(),
        ),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        cartMessage = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("ProductsPage: build");
    return Scaffold(
      appBar: AppBar(title: const Text("Products Catalog")),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey.shade200,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome, ${widget.username}!", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text("Screen width: ${currentWidth.toStringAsFixed(1)} px"),
                const SizedBox(height: 4),
                Text("Favorites: $favoritesCount", style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                if (cartMessage.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text("Cart Status: $cartMessage", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                ],
              ],
            ),
          ),
          Expanded(
            child: currentWidth < 600
                ? ProductsListView(
                    products: products,
                    onFavoritePressed: () {
                      setState(() {
                        favoritesCount++;
                      });
                    },
                    onProductTap: _handleProductTap,
                  )
                : ProductsGridView(
                    products: products,
                    onFavoritePressed: () {
                      setState(() {
                        favoritesCount++;
                      });
                    },
                    onProductTap: _handleProductTap,
                  ),
          ),
        ],
      ),
    );
  }
}
