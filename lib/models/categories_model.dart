// class CategoriesModel
// {
//   CategoriesModel({
//     bool? status,
//     Data? data,
//   }) {
//     _status = status;
//     _data = data;
//   }
//
//   CategoriesModel.fromJson(dynamic json) {
//     _status = json['status'];
//     _data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//   bool? _status;
//   Data? _data;
//   CategoriesModel copyWith({
//     bool? status,
//     Data? data,
//   }) =>
//       CategoriesModel(
//         status: status ?? _status,
//         data: data ?? _data,
//       );
//   bool? get status => _status;
//   Data? get data => _data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = _status;
//     if (_data != null) {
//       map['data'] = _data?.toJson();
//     }
//     return map;
//   }
// }
//
// class Data {
//   Data({
//     num? id,
//     String? name,
//     String? image,
//   }) {
//     _id = id;
//     _name = name;
//     _image = image;
//   }
//
//   Data.fromJson(dynamic json) {
//     _id = json['id'];
//     _name = json['name'];
//     _image = json['image'];
//   }
//   num? _id;
//   String? _name;
//   String? _image;
//   Data copyWith({
//     num? id,
//     String? name,
//     String? image,
//   }) =>
//       Data(
//         id: id ?? _id,
//         name: name ?? _name,
//         image: image ?? _image,
//       );
//   num? get id => _id;
//   String? get name => _name;
//   String? get image => _image;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['name'] = _name;
//     map['image'] = _image;
//     return map;
//   }
// }

class CategoriesModel {
  bool? status;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<DataModel> data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
