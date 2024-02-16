import 'package:app_fic10/core/extensions/build_context_ext.dart';
import 'package:app_fic10/data/datasources/auth_local_datasource.dart';
import 'package:app_fic10/data/models/request/login_request_model.dart';
import 'package:app_fic10/presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/constants/colors.dart';
import '../../home/pages/dashboard_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Log in'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          CustomTextField(
            controller: emailController,
            label: 'Email Address',
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
            controller: passwordController,
            label: 'Password',
            obscureText: true,
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 42.0),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: (data) {
                  //simpan data ke local storage
                  AuthLocalDatasource().saveAuthData(data);
                  //snackbar
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Login Berhasil'),
                    backgroundColor: Colors.green,
                  ));
                  // context.pushReplacement(const DashboardPage());
                  context.pushReplacement(const DashboardPage());
                },
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => Button.filled(
                  onPressed: () {
                    final requestModel = LoginRequestModel(
                        email: emailController.text,
                        password: passwordController.text);
                    context
                        .read<LoginBloc>()
                        .add(LoginEvent.login(requestModel));
                  },
                  label: 'LOG IN',
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          const SizedBox(height: 24.0),
          GestureDetector(
            onTap: () {
              context.pushReplacement(const RegisterPage());
            },
            child: const Text.rich(
              TextSpan(
                text: 'Don\'t have an account? ',
                children: [
                  TextSpan(
                    text: 'Sign up',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
