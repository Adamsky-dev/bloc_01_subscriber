import 'package:bloc/bloc.dart';

part 'subscriber_state.dart';

class SubscriberCubit extends Cubit<SubscriberState> {
  SubscriberCubit() : super(SubscriberState(count: 15));

  void increment() => emit(SubscriberState(count: state.count + 1));
  void decrement() =>
      emit(SubscriberState(count: state.count > 0 ? state.count - 1 : 0));
}
