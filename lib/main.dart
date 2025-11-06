import 'package:flutter/material.dart';

void main() {
  runApp(const LoginFormApp());
}

class LoginFormApp extends StatefulWidget {
  const LoginFormApp({super.key});

  @override
  State<LoginFormApp> createState() => _LoginFormAppState();
}

class _LoginFormAppState extends State<LoginFormApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : _themeMode == ThemeMode.dark
          ? ThemeMode.system
          : ThemeMode.light;
    });
  }

  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: const Color(0xFFE0F2F1),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.teal),
        foregroundColor: MaterialStatePropertyAll(Colors.white),
        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        elevation: MaterialStatePropertyAll(4),
      ),
    ),
  );

  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: const Color(0xFF121212),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[900],
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.teal.shade700),
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 16),
        ),
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        elevation: const MaterialStatePropertyAll(4),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Form',
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(
        onToggleTheme: _toggleTheme,
        currentThemeMode: _themeMode,
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode currentThemeMode;

  const LoginScreen({
    super.key,
    required this.onToggleTheme,
    required this.currentThemeMode,
  });

  void _handleLogin(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Login button pressed')));
  }

  @override
  Widget build(BuildContext context) {
    IconData themeIcon;
    if (currentThemeMode == ThemeMode.dark) {
      themeIcon = Icons.wb_sunny;
    } else if (currentThemeMode == ThemeMode.light) {
      themeIcon = Icons.mode_night;
    } else {
      themeIcon = Icons.settings_brightness;
    }

    final highContrastTextColor = Theme.of(context).textTheme.titleLarge?.color;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [IconButton(icon: Icon(themeIcon), onPressed: onToggleTheme)],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.lock_open_rounded,
                size: 80,
                color: highContrastTextColor,
              ),
              const SizedBox(height: 16.0),

              Text(
                'Selamat Datang',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: highContrastTextColor,
                ),
              ),
              const SizedBox(height: 32.0),

              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16.0),

              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 32.0),

              ElevatedButton(
                onPressed: () => _handleLogin(context),
                child: const Text('Login'),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
