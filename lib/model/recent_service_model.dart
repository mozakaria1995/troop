// To parse this JSON data, do
//
//     final RecentServiceModel = RecentServiceModelFromJson(jsonString);

import 'dart:convert';

RecentServiceModel RecentServiceModelFromJson(String str) =>
    RecentServiceModel.fromJson(json.decode(str));

String RecentServiceModelToJson(RecentServiceModel data) =>
    json.encode(data.toJson());

class RecentServiceModel {
  RecentServiceModel({
    required this.latestServices,
    required this.serviceImage,
    required this.reviewerImage,
  });

  List<LatestService> latestServices;
  List<Image> serviceImage;
  List<Image> reviewerImage;

  factory RecentServiceModel.fromJson(Map<String, dynamic> json) =>
      RecentServiceModel(
        latestServices: List<LatestService>.from(
            json["latest_services"].map((x) => LatestService.fromJson(x))),
        serviceImage: List<Image>.from(
            json["service_image"].map((x) => Image.fromJson(x))),
        reviewerImage: List<Image>.from(
            json["reviewer_image"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "latest_services":
            List<dynamic>.from(latestServices.map((x) => x.toJson())),
        "service_image":
            List<dynamic>.from(serviceImage.map((x) => x.toJson())),
        "reviewer_image":
            List<dynamic>.from(reviewerImage.map((x) => x.toJson())),
      };
}

class LatestService {
  LatestService({
    this.id,
    this.title,
    this.image,
    this.price,
    this.sellerId,
    required this.reviewsForMobile,
    required this.sellerForMobile,
  });

  int? id;
  String? title;
  String? image;
  int? price;
  int? sellerId;
  List<ReviewsForMobile> reviewsForMobile;
  SellerForMobile sellerForMobile;

  factory LatestService.fromJson(Map<String, dynamic> json) => LatestService(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        price: json["price"],
        sellerId: json["seller_id"],
        reviewsForMobile: List<ReviewsForMobile>.from(json["reviews_for_mobile"]
            .map((x) => ReviewsForMobile.fromJson(x))),
        sellerForMobile: SellerForMobile.fromJson(json["seller_for_mobile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "price": price,
        "seller_id": sellerId,
        "reviews_for_mobile":
            List<dynamic>.from(reviewsForMobile.map((x) => x.toJson())),
        "seller_for_mobile": sellerForMobile.toJson(),
      };
}

class ReviewsForMobile {
  ReviewsForMobile({
    this.id,
    this.serviceId,
    this.rating,
    this.message,
    this.buyerId,
    required this.buyerForMobile,
  });

  int? id;
  int? serviceId;
  int? rating;
  String? message;
  int? buyerId;
  BuyerForMobile buyerForMobile;

  factory ReviewsForMobile.fromJson(Map<String, dynamic> json) =>
      ReviewsForMobile(
        id: json["id"],
        serviceId: json["service_id"],
        rating: json["rating"],
        message: json["message"],
        buyerId: json["buyer_id"],
        buyerForMobile: BuyerForMobile.fromJson(json["buyer_for_mobile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_id": serviceId,
        "rating": rating,
        "message": message,
        "buyer_id": buyerId,
        "buyer_for_mobile": buyerForMobile.toJson(),
      };
}

class BuyerForMobile {
  BuyerForMobile({
    this.id,
    this.image,
  });

  int? id;
  String? image;

  factory BuyerForMobile.fromJson(Map<String, dynamic> json) => BuyerForMobile(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}

class SellerForMobile {
  SellerForMobile({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory SellerForMobile.fromJson(Map<String, dynamic> json) =>
      SellerForMobile(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Image {
  Image({
    this.imageId,
    this.path,
    this.imgUrl,
    this.imgAlt,
  });

  int? imageId;
  String? path;
  String? imgUrl;
  dynamic imgAlt;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        imageId: json["image_id"],
        path: json["path"],
        imgUrl: json["img_url"],
        imgAlt: json["img_alt"],
      );

  Map<String, dynamic> toJson() => {
        "image_id": imageId,
        "path": path,
        "img_url": imgUrl,
        "img_alt": imgAlt,
      };
}
