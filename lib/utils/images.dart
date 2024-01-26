import 'package:flutter_dotenv/flutter_dotenv.dart';

class Images {
  static const String appLogo = 'assets/images/app_logo.png';

  static final String _getSmallImage = dotenv.env['GET_IMAGE_SMALL'] ?? '';
  static final String _getMediumImage = dotenv.env['GET_IMAGE_MEDIUM'] ?? '';
  static final String _getLargeImage = dotenv.env['GET_IMAGE_LARGE'] ?? '';

  static final Images instanceImages = Images();

  String getImageSize(String imageId, String size) {
    String imageUrl;
    switch (size) {
      case 'small':
        imageUrl = _getSmallImage;
        break;
      case 'medium':
        imageUrl = _getMediumImage;
        break;
      case 'large':
        imageUrl = _getLargeImage;
        break;
      default:
        throw Exception('Invalid size statement');
    }

    return imageUrl + imageId;
  }
}
