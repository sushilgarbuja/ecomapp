class SliderResponse {
  List<Sliders>? sliders;
  bool? error;
  String? message;

  SliderResponse({this.sliders, this.error, this.message});

  SliderResponse.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(Sliders.fromJson(v));
      });
    }
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sliders != null) {
      data['sliders'] = sliders!.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    data['message'] = message;
    return data;
  }
}

class Sliders {
  int? id;
  int? type;
  String? image;
  String? desc;
  int? relatedId;

  Sliders({this.id, this.type, this.image, this.desc, this.relatedId});

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    image = json['image'];
    desc = json['desc'];
    relatedId = json['related_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['image'] = image;
    data['desc'] = desc;
    data['related_id'] = relatedId;
    return data;
  }
}

class CategoryResponse {
  List<Categories>? categories;
  bool? error;
  String? message;

  CategoryResponse({this.categories, this.error, this.message});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    data['message'] = message;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? categoryImage;

  Categories({this.id, this.name, this.categoryImage});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category_image'] = categoryImage;
    return data;
  }
}

class LoginResponse {
  bool? error;
  String? name;
  String? email;
  String? apiKey;
  String? createdAt;
  String? message;
  bool? isStaff;

  LoginResponse(
      {this.error,
      this.name,
      this.email,
      this.apiKey,
      this.createdAt,
      this.message,
      this.isStaff});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    name = json['name'];
    email = json['email'];
    apiKey = json['apiKey'];
    createdAt = json['createdAt'];
    message = json['message'];
    isStaff = json['is_staff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['name'] = name;
    data['email'] = email;
    data['apiKey'] = apiKey;
    data['createdAt'] = createdAt;
    data['message'] = message;
    data['is_staff'] = isStaff;
    return data;
  }
}

class ProductListResponse {
  List<Products>? products;
  bool? error;
  String? message;

  ProductListResponse({this.products, this.error, this.message});

  ProductListResponse.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    data['message'] = message;
    return data;
  }
}

class Products {
  int? id;
  String? name;
  int? price;
  int? discountPrice;
  String? description;
  int? quantity;
  String? productionDate;
  String? expireDate;
  List<String>? images;
  List<int>? categories;

  Products(
      {this.id,
      this.name,
      this.price,
      this.discountPrice,
      this.description,
      this.quantity,
      this.productionDate,
      this.expireDate,
      this.images,
      this.categories});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discountPrice = json['discount_price'];
    description = json['description'];
    quantity = json['quantity'];
    productionDate = json['production_date'];
    expireDate = json['expire_date'];
    images = json['images'].cast<String>();
    categories = json['categories'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['discount_price'] = discountPrice;
    data['description'] = description;
    data['quantity'] = quantity;
    data['production_date'] = productionDate;
    data['expire_date'] = expireDate;
    data['images'] = images;
    data['categories'] = categories;
    return data;
  }
}
