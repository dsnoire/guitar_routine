import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../app/widgets/authentication_header.dart';
import '../cubit/sign_in_cubit.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - 70),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select((SignInCubit cubit) => cubit.state.email.displayError);

    return TextField(
      onChanged: (email) => context.read<SignInCubit>().emailChanged(email),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_outlined),
        labelText: 'E-mail',
        errorText: displayError != null ? 'Invalid email' : null,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class _PasswordTextInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select((SignInCubit cubit) => cubit.state.password.displayError);
    return TextField(
      onChanged: (password) => context.read<SignInCubit>().passwordChanged(password),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_open_rounded),
        labelText: 'Password',
        errorText: displayError != null ? 'Invalid password' : null,
      ),
      obscureText: true,
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select((SignInCubit cubit) => cubit.state.status.isInProgress);

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select((SignInCubit cubit) => cubit.state.isValid);

    return ElevatedButton(
      onPressed: isValid ? () => context.read<SignInCubit>().signInWithCredentials() : null,
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
