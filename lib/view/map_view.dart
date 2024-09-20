import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});


  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  LocationData? _currentPosition;
  late GoogleMapController _mapController;
  Location location = Location();
  List<LatLng> _routeCoordinates = []; // 이동 경로를 저장하는 리스트
  Set<Polyline> _polylines = {}; // Polyline을 저장할 Set
  bool _tracking = false; // 경로 추적 여부 제어

  void getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // 위치 서비스 활성화 확인
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // 위치 권한 확인
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // 현재 위치 가져오기
    _currentPosition = await location.getLocation();
    if (_currentPosition != null) {
      _mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!),
        ),
      );
      _routeCoordinates.add(LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!)); // 경로 시작점 추가
    }
  }

  void startTracking() {
    setState(() {
      _tracking = true; // 경로 추적 활성화
    });

    // 위치 변화 감지하여 계속해서 경로 업데이트
    location.onLocationChanged.listen((LocationData newLocation) {
      if (_tracking) {
        setState(() {
          _currentPosition = newLocation;
          _routeCoordinates.add(LatLng(newLocation.latitude!, newLocation.longitude!)); // 이동 경로 저장
          _polylines.add(Polyline(
            polylineId: PolylineId('route'),
            visible: true,
            points: _routeCoordinates,
            color: Colors.blue,
            width: 5,
          )); // Polyline 업데이트
        });

        // 위치가 변경될 때마다 지도의 카메라를 이동
        _mapController.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(newLocation.latitude!, newLocation.longitude!),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("googleMapAPI"),
      ),
      body: Center(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(_currentPosition?.latitude ?? 35.77483, _currentPosition?.longitude ?? 128.51942),
            zoom: 18,
          ),
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
          myLocationEnabled: true, // 내 위치 버튼 활성화
          myLocationButtonEnabled: true, // 내 위치 버튼 표시
          polylines: _polylines, // 지도에 Polyline 표시
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: startTracking, // 버튼을 누르면 경로 추적 시작
        child: const Icon(Icons.play_arrow),
        tooltip: 'Start Tracking',
      ),
    );
  }
}