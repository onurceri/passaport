class DisplayImage {
  String getDisplayImageOfAccount(String userName, String nickName) {
    String imagePath = "assets/images/noimage-logo.jpg";
    userName = userName.toLowerCase();
    nickName = nickName.toLowerCase();

    if (userName.contains("gmail") ||
        userName.contains("google") ||
        nickName.contains("gmail") ||
        nickName.contains("google")) {
      imagePath = "assets/images/gmail-logo.jpg";
    } else if (userName.contains("microsoft") ||
        nickName.contains("microsoft")) {
      imagePath = "assets/images/microsoft-logo.jpg";
    } else if (userName.contains("outlook") || nickName.contains("outlook")) {
      imagePath = "assets/images/outlook-logo.jpg";
    } else if (userName.contains("steam") || nickName.contains("steam")) {
      imagePath = "assets/images/steam-logo.jpg";
    }else if (userName.contains("facebook") || nickName.contains("facebook")) {
      imagePath = "assets/images/facebook-logo.jpg";
    }else if (userName.contains("snapchat") || nickName.contains("snapchat")) {
      imagePath = "assets/images/snapchat-logo.png";
    }else if (userName.contains("instagram") || nickName.contains("instagram")) {
      imagePath = "assets/images/instagram-logo.png";
    }else if (userName.contains("twitter") || nickName.contains("twitter")) {
      imagePath = "assets/images/twitter-logo.png";
    }

    return imagePath;
  }
}
