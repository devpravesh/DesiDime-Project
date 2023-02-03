// To parse this JSON data, do
//
//     final popularModel = popularModelFromJson(jsonString);

import 'dart:convert';

PopularModel popularModelFromJson(String str) =>
    PopularModel.fromJson(json.decode(str));

String popularModelToJson(PopularModel data) => json.encode(data.toJson());

class PopularModel {
  PopularModel({
    this.seoSettings,
    this.deals,
    this.event,
  });

  SeoSettings? seoSettings;
  List<Deal>? deals;
  Event? event;

  factory PopularModel.fromJson(Map<String, dynamic> json) => PopularModel(
        seoSettings: json["seo_settings"] == null
            ? null
            : SeoSettings.fromJson(json["seo_settings"]),
        deals: json["deals"] == null
            ? []
            : List<Deal>.from(json["deals"]!.map((x) => Deal.fromJson(x))),
        event: json["event"] == null ? null : Event.fromJson(json["event"]),
      );

  Map<String, dynamic> toJson() => {
        "seo_settings": seoSettings?.toJson(),
        "deals": deals == null
            ? []
            : List<dynamic>.from(deals!.map((x) => x.toJson())),
        "event": event?.toJson(),
      };
}

class Deal {
  Deal({
    this.commentsCount,
    this.createdAt,
    this.createdAtInMillis,
    this.imageMedium,
    this.store,
  });

  int? commentsCount;
  DateTime? createdAt;
  int? createdAtInMillis;
  String? imageMedium;
  dynamic store;

  factory Deal.fromJson(Map<String, dynamic> json) => Deal(
        commentsCount: json["comments_count"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        createdAtInMillis: json["created_at_in_millis"],
        imageMedium: json["image_medium"],
        store: json["store"],
      );

  Map<String, dynamic> toJson() => {
        "comments_count": commentsCount,
        "created_at": createdAt?.toIso8601String(),
        "created_at_in_millis": createdAtInMillis,
        "image_medium": imageMedium,
        "store": store,
      };
}

class Event {
  Event({
    this.id,
    this.imageUrl,
    this.pageUrl,
  });

  int? id;
  String? imageUrl;
  String? pageUrl;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        imageUrl: json["image_url"],
        pageUrl: json["page_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "page_url": pageUrl,
      };
}

class SeoSettings {
  SeoSettings({
    this.seoTitle,
    this.seoDescription,
    this.webUrl,
  });

  String? seoTitle;
  String? seoDescription;
  String? webUrl;

  factory SeoSettings.fromJson(Map<String, dynamic> json) => SeoSettings(
        seoTitle: json["seo_title"],
        seoDescription: json["seo_description"],
        webUrl: json["web_url"],
      );

  Map<String, dynamic> toJson() => {
        "seo_title": seoTitle,
        "seo_description": seoDescription,
        "web_url": webUrl,
      };
}
