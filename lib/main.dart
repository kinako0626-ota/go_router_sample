import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app/firebase/firebase_auth/firebase_auth_service.dart';
import 'app/pages/error_page.dart';
import 'app/pages/sign_in/sign_in_page.dart';
import 'app/pages/sign_up/sign_up_page.dart';
import 'app/pages/top_page/top_page.dart';
import 'go_router_path.dart';

void main() {
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(firebaseAuthServiceProvider);
    final router = GoRouter(
      debugLogDiagnostics: kDebugMode,
      refreshListenable: GoRouterRefreshStream(auth.authStateStream),
      routes: [
        GoRoute(
          path: GoRouterPath.top,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const TopPage(),
          ),
          redirect: (state) {
            /// 会員登録していない状態でアクセスしたらサインイン画面へ遷移
            if (auth.currentUser == null) {
              return GoRouterPath.signIn;
            }
            return null;
          },
        ),
        GoRoute(
          path: GoRouterPath.signIn,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const SignInPage(),
          ),
          redirect: (state) {
            if (auth.currentUser != null) {
              return GoRouterPath.top;
            }
            return null;
          },
        ),
        GoRoute(
          path: GoRouterPath.signUp,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const SignUp(),
          ),
          redirect: (state) {
            if (auth.currentUser != null) {
              return GoRouterPath.top;
            }
            return null;
          },
        ),
      ],
      errorPageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ErrorPage(
          errorText: '無効なアクセスです。',
        ),
      ),
    );
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
