import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GameImage extends StatelessWidget {
  final String imageUrl;
  const GameImage(this.imageUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      // placeholder: (context, url) => const CircularProgressIndicator(),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Padding(padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0), child: CircularProgressIndicator(value: downloadProgress.progress)),
      errorWidget: (context, url, error) => Text("Error"),
    );
  }
}
