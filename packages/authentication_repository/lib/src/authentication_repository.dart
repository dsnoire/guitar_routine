import 'package:authentication_repository/src/models/user.dart';
import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  final String message;

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}

class SignInWithEmailAndPasswordFailure implements Exception {
  const SignInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  final String message;

  factory SignInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const SignInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const SignInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const SignInWithEmailAndPasswordFailure();
    }
  }
}

class SignOutFailure implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository({
    FirebaseAuth? firebaseAuth,
    CacheClient? cacheClient,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _cacheClient = cacheClient ?? CacheClient();

  final FirebaseAuth _firebaseAuth;
  final CacheClient _cacheClient;

  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map(
      (firebaseUser) {
        final user = firebaseUser != null ? _toUser(firebaseUser) : UserModel.empty;
        _cacheClient.write(key: userCacheKey, value: user);
        return user;
      },
    );
  }

  UserModel get currentUser {
    return _cacheClient.read(key: userCacheKey) ?? UserModel.empty;
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignInWithEmailAndPasswordFailure();
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw SignOutFailure();
    }
  }
}

UserModel _toUser(User user) {
  return UserModel(
    id: user.uid,
    email: user.email,
    name: user.displayName,
    photo: user.photoURL,
  );
}
