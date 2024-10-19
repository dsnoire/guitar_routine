import 'package:flutter/material.dart';

import '../../app/widgets/authentication_header.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthenticationHeader(title: 'Sign Up'),
        const Spacer(),
        _NameTextInput(),
        const SizedBox(height: 24),
        _EmailTextInput(),
        const SizedBox(height: 24),
        _PasswordTextInput(),
        const SizedBox(height: 24),
        _SignUpButton(),
        const SizedBox(height: 24),
        _NavigateToSignInButton(),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _NameTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person_outline_rounded),
        labelText: 'Name',
      ),
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

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('Sign Up'),
    );
  }
}

class _NavigateToSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: RichText(
        text: const TextSpan(
          text: 'Already have an account? ',
          style: TextStyle(
            color: Colors.grey,
          ),
          children: [
            TextSpan(
              text: 'Sign In here',
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
