import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope_app/modules/search/search_screen.dart';

import '../components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit ,ShopAppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var cubit = ShopAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Salla'),
            actions: [
              IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, const SearchScreen(),);
                  },
                  icon: const Icon(
                    Icons.search,
                  ),
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                label: 'Fanvorites',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
