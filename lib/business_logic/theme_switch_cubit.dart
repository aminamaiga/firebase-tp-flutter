import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSwitchCubit extends Cubit<bool> {
  ThemeSwitchCubit(bool initialState) : super(initialState);

  themeChange(bool isDark) {
    emit(isDark);
  }
}
