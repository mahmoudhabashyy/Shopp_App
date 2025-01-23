import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope_app/models/home_model.dart';
import 'package:shope_app/shared/cubit/cubit.dart';
import 'package:shope_app/shared/cubit/states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopAppCubit.get(context).homeModel != null,
          builder: (context) =>
              productsBuilder(ShopAppCubit.get(context).homeModel!),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model) => const Column(
        children: [
          // CarouselSlider(
          //   items: model.data?.banners?.map((e) => Image(
          //           image: NetworkImage('${e.image}'),
          //         ),
          //       ).toList(),
          //   options: CarouselOptions(
          //     height: 250.0,
          //     initialPage: 0,
          //     enableInfiniteScroll: true,
          //     viewportFraction: 1.0,
          //     reverse: false,
          //     autoPlay: true,
          //     autoPlayInterval: const Duration(seconds: 3),
          //     autoPlayAnimationDuration: const Duration(seconds: 1),
          //     autoPlayCurve: Curves.fastOutSlowIn,
          //     scrollDirection: Axis.horizontal,
          //   ),
          // ),
        ],
      );
}
