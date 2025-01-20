import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
  (Route<dynamic>route) => false,
);


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? onTap,
  bool isPassword = false,
  required Function validate,
  required IconData prefix,
  IconData? suffix,
  required String label,
  bool isClickable = true,
  Function()? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      enabled: isClickable,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      onChanged: onChange,
      validator: (s) {
        return validate(s);
      },

      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null ? IconButton(onPressed: suffixPressed, icon: Icon(suffix)) : null,
        border: const OutlineInputBorder(),
      ),
    );


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 0.0,
  bool isUpperCase = true,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton({
  required Function()? function,
  required String text,
}) => TextButton(
    onPressed: function,
    child: Text(
      text.toUpperCase(),
    ),
);

//suffix != null
//             ? IconButton(
//           onPressed: suffixPressed,
//           icon: Icon(suffix),
//         )
//             : null,

void showToast({
  required String text,
  required ToastStates state,
}) => Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastStates{success ,error ,warning}

Color chooseToastColor(ToastStates state)
{
  Color color;
  switch (state)
  {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
        color = Colors.amber;
      break;
  }
  return color;
}