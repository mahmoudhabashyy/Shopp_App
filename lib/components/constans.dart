import '../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(context) {
  CacheHelper.removeData(key: "token").then((value) {
    if (value) {
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    }
  });
}


//الميثود دي بتعمل loop وبتطبع كل حاجه في ال text

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token='';
