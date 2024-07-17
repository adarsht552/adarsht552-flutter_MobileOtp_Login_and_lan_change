import 'package:assingmentotp/provider/lang.dart';
import 'package:assingmentotp/util/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                languageProvider.currentLanguage == 'en' 
                  ? 'Please select your profile'
                  : 'Por favor seleccione su perfil',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              ProfileOption(
                imagePath: 'assets/Group (1).png',
                title: languageProvider.currentLanguage == 'en' ? 'Shipper' : 'Remitente',
                description: languageProvider.currentLanguage == 'en'
                  ? 'Lorem ipsum dolor sit amet, consectetur adipiscing'
                  : 'Lorem ipsum dolor sit amet, consectetur adipiscing',
              ),
              SizedBox(height: 10.h),
              ProfileOption(
                imagePath: 'assets/Vector2.png',
                title: languageProvider.currentLanguage == 'en' ? 'Transporter' : 'Transportista',
                description: languageProvider.currentLanguage == 'en'
                  ? 'Lorem ipsum dolor sit amet, consectetur adipiscing'
                  : 'Lorem ipsum dolor sit amet, consectetur adipiscing',
              ),
              SizedBox(height: 20.h),
              Button(
                text: languageProvider.currentLanguage == 'en' ? 'CONTINUE' : 'CONTINUAR',
                height: 56.h,
                width: double.infinity,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const ProfileOption({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        child: Row(
          children: [
            Radio(
              value: false,
              groupValue: null,
              onChanged: (value) {},
            ),
            SizedBox(width: 8.w),
            Image.asset(
              imagePath,
              width: 40.w,
              height: 40.h,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
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