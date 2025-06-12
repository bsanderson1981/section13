import 'package:flutter/material.dart';
import 'package:section13/screens/loading_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//git init && git add . && git commit -m "Initial commit" && git remote add origin https://github.com/bsanderson1981/section8 && git branch -M main && git push -u origin main
//finished  of section 13  #150
//void main() => runApp(MyApp());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // REQUIRED when doing async in main
  await dotenv.load(fileName: ".env");       // Loads your .env file
// ✅ DEBUG: Print API key to confirm it's loaded
  //print('Loaded API key: ${dotenv.env['OPEN_WEATHER_API_KEY']}');

  runApp(MyApp());
}



/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
