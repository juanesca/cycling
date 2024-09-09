import 'package:app/core/usecases/auth.usecase.dart';
import 'package:app/core/utils/providers.dart';
import 'package:app/core/utils/route.constants.dart';
import 'package:app/core/utils/size.extension.dart';
import 'package:app/presentation/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});

  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  @override
  void initState() {
    _passwordCtrl.addListener(() => _validateForm(),);
    _emailCtrl.addListener(() => _validateForm(),);
    _nameCtrl.addListener(() => _validateForm(),);
    _confirmPasswordCtrl.addListener(() => _validateForm(),);
    super.initState();
  }

  @override
  void deactivate() {
    _passwordCtrl.removeListener(_validateForm);
    _emailCtrl.removeListener(_validateForm);
    _confirmPasswordCtrl.removeListener(_validateForm);
    _nameCtrl.removeListener(_validateForm);
    super.deactivate();
  }

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _emailCtrl.dispose();
    _nameCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();

  final _emailRegex = RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
  final _passwordRegex = RegExp(
      r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$",
      multiLine: true);

  bool _watchPassword = false;
  bool _validForm = false;

  String get _email => _emailCtrl.text;

  String get _password => _passwordCtrl.text;

  String get _name => _nameCtrl.text;

  String get _confirmPassword => _confirmPasswordCtrl.text;

  get _formValidation =>
      _email.isNotEmpty &&
      _password.isNotEmpty &&
      _confirmPassword.isNotEmpty &&
      _name.isNotEmpty &&
      _password == _confirmPassword &&
      _emailRegex.hasMatch(_email) &&
      _passwordRegex.hasMatch(_password);

  _validateForm() => setState(() {
        _validForm = _formValidation;
      });

  @override
  Widget build(BuildContext context) {
    final inputDeco = InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    );

    final mq = MediaQuery.of(context);

    ref.listen(authStateProvider, (previous, next) {
      if (next) {
        context.go(Routes.home);
      }
    },);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            bottom: mq.viewInsets.bottom,
            left: 10.sw,
            right: 10.sw,
            top: mq.viewInsets.bottom > 100 ? 10.sh : 15.sh),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Logo(
              size: 40.sw,
            ),
            SizedBox(
              height: 3.sh,
            ),
            const Text(
              'Registrate',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 2.sh,
            ),
            TextFormField(
              controller: _nameCtrl,
              textAlignVertical: TextAlignVertical.center,
              decoration: inputDeco.copyWith(
                  hintText: 'Ingrese su nombre completo', labelText: 'Nombre'),
            ),
            SizedBox(
              height: 3.sh,
            ),
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              textAlignVertical: TextAlignVertical.center,
              decoration: inputDeco.copyWith(
                  hintText: 'Ingrese su correo', labelText: 'Email'),
            ),
            SizedBox(
              height: 3.sh,
            ),
            TextFormField(
              controller: _passwordCtrl,
              textAlignVertical: TextAlignVertical.center,
              decoration: inputDeco.copyWith(
                  hintText: 'Ingrese su contraseña',
                  labelText: 'Contraseña',
                  suffixIcon: GestureDetector(
                    onTap: () => setState(() {
                      _watchPassword = !_watchPassword;
                    }),
                    child: Icon(_watchPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                  )),
              obscureText: !_watchPassword,
            ),
            SizedBox(
              height: 3.sh,
            ),
            TextFormField(
              controller: _confirmPasswordCtrl,
              textAlignVertical: TextAlignVertical.center,
              decoration: inputDeco.copyWith(
                  hintText: 'Reingrese su contraseña',
                  labelText: 'Confirmar contraseña',
                  suffixIcon: GestureDetector(
                    onTap: () => setState(() {
                      _watchPassword = !_watchPassword;
                    }),
                    child: Icon(_watchPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                  )),
              obscureText: !_watchPassword,
            ),
            SizedBox(
              height: 4.sh,
            ),
            ElevatedButton(
              onPressed: _validForm ? () {
                ref.read(authUseCase.notifier).signup(name: _name, email: _email, password: _password);
              } : null,
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  fixedSize: Size(80.sw, 5.sh),
                  backgroundColor: Colors.teal),
              child: const Text(
                'Crear cuenta',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 4.5.sh,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('¿Ya tienes una cuenta?\t',
                  style: TextStyle(color: Colors.black87)),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => context.go(Routes.login),
                child: Text(
                    style: TextStyle(
                        color: Colors.teal,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.teal),
                    'Inicia sesion'),
              )
            ])
          ],
        ),
      ),
    );
  }
}
