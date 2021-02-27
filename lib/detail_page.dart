import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resep/static_data.dart';

class DetailPage extends StatelessWidget {
  Map<String, dynamic> resep;
  @override
  Widget build(BuildContext context) {
    resep = Get.arguments;
    return Scaffold(
        backgroundColor: Colors.white, body: DetailView(resep: resep));
  }
}

class DetailView extends StatelessWidget {
  final Map<String, dynamic> resep;

  const DetailView({Key key, this.resep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        expandedHeight: 250.0,
        floating: true,
        pinned: true,
        snap: true,
        elevation: 5,
        flexibleSpace: FlexibleSpaceBar(
          title: Text("${resep['resep_nama']}"),
          centerTitle: true,
          background: GestureDetector(
            onTap: () {
              // Get.toNamed("/list_image_view",
              //     arguments: barang.barang_foto);
            },
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: Get.width,
                  height: Get.height,
                  imageUrl:
                      "${StaticData.baseUrl}/uploads/${resep['resep_img']}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
                Parent(
                    child: Container(),
                    style: ParentStyle()
                      ..background.color(Colors.black.withOpacity(0.2))
                      ..width(Get.width)
                      ..height(Get.height))
              ],
            ),
          ),
        ),
      ),
      SliverList(
          delegate: SliverChildListDelegate.fixed(<Widget>[
        ListTile(
          title: Text("Nama"),
          subtitle: Text("${resep['resep_nama']}"),
          tileColor: Colors.white,
        ),
        ListTile(
          title: Text("Bahan"),
          subtitle: Text("${resep['resep_bahan']}"),
          tileColor: Colors.white,
        ),
        ListTile(
          title: Text("Cara"),
          subtitle: Text("${resep['resep_cara']}"),
          tileColor: Colors.white,
        ),
      ])),
    ]);
  }
}
