import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';



import '../providers/emp_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final provider = Provider.of<EmpProvider>(context, listen: false);
    provider.getDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('Employee');
    final provider = Provider.of<EmpProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('employee'),
        centerTitle: true,
      ),
      body: provider.isLoading
          ? getLoadingUI()
          : provider.error.isNotEmpty
              ? getErrorUI(provider.error)
              : getBodyUI(),
    );
  }

  Widget getLoadingUI() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SpinKitFadingCircle(
            color: Colors.blue,
            size: 80,
          ),
          Text(
            'Loading...',
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget getErrorUI(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 22),
      ),
    );
  }

  Widget getBodyUI() {
    final provider = Provider.of<EmpProvider>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              provider.search(value);
            },
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: Consumer(
            builder: (context, EmpProvider empProvider, child) =>
                ListView.builder(
              itemCount: empProvider.serachedemps.data.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(
                      empProvider.serachedemps.data[index].profile_image),
                  backgroundColor: Colors.white,
                ),
                title: Text(empProvider.serachedemps.data[index].name),
                subtitle:Text(empProvider.serachedemps.data[index].email), 
              ),
            ),
          ),
        ),
      ],
    );
  }
}
