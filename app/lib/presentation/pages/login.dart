import 'package:app/core/usecases/auth.usecase.dart';
import 'package:app/core/utils/providers.dart';
import 'package:app/core/utils/route.constants.dart';
import 'package:app/core/utils/size.extension.dart';
import 'package:app/presentation/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Login extends ConsumerStatefulWidget {
  Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  @override
  void initState() {
    _passwordCtrl.addListener(_validateForm);
    _emailCtrl.addListener(_validateForm);
    super.initState();
  }

  @override
  void deactivate() {
    _passwordCtrl.removeListener(_validateForm);
    _emailCtrl.removeListener(_validateForm);
    super.deactivate();
  }

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  final _emailRegex = RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
  final _passwordRegex = RegExp(
      r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$",
      multiLine: true);

  bool _watchPassword = false;
  bool _validForm = false;

  String get _email => _emailCtrl.text;

  String get _password => _passwordCtrl.text;

  get _formValidation =>
      _email.isNotEmpty &&
      _password.isNotEmpty &&
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
            top: mq.viewInsets.bottom > 100 ? 10.sh : 30.sh),
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
            const Text('Bienvenido', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
            SizedBox(height: 2.sh,),
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
              height: 4.sh,
            ),
            ElevatedButton(
              onPressed: _validForm ? () {
                print('tap');
                ref.read(authUseCase.notifier).login(_email, _password);
                context.go(Routes.home);
              } : null,
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  fixedSize: Size(80.sw, 5.sh),
                  backgroundColor: Colors.teal),
              child: const Text(
                'Iniciar Sesion',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 4.5.sh,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('¿Aun no tienes una cuenta?\t',
                  style: TextStyle(color: Colors.black87)),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => context.go(Routes.signup),
                child: Text(
                    style: TextStyle(
                        color: Colors.teal,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.teal),
                    'Registrate'),
              )
            ])
          ],
        ),
      ),
    );
  }
}
