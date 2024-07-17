import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:assingmentotp/pages/opt_varify.dart';
import 'package:provider/provider.dart';
import 'package:assingmentotp/app_localizations.dart';
import 'package:assingmentotp/util/buttons.dart';
import 'package:assingmentotp/model/MobileOtp.dart'; // Check if this path is correct
import 'package:assingmentotp/provider/lang.dart';

class NumberPage extends StatefulWidget {
  const NumberPage({Key? key}) : super(key: key);

  @override
  State<NumberPage> createState() => _NumberPageState();
}

class _NumberPageState extends State<NumberPage> {
  final TextEditingController _phoneController = TextEditingController();
  final Authentication _auth = Authentication();
  bool _isLoading = false;
  String _errorText = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false, // Ensures the screen doesn't resize when keyboard appears
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0.w),
              child: Consumer<LanguageProvider>(
                builder: (context, languageProvider, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      languageProvider.currentLanguage == 'en'
                          ? "Please enter your mobile number"
                          : "Introduzca su número de móvil",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      languageProvider.currentLanguage == 'en'
                          ? "You'll receive a 4 digit code"
                          : "Recibirás un código de 4 dígitos",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      languageProvider.currentLanguage == 'en'
                          ? 'to verify next step'
                          : 'para verificar el siguiente paso',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              children: [
                                SizedBox(width: 5.w),
                                Image(image: AssetImage('assets/india 2.png'), width: 20.w),
                                Text('+91', style: TextStyle(fontSize: 16.sp)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              autofocus: true,
                              controller: _phoneController,
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)?.translate('mobile_number') ?? 'Mobile Number',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_errorText.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Text(
                          _errorText,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ),
                    SizedBox(height: 20.h),
                    _isLoading
                        ? CircularProgressIndicator()
                        : SizedBox(
                            width: 400.w,
                            height: 50.h,
                            child: Button(
                              text: AppLocalizations.of(context)?.translate('continue') ?? "Continue", 
                              height: 56.h,
                              width: 400.w,
                              onPressed: _sendOtp,
                            ),
                          ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/Group 3.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
            ),
         
          ],
        ),
      ),
    );
  }

  void _sendOtp() async {
    final number = _phoneController.text.trim();
    if (number.isEmpty || number.length != 10) {
      _showError('Please enter a valid 10-digit mobile number');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = '';
    });

    try {
      final verificationId = await _auth.sendOtp('+91$number');
      setState(() {
        _isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerify(verificationId: verificationId, phoneNumber: number),
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showError('Failed to send OTP. Please try again.');
    }
  }

  void _showError(String message) {
    setState(() {
      _errorText = message;
    });
  }
}
