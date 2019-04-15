import 'dart:convert';

ApplicationIdentity clientFromJson(String str) {
    final jsonData = json.decode(str);
    return ApplicationIdentity.fromJson(jsonData);
}

String clientToJson(ApplicationIdentity data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class ApplicationIdentity {
    int id;
    String nickname;
    String accUsername;
    String accDisplayImage;
    String password;

    ApplicationIdentity({
        this.id,
        this.nickname,
        this.accUsername,
        this.accDisplayImage,
        this.password,
    });

    factory ApplicationIdentity.fromJson(Map<String, dynamic> json) => new ApplicationIdentity(
        id: json["id"],
        nickname: json["nickname"],
        accUsername: json["accUsername"],
        accDisplayImage: json["accDisplayImage"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nickname": nickname,
        "accUsername": accUsername,
        "accDisplayImage": accDisplayImage,
        "password": password,
    };
}