import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String productName;
  final String productPrice;

  const DetailsPage({
    super.key,
    required this.productName,
    required this.productPrice,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    print("DetailsPage: initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("DetailsPage: didChangeDependencies");
  }

  @override
  void deactivate() {
    print("DetailsPage: deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    print("DetailsPage: dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("DetailsPage: build");
    return Scaffold(
      appBar: AppBar(title: Text(widget.productName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Product: ${widget.productName}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Price: \$${widget.productPrice}", style: const TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final message = "${widget.productName} added to cart";
                Navigator.pop(context, message);
              },
              child: const Text("Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }
}
