import 'package:my_portfolio/features/projects/model/project.dart';

class AssetsData {
  static const String kemit1 = 'assets/images/kimit_eye_1.png';
  static const String kemit2 = 'assets/images/kimit_eye_2.png';
  static const String kemit3 = 'assets/images/kimit_eye_3.png';
  static const String kemit4 = 'assets/images/kimit_eye_4.png';
  static const String kemit5 = 'assets/images/kimit_eye_5.png';
  static const String kemit6 = 'assets/images/kimit_eye_6.png';
  static const String kemit7 = 'assets/images/kimit_eye_7.png';
  static const String kemit8 = 'assets/images/kimit_eye_8.png';
  static const String profilePic = 'assets/images/profile_pic.jpg';

  static const List<String> kemitEye = [
    kemit1,
    kemit2,
    kemit3,
    kemit4,
    kemit5,
    kemit6,
    kemit7,
    kemit8,
  ];

  static const List<String> chatEase = [
    // WhatsApp
    'https://play-lh.googleusercontent.com/ey21SzFwDygWgKaRggLUbdIyu2tglKBpFwGkLVHFmJOM8m01Oek3bi3fJ-7HVsC9XOU=w1200',
    // Telegram
    'https://play-lh.googleusercontent.com/wlwY1vowGxTrvQMRDHJD21iYBG7S_E09QbKPY-L6dqEc4UxCi0fDQiNuCBonFYED1yU=w1200',
  ];

  static const List<String> peerShare = [
    'https://play-lh.googleusercontent.com/Ot7mOG4glp9x3c2Xx1878hDhxAGlMaRT6uxy9sKndAuHF1mJlEPvWw0MngK1ZnC-XXhB=w1200',

    'https://play-lh.googleusercontent.com/zllQlRuZJb_6n9orDbtT7oCHd-KJzoYcJpAZR0DHrvdPxttjCD5FXeB2-GEMuwYxpA=w1200',
  ];

  static const List<String> notera = [
    // Google Keep
    'https://play-lh.googleusercontent.com/lye5SYEmCrwI4OTmN1jiMYpe0IjYY_gOOYpex_2_OIrnc0e5QBHQ__Ng1glIGdoSSSzV=w1200',
    'https://play-lh.googleusercontent.com/eL2sRR7oG4vbO-x10VkalDlKA4zCwv3cZi6XY6yi7cCmX2wwt10nrdKsEkpVvMIegr0=w1200',
  ];

  static const List<String> instaWeather = [
    // The Weather Channel
    'https://play-lh.googleusercontent.com/fakzycegZyr1Nd8mOqanaptVzfq3s2ohOfndQvyhqA9Xznw7GXU5kfOPDq9nuE1ocf0=w1200',
    'https://play-lh.googleusercontent.com/wXgkqx28j-Q-kr2cDnGbNAaju4uRe-sslXzPHVuc3_seNdXbEUKLH5r19RTc4lOg3fU=w1200',
  ];

  static const List<String> instaNews = [
    // Google News
    'https://play-lh.googleusercontent.com/w8zXKxd1eelrnMaaP-nIt_ANvlyYFNahafAW650WyJr0lV90ZAyl77lTxLL4n4bgqfcR=w1200',
    'https://play-lh.googleusercontent.com/dgRPfVjGsoYKPi4SkHnmTZq_kbISKniLdlgayJL_MgbmBGKUesGT93A9EhP-eFNH0A=w1200',
  ];

  static const List<String> shopEase = [
    // Amazon Shopping
    'https://play-lh.googleusercontent.com/Bt95BAHb_F8Wdn_Xt1z7sBjUXAD-UIYX_mqAhhRFIv5PobR3vpteXfzNC0ZYiVJPSgM=w1200',
    'https://play-lh.googleusercontent.com/q-3YfdVSQGgEJ9gj8KCnS17bu4fJmDZxkNzTeaR7bQg2p0lwHFSmBlYCUlW84g32A6w=w1200',
    'https://play-lh.googleusercontent.com/Uk1pdFdhTA8cw-4R-dLHwb5tnSUfUSMBu0ivlwxDNi1Tc5O7cRvAN8cAunQO-z0JAo4=w1200',
  ];

