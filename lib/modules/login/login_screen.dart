import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope_app/components/components.dart';
import 'package:shope_app/layout/shop_layout.dart';
import 'package:shope_app/network/local/cache_helper.dart';
import 'package:shope_app/shared/cubit/states.dart';
import '../../shared/cubit/cubit.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => ShopAppCubit(),
      child: BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {
          if (state is ShopAppSuccessState) {
            if (state.loginModel.status == true) {
              debugPrint(state.loginModel.message);
              debugPrint(state.loginModel.data!.token);
              CacheHelper.saveData(
                key: "token",
                value: state.loginModel.data!.token,
              ).then((value) {
                navigateAndFinish(
                  context,
                  const ShopLayout(),
                );
              });
            } else{
              debugPrint(state.loginModel.message);
              showToast(
                text: state.loginModel.message ??'',
                state: ToastStates.error,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          prefix: Icons.email_outlined,
                          label: "Email Address",
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopAppCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopAppCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          prefix: Icons.lock_outline,
                          isPassword: ShopAppCubit.get(context).isPassword,
                          label: "Password",
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopAppCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                            condition: state is! ShopAppLoadingState,
                            builder: (context) => defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopAppCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  text: 'login',
                                  isUpperCase: true,
                                ),
                            fallback: (context) =>
                                const CircularProgressIndicator()),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(context, const RegisterScreen());
                              },
                              text: 'register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
