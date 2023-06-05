import 'package:flutter/material.dart';

import 'ui_bloc.dart';

class UIBlocProvider extends InheritedWidget {
  final UIBloc bloc;

  UIBlocProvider({Key? key, required Widget child})
      : bloc = uiBloc,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(oldWidget) => true;

  static UIBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UIBlocProvider>()!.bloc;
  }
}
