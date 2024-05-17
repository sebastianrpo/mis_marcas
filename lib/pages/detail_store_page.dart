import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailStorePage extends StatefulWidget {
  var store;

  DetailStorePage(this.store);

  @override
  State<DetailStorePage> createState() => _DetailStorePageState(store);
}

class _DetailStorePageState extends State<DetailStorePage> {
  var store;

  _DetailStorePageState(this.store);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(store['name']),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(store['latitude'], store['longitude']),
          initialZoom: 20,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.sebastianrpo.mis_marcas',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(store['latitude'], store['longitude']),
                width: 80,
                height: 80,
                child: FlutterLogo(),
              ),
            ],
          ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
