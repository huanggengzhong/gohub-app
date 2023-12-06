class CategoryModel {
  int? code;
  List<Data>? data;
  Pager? pager;
  String? message;

  CategoryModel({this.code, this.data, this.pager,this.message});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pager = json['pager'] != null ? new Pager.fromJson(json['pager']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pager != null) {
      data['pager'] = this.pager!.toJson();
    }
    if (this.message != null) {
      data['message'] = this.message;
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.name, this.description, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Pager {
  int? currentPage;
  int? perPage;
  int? totalPage;
  int? totalCount;
  String? nextPageURL;
  String? prevPageURL;

  Pager(
      {this.currentPage,
        this.perPage,
        this.totalPage,
        this.totalCount,
        this.nextPageURL,
        this.prevPageURL});

  Pager.fromJson(Map<String, dynamic> json) {
    currentPage = json['CurrentPage'];
    perPage = json['PerPage'];
    totalPage = json['TotalPage'];
    totalCount = json['TotalCount'];
    nextPageURL = json['NextPageURL'];
    prevPageURL = json['PrevPageURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CurrentPage'] = this.currentPage;
    data['PerPage'] = this.perPage;
    data['TotalPage'] = this.totalPage;
    data['TotalCount'] = this.totalCount;
    data['NextPageURL'] = this.nextPageURL;
    data['PrevPageURL'] = this.prevPageURL;
    return data;
  }
}
