import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_01_subscriber/cubit/subscriber_cubit.dart';

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
        create: (_) => SubscriberCubit(),
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
      body: BlocConsumer<SubscriberCubit, SubscriberState>(
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
                context.read<SubscriberCubit>().decrement();
              },
              tooltip: 'Unsubscribe',
              backgroundColor: Colors.redAccent,
              child: Icon(Icons.remove),
            ),
            SizedBox(width: 12),
            FloatingActionButton(
              heroTag: 'subscribe',
              onPressed: () {
                context.read<SubscriberCubit>().increment();
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
