import 'package:flutter/material.dart';
import 'package:takvim_projesi/core/base/state/base_state.dart';
import 'package:takvim_projesi/core/components/style/style_types.dart';
import 'package:takvim_projesi/core/constants/calendar_constants.dart';

class LoginForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  const LoginForm(this.submitFn, this.isLoading, {Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends BaseState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          loginCalendarIcon(),
          mailTextField(),
          if (!_isLogin) kullaniciAdiTextField(),
          sifreGirisTextField(),
          sifremiUnuttumButton(),
          loginButton(),
          const SizedBox(height: 10),
          registerButton(),
        ],
      ),
    );
  }

  Padding loginCalendarIcon() {
    return Padding(
      padding: EdgeInsets.only(top: dynamicHeight(0.03)),
      child: Center(
        child: Container(
          alignment: Alignment.topCenter,
          width: dynamicWidth(0.6),
          height: dynamicHeight(0.12),
          child: Image.asset(
            CalendarConstants.instance.loginIcon,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Padding mailTextField() {
    return Padding(
      padding: EdgeInsets.only(
        left: dynamicWidth(0.03),
        right: dynamicWidth(0.03),
        top: dynamicHeight(0.03),
        bottom: 0,
      ),
      child: TextFormField(
        key: ValueKey(CalendarConstants.instance.girisMailYz),
        obscureText: false,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: CalendarConstants.instance.girisMailYz,
          hintText: CalendarConstants.instance.girisMailYz,
        ),
        style: StyleTypes.instance.textStyle(
          CalendarConstants.instance.black,
          CalendarConstants.instance.fontSizeTextField,
          CalendarConstants.instance.arial,
        ),
        validator: (value) {
          if (value!.isEmpty || value.length < 4) {
            return CalendarConstants.instance.loginUyari;
          }
          return null;
        },
        onSaved: (value) {
          _userEmail = value!;
        },
      ),
    );
  }

  Padding kullaniciAdiTextField() {
    return Padding(
      padding: EdgeInsets.only(
        left: dynamicWidth(0.03),
        right: dynamicWidth(0.03),
        top: dynamicHeight(0.03),
        bottom: 0,
      ),
      child: TextFormField(
        key: ValueKey(CalendarConstants.instance.kullaniciAdiYz),
        obscureText: false,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: CalendarConstants.instance.kullaniciAdiYz,
          hintText: CalendarConstants.instance.kullaniciAdiYz,
        ),
        style: StyleTypes.instance.textStyle(
          CalendarConstants.instance.black,
          CalendarConstants.instance.fontSizeTextField,
          CalendarConstants.instance.arial,
        ),
        validator: (value) {
          if (value!.isEmpty || value.length < 4) {
            return CalendarConstants.instance.loginUyari;
          }
          return null;
        },
        onSaved: (value) {
          _userName = value!;
        },
      ),
    );
  }

  Padding sifreGirisTextField() {
    return Padding(
      padding: EdgeInsets.only(
        left: dynamicWidth(0.03),
        right: dynamicWidth(0.03),
        top: dynamicHeight(0.03),
        bottom: 0,
      ),
      child: TextFormField(
        key: ValueKey(CalendarConstants.instance.girisPasswordYz),
        obscureText: true,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: CalendarConstants.instance.girisPasswordYz,
          hintText: CalendarConstants.instance.girisPasswordYz,
        ),
        style: StyleTypes.instance.textStyle(
          CalendarConstants.instance.black,
          CalendarConstants.instance.fontSizeTextField,
          CalendarConstants.instance.arial,
        ),
        validator: (value) {
          if (value!.isEmpty || value.length < 4) {
            return CalendarConstants.instance.loginUyari;
          }
          return null;
        },
        onSaved: (value) {
          _userPassword = value!;
        },
      ),
    );
  }

  TextButton sifremiUnuttumButton() {
    return TextButton(
      child: Text(
        CalendarConstants.instance.girisSifreUnuttumYz,
        style: StyleTypes.instance.textStyle(themeData.primaryColor,
            dynamicHeight(0.019), CalendarConstants.instance.arial),
      ),
      onPressed: () {
        //TODO FORGOT PASSWORD SCREEN GOES HERE
      },
    );
  }

  TextButton registerButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          _isLogin = !_isLogin;
        });
      },
      child: Text(
        CalendarConstants.instance.loginKayitOlunYz,
        style: StyleTypes.instance.textStyle(
          CalendarConstants.instance.blueGrey,
          CalendarConstants.instance.fontSizeTextField,
          CalendarConstants.instance.arial,
        ),
      ),
    );
  }

  Container loginButton() {
    return Container(
      height: dynamicHeight(0.07),
      width: dynamicWidth(0.94),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        onPressed: _trySubmit,
        child: Text(
          _isLogin
              ? CalendarConstants.instance.girisButonYz
              : CalendarConstants.instance.loginKaydolYz,
          style: StyleTypes.instance.textStyle(CalendarConstants.instance.white,
              dynamicHeight(0.03), CalendarConstants.instance.arial),
        ),
      ),
    );
  }
}
