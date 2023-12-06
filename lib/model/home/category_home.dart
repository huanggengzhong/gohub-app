class ApiResponse {
  int? code;
  List<CategoryModel>? data;
  Pager? pager;

  ApiResponse({this.code, this.data, this.pager});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = List<CategoryModel>.from(
        json['data'].map((categoryJson) => CategoryModel.fromJson(categoryJson)),
      );
    }
    pager = Pager.fromJson(json['pager']);
  }
}

class CategoryModel {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;

  CategoryModel({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Pager {
  int? currentPage;
  int? perPage;
  int? totalPage;
  int? totalCount;
  String? nextPageURL;
  String? prevPageURL;

  Pager({
    this.currentPage,
    this.perPage,
    this.totalPage,
    this.totalCount,
    this.nextPageURL,
    this.prevPageURL,
  });

  Pager.fromJson(Map<String, dynamic> json) {
    currentPage = json['CurrentPage'];
    perPage = json['PerPage'];
    totalPage = json['TotalPage'];
    totalCount = json['TotalCount'];
    nextPageURL = json['NextPageURL'];
    prevPageURL = json['PrevPageURL'];
  }
}