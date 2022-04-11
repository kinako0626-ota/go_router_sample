import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sign_up_view_model.dart';

class SignUp extends ConsumerWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(signUpViewModelProvider);
    return Stack(
      children: [
        if (viewModel.isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
        Scaffold(
          body: Column(
            children: [
              const Center(
                child: Text('サインアップ'),
              ),
              TextFormField(
                controller: viewModel.firstNameTextEditingController,
              ),
              TextFormField(
                controller: viewModel.lastNameTextEditingController,
              ),
              TextFormField(
                controller: viewModel.emailTextEditingController,
              ),
              TextFormField(
                controller: viewModel.passwordTextEditingController,
              ),
              ElevatedButton(
                onPressed: () => viewModel.signUp(
                  email: viewModel.emailTextEditingController.text,
                  password: viewModel.passwordTextEditingController.text,
                ),
                child: const Text('サインアップ'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
