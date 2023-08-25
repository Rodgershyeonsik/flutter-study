class TourImgModel {
  String galTitle,
      galWebImageUrl,
      galPhotographyLocation,
      galSearchKeyword;

  TourImgModel(
      {required this.galTitle,
        required this.galWebImageUrl,
        required this.galPhotographyLocation,
        required this.galSearchKeyword});

  factory TourImgModel.fromJson(Map<String, dynamic> json) {
    return TourImgModel(
      galTitle: json['galTitle'] as String,
      galWebImageUrl: json['galWebImageUrl'] as String,
      galPhotographyLocation: json['galPhotographyLocation'] as String,
      galSearchKeyword: json['galSearchKeyword'] as String,
    );
  }
}