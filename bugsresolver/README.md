# Central de Achados — Projeto corrigido

## Preparação

O ZIP não contém as credenciais do projeto Firebase da escola. Instale o FlutterFire CLI e, na raiz deste projeto, gere a configuração real:

```sh
flutterfire configure
flutter pub get
```

O comando substitui `lib/firebase_options.dart` pelos valores do projeto selecionado. Não versione credenciais de um projeto particular sem autorização.

No Console do Firebase:

1. ative **Authentication > Google**;
2. cadastre o domínio usado no teste;
3. mantenha as regras de segurança do Firestore fornecidas pela escola habilitadas.

## Execução e verificação

```sh
flutter run -d chrome --web-port=8080
flutter analyze
flutter test
```

O arquivo `LAUDO.md` descreve os 12 bugs, as correções e o roteiro de teste com duas contas. A captura real deve ser salva em `evidencias/duas-contas-mesma-ocorrencia.png`.

**Privacidade:** use contas e dados próprios para teste e não publique informações pessoais reais.
