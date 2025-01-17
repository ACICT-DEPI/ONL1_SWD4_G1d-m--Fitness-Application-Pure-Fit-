import 'package:PureFit/Core/Components/media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Components/custom_button.dart';
import '../../../../Core/Components/custom_snackbar.dart';
import '../../../../Core/Components/custom_text_field.dart';
import '../../../../Core/Routing/routes.dart';
import '../../../../Core/Shared/app_colors.dart';
import '../../../../Core/Shared/app_string.dart';
import '../Logic/change_password_cubit/change_password_cubit.dart';
import '../Logic/change_password_cubit/change_password_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String email;

  const ChangePasswordScreen({super.key, required this.email});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = CustomMQ(context);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordLoading) {
              showDialog(
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is ChangePasswordSuccess) {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, Routes.loginScreen);
            }
            if (state is ChangePasswordError) {
              CustomSnackbar.showSnackbar(context, state.error);
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: mq.height(5),
                        horizontal: mq.width(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppString.changePassword(context),
                            style: TextStyle(
                              fontSize: mq.width(8),
                              color: ColorManager.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppString.font
                            ),
                          ),
                          SizedBox(height: mq.height(2)),
                          Text(
                            AppString.enterNewPassword(context),
                            style: TextStyle(
                              fontSize: mq.width(4.5),
                              color: ColorManager.lightGreyColor,
                            ),
                          ),
                          SizedBox(height: mq.height(3)),
                          CustomTextField(
                            controller: _newPasswordController,
                            isPassword: true,
                            hintText: AppString.enterNewPassword(context),
                            textInput: TextInputType.visiblePassword,
                          ),
                          SizedBox(height: mq.height(3)),
                          CustomTextField(
                            controller: _confirmPasswordController,
                            isPassword: true,
                            hintText: AppString.confirmNewPassword(context),
                            textInput: TextInputType.visiblePassword,
                          ),
                          SizedBox(height: mq.height(3)),
                          CustomButton(
                            label: AppString.continuex(context),
                            onPressed: () {
                              if (_newPasswordController.text ==
                                  _confirmPasswordController.text) {
                                final cubit =
                                    context.read<ChangePasswordCubit>();
                                cubit.changePassword(
                                  widget.email,
                                  _newPasswordController.text,
                                  context,
                                );
                              } else {
                                CustomSnackbar.showSnackbar(
                                  context,
                                  AppString.passwordsDoNotMatch(context),
                                );
                              }
                            },
                            padding: EdgeInsets.symmetric(
                              horizontal: mq.width(20),
                              vertical: mq.height(2),
                            ),
                          ),
                          SizedBox(height: mq.height(2)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
