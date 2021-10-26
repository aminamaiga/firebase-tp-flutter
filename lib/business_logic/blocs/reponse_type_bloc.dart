import 'package:flutter_bloc/flutter_bloc.dart';

abstract class TypeEvent {}

class TrueEvent extends TypeEvent {}

class FalseEvent extends TypeEvent {}

class ResponseTypeBloc extends Bloc<TypeEvent, bool> {
  ResponseTypeBloc(bool initialState) : super(initialState) {
    on<TrueEvent>(_onTrue);
    on<FalseEvent>(_onFalse);
  }

  _onTrue(TrueEvent event, Emitter<bool> emit) {
    emit(true);
  }

  void _onFalse(FalseEvent event, Emitter<bool> emit) {
    emit(false);
  }
}
