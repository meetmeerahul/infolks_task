class UserDetails {
  int? id;
  String? ifId;
  String? name;
  String? email;
  String? department;
  String? userType;
  void emailVerifiedAt;
  String? plainPassword;
  void createdAt;
  String? updatedAt;

  UserDetails(
      {this.id,
      this.ifId,
      this.name,
      this.email,
      this.department,
      this.userType,
      this.emailVerifiedAt,
      this.plainPassword,
      this.createdAt,
      this.updatedAt});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ifId = json['if_id'];
    name = json['name'];
    email = json['email'];
    department = json['department'];
    userType = json['user_type'];
    // emailVerifiedAt = json['email_verified_at'];
    plainPassword = json['plain_password'];
    // createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  static List<UserDetails> getUserDetails(List<dynamic> userSnapshot) {
    return userSnapshot.map((json) => UserDetails.fromJson(json)).toList();
  }
}
