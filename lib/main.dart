
// a) Which methods run when a page opens for the first time?
//    1. initState()
//    2. didChangeDependencies()
//    3. build()
//
// b) Which method runs again after you press the heart button?
//    - build() only (triggered by setState()).
//
// c) Which methods run when you leave a page and go back?
//    - When leaving via Navigator.push (Products -> Details):
//      DetailsPage runs: initState -> didChangeDependencies -> build.
//      (ProductsPage stays alive in the background stack, so dispose is NOT called).
//    - When returning via Navigator.pop (Details -> Products):
//      DetailsPage runs: deactivate() -> dispose().
//      ProductsPage runs: build() (to update the screen with the cart message via setState).
//
// d) Which methods run when you resize the browser window, and why?
//    - didChangeDependencies() and build().
//    - Why: Because the page depends on MediaQuery (InheritedWidget). When the
//      window dimensions change, MediaQuery notifies its listeners, which triggers
//      didChangeDependencies() first, followed by build() to update the layout.
// ============================================================================

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'products_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Product Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/products': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as String? ?? 'Guest';
          return ProductsPage(username: args);
        },
      },
    );
  }
}
