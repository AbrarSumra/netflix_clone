class Show {
  final int id;
  final String name;
  final String? url;
  final String type;
  final String language;
  final List<String> genres;
  final String status;
  final int? runtime;
  final int? averageRuntime;
  final String premiered;
  final String? ended;
  final String? officialSite;
  final Schedule? schedule;
  final Rating? rating;
  final int weight;
  final Network? network;
  final Externals? externals;
  final ImageModel? image;
  final String summary;
  final DateTime updated;
  final Links? links;

  Show({
    required this.id,
    required this.name,
    this.url,
    required this.type,
    required this.language,
    required this.genres,
    required this.status,
    this.runtime,
    this.averageRuntime,
    required this.premiered,
    this.ended,
    this.officialSite,
    this.schedule,
    this.rating,
    required this.weight,
    this.network,
    this.externals,
    this.image,
    required this.summary,
    required this.updated,
    this.links,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    var show = json['show'];
    if (show == null) {
      return Show(
        id: 0,
        name: "Unknown",
        type: "Unknown",
        language: "Unknown",
        genres: [],
        status: "Unknown",
        premiered: "Unknown",
        summary: "No summary available",
        updated: DateTime.now(),
        weight: 0,
      );
    }

    return Show(
      id: show['id'] ?? 0, // Default to 0 if id is null
      name: show['name'] ?? "Unknown", // Default to "Unknown" if name is null
      url: show['url'] ?? "", // Default to empty string if url is null
      type: show['type'] ?? "Unknown", // Default to "Unknown" if type is null
      language: show['language'] ??
          "Unknown", // Default to "Unknown" if language is null
      genres: show['genres'] != null
          ? List<String>.from(show['genres'])
          : [], // Default to an empty list if genres is null
      status:
          show['status'] ?? "Unknown", // Default to "Unknown" if status is null
      runtime: show['runtime'], // Nullable, no default value
      averageRuntime: show['averageRuntime'], // Nullable, no default value
      premiered: show['premiered'] ??
          "Unknown", // Default to "Unknown" if premiered is null
      ended: show['ended'], // Nullable, no default value
      officialSite: show['officialSite'], // Nullable, no default value
      schedule: show['schedule'] != null
          ? Schedule.fromJson(show['schedule'])
          : null, // Handle nullable
      rating: show['rating'] != null
          ? Rating.fromJson(show['rating'])
          : null, // Handle nullable
      weight: show['weight'] ?? 0, // Default to 0 if weight is null
      network: show['network'] != null
          ? Network.fromJson(show['network'])
          : null, // Handle nullable
      externals: show['externals'] != null
          ? Externals.fromJson(show['externals'])
          : null, // Handle nullable
      image: show['image'] != null
          ? ImageModel.fromJson(show['image'])
          : null, // Handle nullable
      summary: show['summary'] ??
          "No summary available", // Default to a message if summary is null
      updated: DateTime.fromMillisecondsSinceEpoch(show['updated'] * 1000),
      links: show['_links'] != null
          ? Links.fromJson(show['_links'])
          : null, // Handle nullable
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'type': type,
      'language': language,
      'genres': genres,
      'status': status,
      'runtime': runtime,
      'averageRuntime': averageRuntime,
      'premiered': premiered,
      'ended': ended,
      'officialSite': officialSite,
      'schedule': schedule?.toJson(),
      'rating': rating?.toJson(),
      'weight': weight,
      'network': network?.toJson(),
      'externals': externals?.toJson(),
      'image': image?.toJson(),
      'summary': summary,
      'updated': updated.millisecondsSinceEpoch ~/ 1000,
      '_links': links?.toJson(),
    };
  }
}

class Schedule {
  final String time;
  final List<String> days;

  Schedule({
    required this.time,
    required this.days,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      time: json['time'],
      days: List<String>.from(json['days']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'days': days,
    };
  }
}

class Rating {
  final double average;

  Rating({
    required this.average,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      average: json['average']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'average': average,
    };
  }
}

class Network {
  final int id;
  final String name;
  final Country country;
  final String? officialSite;

  Network({
    required this.id,
    required this.name,
    required this.country,
    this.officialSite,
  });

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      id: json['id'],
      name: json['name'],
      country: Country.fromJson(json['country']),
      officialSite: json['officialSite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country.toJson(),
      'officialSite': officialSite,
    };
  }
}

class Country {
  final String name;
  final String code;
  final String timezone;

  Country({
    required this.name,
    required this.code,
    required this.timezone,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      code: json['code'],
      timezone: json['timezone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'timezone': timezone,
    };
  }
}

class Externals {
  final String? imdb;

  Externals({this.imdb});

  factory Externals.fromJson(Map<String, dynamic> json) {
    return Externals(
      imdb: json['imdb'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imdb': imdb,
    };
  }
}

class ImageModel {
  final String medium;
  final String original;

  ImageModel({
    required this.medium,
    required this.original,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      medium: json['medium'],
      original: json['original'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medium': medium,
      'original': original,
    };
  }
}

class Links {
  final Link self;
  final Link? previousepisode;

  Links({
    required this.self,
    this.previousepisode,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: Link.fromJson(json['self']),
      previousepisode: json['previousepisode'] != null
          ? Link.fromJson(json['previousepisode'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'self': self.toJson(),
      'previousepisode': previousepisode?.toJson(),
    };
  }
}

class Link {
  final String href;

  Link({required this.href});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      href: json['href'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'href': href,
    };
  }
}
