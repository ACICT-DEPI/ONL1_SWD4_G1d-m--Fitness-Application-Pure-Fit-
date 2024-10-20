import 'package:fitpro/Core/DI/dependency.dart';

import 'package:fitpro/Core/Components/media_query.dart';
import 'package:fitpro/Core/Routing/routes.dart';
import 'package:flutter/material.dart';
import '../../../../Core/Components/custom_button.dart';
import '../../../../Core/Components/custom_text_field.dart';
import '../../../../Core/Shared/app_colors.dart';
import '../Logic/forgot_pass_cubit/forgot_password_cubit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final ForgotPasswordCubit _forgotPasswordCubit = getIT<ForgotPasswordCubit>();

  @override
  Widget build(BuildContext context) {
    final mq = CustomMQ(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: mq.height(10), horizontal: mq.width(5)),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Forgot Password!",
                style: TextStyle(
                  fontSize: mq.width(10),
                  color: ColorManager.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: mq.width(4)),
            Text(
              "Enter your email, we will send you a code on your email",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: mq.width(4),
                color: ColorManager.lightGreyColor,
              ),
            ),
            SizedBox(height: mq.width(4)),
            CustomTextField(
              controller: _emailController,
              textInput: TextInputType.text,
              isPassword: false,
              hintText: "Enter your email",
            ),
            SizedBox(height: mq.width(4)),
            CustomButton(
              label: "Continue",
              padding: EdgeInsets.symmetric(
                horizontal: mq.width(20),
                vertical: mq.height(2),
              ),
              onPressed: () {
                _forgotPasswordCubit.sendCode(_emailController.text);
                 Navigator.pushNamed(
                  context,
                  Routes.verificationScreen,
                  arguments: _emailController.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
