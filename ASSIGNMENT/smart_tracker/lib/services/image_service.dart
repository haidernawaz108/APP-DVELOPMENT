import 'package:image_picker/image_picker.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();
  Future<String?> pickFromCamera() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
      );

      if (file != null) {
        return file.path; 
      } else {
        return null; 
      }
    } catch (e) {
      return null; 
    }
  }
}
