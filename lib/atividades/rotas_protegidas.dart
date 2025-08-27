import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  bool _autenticado = false;
  bool get autenticado => _autenticado;

  void login() {
    _autenticado = true;
    notifyListeners();
  }

  void logout() {
    _autenticado = false;
    notifyListeners();
  }
}

class RotasProtegidasApp extends StatelessWidget {
  const RotasProtegidasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: AuthService(),
      child: Builder(
        builder: (context) {
          final auth = ChangeNotifierProvider.of<AuthService>(context);
          return MaterialApp(
            title: 'Rotas Protegidas',
            initialRoute: '/',
            onGenerateRoute: (settings) {
              if (settings.name == '/privada1') {
                if (!auth.autenticado) return MaterialPageRoute(builder: (_) => LoginPage(auth: auth));
                return MaterialPageRoute(builder: (_) => Privada1Page(auth: auth));
              }
              if (settings.name == '/privada2') {
                if (!auth.autenticado) return MaterialPageRoute(builder: (_) => LoginPage(auth: auth));
                final dados = settings.arguments as Map<String, dynamic>?;
                return MaterialPageRoute(builder: (_) => Privada2Page(auth: auth, dados: dados ?? {}));
              }
              if (settings.name == '/publica') {
                return MaterialPageRoute(builder: (_) => const PublicaPage());
              }
              return MaterialPageRoute(builder: (_) => HomePage(auth: auth));
            },
            navigatorKey: navigatorKey,
          );
        },
      ),
    );
  }
}

final navigatorKey = GlobalKey<NavigatorState>();

class HomePage extends StatelessWidget {
  final AuthService auth;
  const HomePage({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')), 
      body: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Bem-vindo!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/privada1'),
                  child: const Text('Ir para Privada 1'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    '/privada2',
                    arguments: {
                      'nome': 'Maycon Garcia Silva',
                      'dataNascimento': '24/03/2005',
                      'telefone': '(64) 992675684',
                    },
                  ),
                  child: const Text('Ir para Privada 2 (com dados)'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/publica'),
                  child: const Text('Ir para Pública'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final AuthService auth;
  const LoginPage({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Faça login para acessar as rotas privadas', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    auth.login();
                    Navigator.pop(context);
                  },
                  child: const Text('Fazer Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Privada1Page extends StatelessWidget {
  final AuthService auth;
  const Privada1Page({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privada 1')),
      body: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Bem-vindo à rota privada 1!', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    auth.logout();
                    Navigator.pop(context);
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Privada2Page extends StatelessWidget {
  final AuthService auth;
  final Map<String, dynamic> dados;
  const Privada2Page({super.key, required this.auth, required this.dados});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privada 2')),
      body: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Nome: ${dados['nome'] ?? ''}', style: const TextStyle(fontSize: 16)),
                Text('Data de Nascimento: ${dados['dataNascimento'] ?? ''}', style: const TextStyle(fontSize: 16)),
                Text('Telefone: ${dados['telefone'] ?? ''}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    auth.logout();
                    Navigator.pop(context);
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PublicaPage extends StatelessWidget {
  const PublicaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pública')),
      body: Center(
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.all(24),
          child: const Padding(
            padding: EdgeInsets.all(24),
            child: Text('Esta é uma rota pública!', style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}

// Provider para gerenciamento de estado simples
class ChangeNotifierProvider<T extends ChangeNotifier> extends InheritedNotifier<T> {
  const ChangeNotifierProvider({super.key, required T create, required super.child}) : super(notifier: create);

  static T of<T extends ChangeNotifier>(BuildContext context, {bool listen = true}) {
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<ChangeNotifierProvider<T>>()
        : context.getElementForInheritedWidgetOfExactType<ChangeNotifierProvider<T>>()?.widget as ChangeNotifierProvider<T>?;
    if (provider == null) throw FlutterError('Provider não encontrado para $T');
    return provider.notifier!;
  }
}
