import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

final mock = [
  {
    "id": "b1998979-d91e-4b38-9585-03592bebe492",
    "brand": "tellus",
    "type": "Ruta",
    "color": "Yellow",
    "status": "Disponible",
    "long": 118.578967,
    "lat": 24.865287
  },
  {
    "id": "1fef3efe-aa79-4b2e-9d53-c33a14ab999f",
    "brand": "rutrum",
    "type": "Ruta",
    "color": "Orange",
    "status": "No Disponible",
    "long": 117.309946,
    "lat": 24.363492
  },
  {
    "id": "0cc5935d-0ce6-40e3-a334-7389e19c2a8a",
    "brand": "in",
    "type": "Cross",
    "color": "Indigo",
    "status": "Disponible",
    "long": 73.328393,
    "lat": 54.982808
  },
  {
    "id": "4298ee99-960c-4598-be54-38d43052b7f2",
    "brand": "mi",
    "type": "Ruta",
    "color": "Yellow",
    "status": "No Disponible",
    "long": 105.1726816,
    "lat": 20.8381545
  },
  {
    "id": "db1cead8-505e-49bf-9a02-fc44559abefa",
    "brand": "proin",
    "type": "Mountain",
    "color": "Pink",
    "status": "No Disponible",
    "long": 25.8107681,
    "lat": -24.5551012
  },
  {
    "id": "5e31acea-2b78-4657-a318-42a56f0dfb23",
    "brand": "diam",
    "type": "Ruta",
    "color": "Indigo",
    "status": "No Disponible",
    "long": 20.8378422,
    "lat": 49.9579835
  },
  {
    "id": "59ba8b35-f9b5-4ce9-9fac-140bd616fd51",
    "brand": "elementum",
    "type": "Cross",
    "color": "Green",
    "status": "No Disponible",
    "long": 49.7653156,
    "lat": 40.4095521
  },
  {
    "id": "076a1860-b941-4419-94b6-4cbe310317be",
    "brand": "pharetra",
    "type": "Cross",
    "color": "Mauv",
    "status": "No Disponible",
    "long": 14.7714251,
    "lat": 53.9672519
  },
  {
    "id": "a81c8d76-3239-49f7-8513-d6578e41c816",
    "brand": "primis",
    "type": "Mountain",
    "color": "Violet",
    "status": "Disponible",
    "long": 112.339509,
    "lat": 27.983279
  },
  {
    "id": "a67dd911-efc3-4148-bfd9-2e7ee27c7326",
    "brand": "maecenas",
    "type": "Cross",
    "color": "Fuscia",
    "status": "Disponible",
    "long": 124.1253751,
    "lat": -8.4422524
  }
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late MapLatLng _markerPosition;
  late MapZoomPanBehavior _mapZoomPanBehavior;
  late MapTileLayerController _controller;

  @override
  void initState() {
    _controller = MapTileLayerController();
    _mapZoomPanBehavior = MapZoomPanBehavior(zoomLevel: 4);
    super.initState();
  }

  void updateMarkerChange(Offset position) {
    _markerPosition = _controller.pixelToLatLng(position);
    if (_controller.markersCount > 0) {
      _controller.clearMarkers();
    }
    _controller.insertMarker(0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        updateMarkerChange(details.localPosition);
      },
      child: SfMaps(
        layers: [
          MapTileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            zoomPanBehavior: _mapZoomPanBehavior,
            initialFocalLatLng: MapLatLng(28.0, 77.0),
            controller: _controller,
            markerBuilder: (BuildContext context, int index) {
              return MapMarker(
                latitude: _markerPosition.latitude,
                longitude: _markerPosition.longitude,
                child: Icon(Icons.location_on, color: Colors.red),
              );
            },
          )
        ],
      ),
    );
  }
}
