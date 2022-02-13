const MAPBOX_API_KEY =
    'pk.eyJ1IjoiYmFvdHJ1bmczNzJrIiwiYSI6ImNremxkcG1tMzU1NHAydm5mdTV6N3ljODEifQ.cXXSbJJ-3Qi8MuyQA1vBWQ';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/$longitude,$latitude,14.25,0,60/300x300?access_token=$MAPBOX_API_KEY';
  }
}
