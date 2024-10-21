import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/widgets/authentication_header.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthenticationHeader(title: 'Sign In'),
        const Spacer(),
        _EmailTextInput(),
        const SizedBox(height: 24),
        _PasswordTextInput(),
        const SizedBox(height: 24),
        _SignInButton(),
        const SizedBox(height: 24),
        _NavigateToSignUpButton(),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _EmailTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
        labelText: 'E-mail',
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class _PasswordTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock_open_rounded),
        labelText: 'Password',
      ),
      obscureText: true,
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('Sign In'),
    );
  }
}

class _NavigateToSignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.go('/sign-up'),
      child: RichText(
        text: const TextSpan(
          text: 'Don\'t have an account yet? ',
          style: TextStyle(
            color: Colors.grey,
          ),
          children: [
            TextSpan(
              text: 'Sign Up here',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
