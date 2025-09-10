import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/subscriber_bloc.dart';
import 'bloc/subscriber_event.dart';
import 'bloc/subscriber_state.dart';

void main() {
  runApp(SubscriberApp());
}

class SubscriberApp extends StatelessWidget {
  const SubscriberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YouTube Subscriber Counter',
      theme: ThemeData(primarySwatch: Colors.red),
      home: BlocProvider(
        create: (_) => SubscriberBloc(),
        child: SubscriberPage(),
      ),
    );
  }
}

class SubscriberPage extends StatelessWidget {
  const SubscriberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Subscriber Counter'),
        centerTitle: true,
      ),
      body: BlocConsumer<SubscriberBloc, SubscriberState>(
        listener: (context, state) {
          if (state.count == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('No more subscribers left!'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
          }
          /* else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Subscribers: ${state.count}'),
                duration: Duration(milliseconds: 800),
              ),
            );
          }
          */
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.subscriptions, size: 100, color: Colors.red),
                SizedBox(height: 20),
                Text(
                  '${state.count} Subscribers',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'unsubscribe',
              onPressed: () {
                context.read<SubscriberBloc>().add(Unsubscribe());
              },
              tooltip: 'Unsubscribe',
              backgroundColor: Colors.redAccent,
              child: Icon(Icons.remove),
            ),
            SizedBox(width: 12),
            FloatingActionButton(
              heroTag: 'subscribe',
              onPressed: () {
                context.read<SubscriberBloc>().add(Subscribe());
              },
              tooltip: 'Subscribe',
              backgroundColor: Colors.green,
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
