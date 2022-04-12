import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../go_router_path.dart';
import 'sign_in_view_model.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(signInViewModelProvider);
    return Scaffold(
      body: Column(
        children: [
          const Center(
            child: Text('サインイン'),
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
            onPressed: () => viewModel.signIn(
              email: viewModel.emailTextEditingController.text,
              password: viewModel.passwordTextEditingController.text,
            ),
            child: const Text('サインイン'),
          ),
          ElevatedButton(
            /// GoRouter.of(context)go(GoRouterPath.signIn)
            /// の短縮形でcontext.goとかける
            onPressed: () => context.go(GoRouterPath.signUp),
            child: const Text('サインアップ画面へ'),
          ),
          Text('現在のロケーション【${GoRouter.of(context).location}】 やで')
        ],
      ),
    );
  }
}
