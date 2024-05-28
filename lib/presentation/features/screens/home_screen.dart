import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_book_shop/presentation/features/bloc/catalog/catalog_bloc.dart';
import 'package:simple_book_shop/presentation/features/screens/cart_screen.dart';
import 'package:simple_book_shop/presentation/features/screens/catalog_screen.dart';
import 'package:simple_book_shop/presentation/features/screens/favourite_screen.dart';
import 'package:simple_book_shop/presentation/features/screens/profile_screen.dart';
import 'package:simple_book_shop/presentation/features/widgets/appbar_profile_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<CatalogBloc>(context).add(LoadCatalog());
    super.initState();
  }

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const CatalogScreen(),
    const CartScreen(),
    const FavouriteScreen(),
    const ProfileScreen(),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: const [AppBarProfileIcon()],
          automaticallyImplyLeading: false,
          title: Text(
            'Каталог',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        bottomNavigationBar: NavigationBar(
          destinations: <Widget>[
            NavigationDestination(
              selectedIcon: const Icon(Icons.book),
              icon: Icon(
                Icons.book_outlined,
                color: Theme.of(context).colorScheme.primary.withAlpha(180),
              ),
              label: 'Каталог',
            ),
            NavigationDestination(
              selectedIcon: const Icon(Icons.shopping_cart),
              icon: Icon(Icons.shopping_cart_outlined,
                  color: Theme.of(context).colorScheme.primary.withAlpha(180)),
              label: 'Корзина',
            ),
            NavigationDestination(
              selectedIcon: const Icon(Icons.favorite),
              icon: Icon(Icons.favorite_border_outlined,
                  color: Theme.of(context).colorScheme.primary.withAlpha(180)),
              label: 'Избранное',
            ),
            NavigationDestination(
              selectedIcon: const Icon(Icons.person),
              icon: Icon(Icons.person_outlined,
                  color: Theme.of(context).colorScheme.primary.withAlpha(180)),
              label: 'Профиль',
            ),
          ],
          onDestinationSelected: _onDestinationSelected,
          selectedIndex: _selectedIndex,
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ));
  }
}
