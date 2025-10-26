
import 'package:ecommerce_project/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:ecommerce_project/features/auth/presentation/screens/verity_otp_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../shared/presentation/widgets/centered_circular_progress.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../../data/models/sign_up_request_model.dart';
import '../controllers/sign_up_controller.dart';
import '../widgets/app_logo.dart';
import 'package:email_validator/email_validator.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _addressTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final SignUpController _signUpController = Get.find<SignUpController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
            key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  AppLogo(width: 80),
                  const SizedBox(height: 24),
                  Text('Create new account', style: textTheme.titleLarge),
                  Text(
                    'Please enter your details for new account',
                    style: textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                TextFormField(
                  controller: _emailTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Enter a valid email';
                    }
                    return null; // Email is valid
                  },
                ),

                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _firstNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'First name'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty ||  value.length<3) {
                        return 'First Name is required';
                      }
                      return null; // Email is valid
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _lastNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Last name'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty ||  value.length<3) {
                        return 'Last Name is required';
                      }
                      return null; // Email is valid
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _mobileTEController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: 'Mobile'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty ||  value.length!=11) {
                        return '11 Digit Mobile Number is required';
                      }
                      return null; // Email is valid
                    },

                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _addressTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Address'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty ||  value.length<3) {
                        return 'Address is required';
                      }
                      return null; // Email is valid
                    },

                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty ||  value.length<6) {
                        return 'At List 6 Length Character is required';
                      }
                      return null; // Email is valid
                    },
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<SignUpController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.signUpInProgress == false,
                        replacement: CenteredCircularProgress(),
                        child: FilledButton(
                          onPressed: _onTapSignUpButton,
                          child: Text('Sign Up'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: _onTapBackToLoginButton,
                    child: Text('Back to Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSignUpButton() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    SignUpRequestModel model = SignUpRequestModel(
      firstName: _firstNameTEController.text.trim(),
      lastName: _lastNameTEController.text.trim(),
      email: _emailTEController.text.trim(),
      password: _passwordTEController.text,
      city: _addressTEController.text.trim(),
      phone: _mobileTEController.text.trim(),
    );
    final bool isSuccess = await _signUpController.signUp(model);
    if (isSuccess) {
      showSnackBarMessage(context, 'Sign up successful! Please login');
      Navigator.pushNamed(context, VerifyOtpScreen.name,
          arguments: _emailTEController.text.trim());
    } else {
      showSnackBarMessage(context, _signUpController.errorMessage!);
    }
  }

  void _onTapBackToLoginButton() {
    Navigator.pushNamed(context, SignInScreen.name);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _addressTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}