  static const List<String> todo = [
    // Todoist
    'https://play-lh.googleusercontent.com/c6EgFHn_tZjMLPFUYA7ugHYpHHeUA_Km0u8iIDPIapV9HvmtzSPki6CNPz9tqZJQwSg=w1200',
    'https://play-lh.googleusercontent.com/5GVvBM-QT83cTK7JXF_jthPrQkyKB6QkDppBJ2_uuT13KijJa11vkbfvbxL0tHtJ5A=w1200',
  ];

  static const List<Project> projects = [
    Project(
      title: 'Kemit Eye',
      description:
          'Location-based tourism app. AI-powered OCR to translate hieroglyphics, secure auth, Node.js backend, GetX + MVC.',
      tags: ['Flutter', 'GetX', 'AI-OCR', 'Maps', 'Node.js'],
      repoUrl: 'https://github.com/MahmoudASoliman/Kemit_Eye',
      demoUrl: 'https://example.com/kemit-eye',
      imageUrls: kemitEye,
    ),
    Project(
      title: 'ChatEase',
      description:
          'Real-time chat using Firebase Authentication and Firestore. Cubit state management, responsive UI.',
      tags: ['Flutter', 'Firebase', 'Cubit'],
      repoUrl: 'https://github.com/MahmoudASoliman/chat_ease',
      demoUrl: 'https://example.com/chatease',
      imageUrls: chatEase,
    ),
    Project(
      title: 'PeerShare (Client)',
      description:
          'Device-to-device file transfer via Bluetooth/Wi-Fi Direct. Clean UI, real-time progress.',
      tags: ['Flutter', 'Bluetooth', 'Wi-Fi Direct'],
      repoUrl: '',
      demoUrl: 'https://example.com/peershare',
      imageUrls: peerShare,
    ),
    Project(
      title: 'Notera',
      description:
          'Notes app with Hive local storage and Cubit. Add/edit/delete, smooth UX.',
      tags: ['Flutter', 'Hive', 'Cubit', 'SQLite'],
      repoUrl: 'https://github.com/MahmoudASoliman/notes_app',
      demoUrl: 'https://example.com/notera',
      imageUrls: notera,
    ),
    Project(
      title: 'InstaWeather',
      description:
          'Live weather via REST API + geolocation. Adaptive UI with Cubit.',
      tags: ['Flutter', 'REST', 'Location'],
      repoUrl: 'https://github.com/MahmoudASoliman/insta-Weather',
      demoUrl: 'https://example.com/instaweather',
      imageUrls: instaWeather,
    ),
    Project(
      title: 'InstaNews',
      description:
          'Latest articles from public API. Categorized  & responsive design.',
      tags: ['Flutter', 'REST', 'Responsive'],
      repoUrl: 'https://github.com/MahmoudASoliman/insta-News',
      demoUrl: 'https://example.com/instanews',
      imageUrls: instaNews,
    ),
    Project(
      title: 'ShopEase',
      description:
          'Shopping app with authentication, search, cart, wishlist. Firebase backend.',
      tags: ['Flutter', 'Firebase', 'Auth'],
      repoUrl: 'https://github.com/MahmoudASoliman/ShopApp',
      demoUrl: 'https://example.com/shopease',
      imageUrls: shopEase,
    ),
    Project(
      title: 'Todo',
      description:
          'Task manager using SQLite with Cubit. Add/edit/delete with clean UI.',
      tags: ['Flutter', 'SQLite', 'Cubit'],
      repoUrl: 'https://github.com/MahmoudASoliman/ToDo',
      demoUrl: 'https://example.com/todo',
      imageUrls: todo,
    ),
  ];
}
