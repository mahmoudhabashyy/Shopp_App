import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope_app/models/home_model.dart';
//import 'package:shope_app/models/home_model.dart';
import 'package:shope_app/shared/cubit/cubit.dart';
import 'package:shope_app/shared/cubit/states.dart';

import '../../models/categories_model.dart';



class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopAppCubit.get(context).homeModel != null&& ShopAppCubit.get(context).categoriesModel!=null,
          builder: (context) =>
              productsBuilder(ShopAppCubit.get(context).homeModel!,ShopAppCubit.get(context).categoriesModel!),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }



  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel) =>   SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data?.banners.map((e) => Image(image: NetworkImage('${e.image}')),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                viewportFraction: 1.0,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100.0,
                    color: Colors.grey[200],
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data!.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoriesModel.data!.data.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'New Products',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 24.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey,
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.56,
                children: List.generate(
                  model.data!.products.length,
                  (index) => buildGridProducts(model.data!.products[index]),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
           Image(
            image: NetworkImage(model.image!),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(
              .8,
            ),
            width: 100.0,
            child:  Text(
              model.name!,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );

  Widget buildGridProducts(ProductModel model) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200.0,
                  //fit: BoxFit.cover,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 1.3,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${model.price!.round()}",
                        style: const TextStyle(
                          //height: 1.2,
                          fontSize: 12.0,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          "${model.oldPrice!.round()}",
                          style: const TextStyle(
                            //height: 1.2,
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 15.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
