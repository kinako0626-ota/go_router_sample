import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      debugLogDiagnostics: kDebugMode,
      refreshListenable:
          GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
      routes: [
        GoRoute(
          path: GoRouterPath.top,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const TopPage(),
          ),
        ),
        GoRoute(
          path: GoRouterPath.signIn,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const SignInPage(),
          ),
        ),
        GoRoute(
          path: GoRouterPath.signUp,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const SignUp(),
          ),
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
