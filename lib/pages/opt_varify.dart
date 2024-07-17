import 'package:assingmentotp/model/MobileOtp.dart';
import 'package:assingmentotp/provider/lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:assingmentotp/util/buttons.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OtpVerify extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const OtpVerify({
    Key? key,
    required this.verificationId,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final TextEditingController _otpController = TextEditingController();
  final Authentication _auth = Authentication();
  bool _isLoading = false;
  String _errorText = '';

  void _verifyOtp() async {
    final otp = _otpController.text.trim();
    if (otp.isEmpty || otp.length != 6) {
      _showError('Please enter a valid 6-digit OTP');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = '';
    });

    final isSuccess = await _auth.signInWithOtp(widget.verificationId, otp);

    setState(() {
      _isLoading = false;
    });

    if (isSuccess) {
      Navigator.pushReplacementNamed(
          context, '/home'); // Adjust the route as needed
    } else {
      _showError('Failed to verify OTP. Please try again.');
    }
  }

  void _resendOtp() async {
    setState(() {
      _isLoading = true;
      _errorText = '';
    });

    final isSuccess = await _auth.resendOtp(widget.phoneNumber);

    setState(() {
      _isLoading = false;
    });

    if (isSuccess) {
      Fluttertoast.showToast(
        msg: "OTP has been sent again",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else {
      _showError('Failed to resend OTP. Please try again later.');
    }
  }

  void _showError(String message) {
    setState(() {
      _errorText = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                languageProvider.currentLanguage == 'en'
                    ? 'Verify Phone'
                    : 'Verificar Teléfono',
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
              ),
              Text(
                languageProvider.currentLanguage == 'en'
                    ? "Code is sent to your ${widget.phoneNumber}"
                    : "El código se ha enviado a tu ${widget.phoneNumber}",
              ),
              SizedBox(height: 20.h),
              Pinput(
                controller: _otpController,
                autofocus: true,
                defaultPinTheme: PinTheme(
                  width: 48.w,
                  height: 48.h,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(30, 60, 87, 1),
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(147, 210, 243, 1),
                    border: Border.all(
                        color: const Color.fromRGBO(15, 137, 238, 1)),
                    borderRadius: const BorderRadius.horizontal(),
                  ),
                ),
                length: 6,
                showCursor: true,
                onCompleted: (value) {
                  print(value);
                },
              ),
              if (_errorText.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Text(
                    _errorText,
                    style: TextStyle(color: Colors.red, fontSize: 12.sp),
                  ),
                ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    languageProvider.currentLanguage == 'en'
                        ? "Didn't receive the code?"
                        : "¿No recibiste el código?",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  TextButton(
                    onPressed: _resendOtp,
                    child: Text(
                      languageProvider.currentLanguage == 'en'
                          ? "Request Again"
                          : "Solicitar de Nuevo",
                      style: TextStyle(
                          fontSize: 15.sp, color: Colors.black),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.h),
              _isLoading
                  ? CircularProgressIndicator()
                  : Button(
                      text: languageProvider.currentLanguage == 'en'
                          ? 'VERIFY AND CONTINUE'
                          : 'VERIFICAR Y CONTINUAR',
                      height: 56.h,
                      width: 350.w,
                      onPressed: _verifyOtp,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
