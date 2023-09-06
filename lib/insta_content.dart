import 'package:flutter/cupertino.dart';
import 'package:flutter_insta/flutter_insta.dart';

class InstaContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InstaContentState();
}

class _InstaContentState extends State<InstaContent> {
  List<String>? instaUrls;

  @override
  void initState() {
    getInstaPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var nonNullInstaUrls = instaUrls ?? List.empty();

    return GridView.count(
      crossAxisCount: 3,
      children: [
        for (var post in nonNullInstaUrls)
          Image.network(
            post,
            height: 30,
            width: 30,
          )
      ],
    );
  }

  void getInstaPosts() async {
    FlutterInsta flutterInsta = FlutterInsta();
    await flutterInsta.getProfileData("spiderwaterband");
    setState(() {
      instaUrls = flutterInsta.feedImagesUrl;
    });
  }
}
