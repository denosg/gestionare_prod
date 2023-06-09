import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestionare_prod/providers/items_list.dart';
import 'package:gestionare_prod/screens/add_listing_screen.dart';
import 'package:gestionare_prod/screens/listing_details_screen.dart';
import 'package:provider/provider.dart';

import '/theme/theme.dart';
import '/screens/listings_overview_screen.dart';

//TODO: make photoUrl nullable
void main() {
  //Makes it so SystemChrome.setPreferredOrientations works
  WidgetsFlutterBinding.ensureInitialized();
  //Sets preffered orientations
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //Runs the app on boot
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ItemListProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.lightTheme,
        themeMode: ThemeMode.system,
        home: const ListingsOverviewScreen(),
        routes: {
          AddListingScreen.routeName: (context) => AddListingScreen(),
          ListingDetailsScreen.routeName: (context) => ListingDetailsScreen(),
        },
      ),
    );
  }
}
