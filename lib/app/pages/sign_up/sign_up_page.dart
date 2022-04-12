import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../go_router_path.dart';
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
                decoration: const InputDecoration(hintText: 'first name'),
              ),
              TextFormField(
                controller: viewModel.lastNameTextEditingController,
                decoration: const InputDecoration(hintText: 'last name'),
              ),
              TextFormField(
                controller: viewModel.emailTextEditingController,
                decoration: const InputDecoration(hintText: 'email'),
              ),
              TextFormField(
                controller: viewModel.passwordTextEditingController,
                decoration: const InputDecoration(hintText: 'password'),
              ),
              ElevatedButton(
                onPressed: () => viewModel.signUp(
                  email: viewModel.emailTextEditingController.text,
                  password: viewModel.passwordTextEditingController.text,
                ),
                child: const Text('サインアップ'),
              ),
              ElevatedButton(
                /// GoRouter.of(context)go(GoRouterPath.signIn)
                /// の短縮形でcontext.goとかける
                onPressed: () => context.go(GoRouterPath.signIn),
                child: const Text('サインイン画面へ'),
              ),
              Text('現在のロケーション【${GoRouter.of(context).location}】 やで')
            ],
          ),
        ),
      ],
    );
  }
}
