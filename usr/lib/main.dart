import 'package:flutter/material.dart';

// A simple model for satellite data
class Satellite {
  final String name;
  final String id;
  final String details;

  Satellite({required this.name, required this.id, required this.details});
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Satellite Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const SatelliteTrackerHome(),
    );
  }
}

class SatelliteTrackerHome extends StatefulWidget {
  const SatelliteTrackerHome({super.key});

  @override
  State<SatelliteTrackerHome> createState() => _SatelliteTrackerHomeState();
}

class _SatelliteTrackerHomeState extends State<SatelliteTrackerHome> {
  // Dummy data for satellites. In a real app, this would come from an API.
  final List<Satellite> _allSatellites = [
    Satellite(name: 'Starlink-1007', id: '2020-001A', details: 'A communication satellite from SpaceX.'),
    Satellite(name: 'Hubble Space Telescope', id: '1990-037B', details: 'An astronomical observatory in low Earth orbit.'),
    Satellite(name: 'International Space Station (ISS)', id: '1998-067A', details: 'A modular space station in low Earth orbit.'),
    Satellite(name: 'GPS BIIR-7 (SVN 45)', id: '2001-033A', details: 'A navigation satellite for the Global Positioning System.'),
    Satellite(name: 'NOAA 19', id: '2009-005A', details: 'A weather satellite operated by NOAA.'),
    Satellite(name: 'GOES 16', id: '2016-069A', details: 'A geostationary environmental satellite.'),
    Satellite(name: 'Terra', id: '1999-068A', details: 'A multi-national NASA scientific research satellite.'),
    Satellite(name: 'Aqua', id: '2002-022A', details: 'A NASA satellite studying the Earth\'s water cycle.'),
  ];

  List<Satellite> _filteredSatellites = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredSatellites = _allSatellites;
    _searchController.addListener(_filterSatellites);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterSatellites() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSatellites = _allSatellites.where((satellite) {
        return satellite.name.toLowerCase().contains(query) ||
               satellite.id.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Satellite Tracker'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a satellite by name or ID...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSatellites.length,
              itemBuilder: (context, index) {
                final satellite = _filteredSatellites[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: ListTile(
                    leading: const Icon(Icons.satellite_alt),
                    title: Text(satellite.name),
                    subtitle: Text('ID: ${satellite.id}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SatelliteDetailPage(satellite: satellite),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SatelliteDetailPage extends StatelessWidget {
  final Satellite satellite;

  const SatelliteDetailPage({super.key, required this.satellite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(satellite.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Satellite Name:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              satellite.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Satellite ID:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              satellite.id,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Details:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              satellite.details,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // In a real app, this would show the satellite on a sky map.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Showing satellite on sky map... (Not implemented)')),
                  );
                },
                child: const Text('View on Sky Map'),
              ),
            ),
             const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
