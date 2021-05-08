import 'dart:async';

enum CounterEvent { Increment, Decrement }

class CounterBloc {
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get statesink => _stateStreamController.sink;
  Stream<int> get statestrem => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterEvent>();
  StreamSink<CounterEvent> get eventsink => _eventStreamController.sink;
  Stream<CounterEvent> get eventstream => _eventStreamController.stream;

  int counter = 0;

  CounterBloc() {
    eventstream.listen((CounterEvent event) {
      if (event == CounterEvent.Increment) {
        counter++;
        statesink.add(counter);
      } else if (event == CounterEvent.Decrement) {
        counter--;
        statesink.add(counter);
      }
    });
  }
  void dispose() {
    _eventStreamController.close();
    _stateStreamController.close();
  }
}
