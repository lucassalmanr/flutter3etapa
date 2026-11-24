import 'package:firebase_core/firebase_core.dart';

/// Configuração fornecida em tempo de execução, sem versionar credenciais.
///
/// Gere este arquivo com `flutterfire configure` para o projeto da escola ou,
/// no Chrome, informe os valores equivalentes com `--dart-define`.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    const apiKey = String.fromEnvironment('FIREBASE_API_KEY');
    const appId = String.fromEnvironment('FIREBASE_APP_ID');
    const messagingSenderId =
        String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID');
    const projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');

    if (apiKey.isEmpty ||
        appId.isEmpty ||
        messagingSenderId.isEmpty ||
        projectId.isEmpty) {
      throw StateError(
        'Configuração do Firebase ausente. Execute `flutterfire configure` '
        'ou informe FIREBASE_API_KEY, FIREBASE_APP_ID, '
        'FIREBASE_MESSAGING_SENDER_ID e FIREBASE_PROJECT_ID com --dart-define.',
      );
    }

    return const FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      authDomain: String.fromEnvironment('FIREBASE_AUTH_DOMAIN'),
      storageBucket: String.fromEnvironment('FIREBASE_STORAGE_BUCKET'),
      measurementId: String.fromEnvironment('FIREBASE_MEASUREMENT_ID'),
    );
  }
}
