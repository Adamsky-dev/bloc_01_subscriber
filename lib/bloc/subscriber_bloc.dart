import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_01_subscriber/bloc/subscriber_event.dart';
import 'package:bloc_01_subscriber/bloc/subscriber_state.dart';

class SubscriberBloc extends Bloc<SubscriberEvent, SubscriberState> {
  SubscriberBloc() : super(SubscriberState(15)) {
    on<Subscribe>((event, emit) {
      emit(SubscriberState(state.count + 1));
    });

    on<Unsubscribe>((event, emit) {
      emit(SubscriberState(state.count > 0 ? state.count - 1 : 0));
    });
  }
}
