import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope_app/models/categories_model.dart';
import 'package:shope_app/shared/cubit/cubit.dart';
import 'package:shope_app/shared/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(ShopAppCubit.get(context).categoriesModel!.data!.data[index]),
          separatorBuilder: (context, index) => const Divider(
            thickness: 1.0,
            color: Colors.grey,
          ),
          itemCount: ShopAppCubit.get(context).categoriesModel!.data!.data.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) =>  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                  model.image!,
              ),
              height: 80.0,
              width: 80.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              model.name!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
