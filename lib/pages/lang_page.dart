import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:assingmentotp/pages/mobile_number.dart';
import 'package:provider/provider.dart';
import 'package:assingmentotp/provider/lang.dart';
import '../app_localizations.dart'; // Adjust path as per your project structure
import '../util/buttons.dart';

class LangPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/Vector.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/Vector-1.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/image.png'),
                    width: 100.w, // Set the desired size (100% of width in this case)
                     // Apply a color tint (optional)
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    AppLocalizations.of(context)
                            ?.translate('select_language') ??
                        'Select Your Language',
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    AppLocalizations.of(context)
                            ?.translate('change_language_any_time') ??
                        'You can change the language at any time',
                    style: TextStyle(fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    width: 250.w, // Specify the width here
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Locale>(
                          isExpanded: true, // Set this to true
                          value: languageProvider.locale, // Set the current value
                          onChanged: (Locale? locale) {
                            if (locale != null) {
                              languageProvider.setLocale(
                                  locale); // Update the locale in LanguageProvider
                            }
                          },
                          items: const [
                            DropdownMenuItem(
                              value: Locale('en', ''),
                              child: Text('English'),
                            ),
                            DropdownMenuItem(
                              value: Locale('es', ''),
                              child: Text('Español'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Button(
                    text: AppLocalizations.of(context)?.translate('next') ??
                        'Next',
                    height: 48.h,
                    width: 250.w,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NumberPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
