import 'dart:math';

class LocationService {
  const LocationService({required this.positionProvider});

  final Future<({double latitude, double longitude})> Function()
      positionProvider;

  Future<bool> isWithinRange(
    double targetLatitude,
    double targetLongitude, {
    required double radiusInMeters,
  }) async {
    final position = await positionProvider();
    final distance = _distanceInMeters(
      position.latitude,
      position.longitude,
      targetLatitude,
      targetLongitude,
    );
    return distance <= radiusInMeters;
  }

  double _distanceInMeters(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) {
    const earthRadius = 6371000.0;
    final dLat = _toRadians(endLat - startLat);
    final dLon = _toRadians(endLng - startLng);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(startLat)) *
            cos(_toRadians(endLat)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _toRadians(double degrees) => degrees * pi / 180;
}
