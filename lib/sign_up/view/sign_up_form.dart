import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:guitar_routine/sign_up/cubit/sign_up_cubit.dart';

import '../../app/widgets/authentication_header.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - 70),
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AuthenticationHeader(title: 'Sign Up'),
              const Spacer(),
              _EmailTextInput(),
              const SizedBox(height: 24),
              _PasswordTextInput(),
              const SizedBox(height: 24),
              _ConfirmPasswordTextInput(),
              const SizedBox(height: 24),
              _SignUpButton(),
              const SizedBox(height: 24),
              _NavigateToSignInButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select((SignUpCubit cubit) => cubit.state.email.displayError);
    return TextField(
      onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_outlined),
        labelText: 'E-mail',
        errorText: displayError != null ? 'Invalid Email' : null,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class _PasswordTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select((SignUpCubit cubit) => cubit.state.password.displayError);
    return TextField(
      onChanged: (password) => context.read<SignUpCubit>().passwordChanged(password),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_open_rounded),
        labelText: 'Password',
        errorText: displayError != null ? 'Invalid Password' : null,
      ),
      obscureText: true,
    );
  }
}

class _ConfirmPasswordTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select((SignUpCubit cubit) => cubit.state.confirmedPassword.displayError);
    return TextField(
      onChanged: (password) => context.read<SignUpCubit>().confirmedPasswordChanged(password),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_rounded),
        labelText: 'Confirm password',
        errorText: displayError != null ? 'Passwords do not match' : null,
      ),
      obscureText: true,
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select((SignUpCubit cubit) => cubit.state.status.isInProgress);

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select((SignUpCubit cubit) => cubit.state.isValid);

    return ElevatedButton(
      onPressed: isValid ? () => context.read<SignUpCubit>().signUpFormSubmitted() : null,
      child: const Text('Sign Up'),
    );
  }
}

class _NavigateToSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.go('/sign-in'),
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
