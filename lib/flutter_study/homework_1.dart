import 'package:flutter/material.dart';
import 'package:flutter_app/model/tax_model.dart';
import 'package:flutter_app/src/app_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HomeWork_1",
      theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],

          // Define the default font family.
          fontFamily: 'Georgia',
          textTheme: TextTheme(
            title: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontStyle: FontStyle.italic),
            button: TextStyle(
                color: Color(0Xeeffffff),
                fontSize: 10.0,
                fontStyle: FontStyle.normal),
            subtitle: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontStyle: FontStyle.normal),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          )),
      home: MainWidget(),
    );
  }
}

class MainWidget extends StatefulWidget {
  @override
  State createState() => MainState();
}

class MainState extends State {
  final _datas = <TaxModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    expandedHeight: 200.0,
                    pinned: true,
                    floating: true,
                    flexibleSpace: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Image.network(
                                        "http://gilly.kr/resources/img_stars.jpg")
                                    .image,
                                fit: BoxFit.cover)),
                        child: Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "자진신고시 예상세",
                              style: Theme.of(context).textTheme.subtitle,
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Text("₩",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle),
                                    ),
                                    Text("50,839",
                                        style:
                                            Theme.of(context).textTheme.title)
                                  ],
                                )),
                            Text("자진신고시액 감면혜택 자세히 보기 >",
                                style: Theme.of(context).textTheme.button),
                          ],
                        ))))
              ];
            },
            body: Container(
                color: Color(0XFF424C81),
                child: Stack(children: <Widget>[
                  Container(
                      color: Color(0XFF424C81),
                      child: FutureBuilder(
                        future: _getData(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                                child: Center(
                              child: Text("Loading..."),
                            ));
                          } else {
                            return _buildListView(snapshot.data);
                          }
                        },
                      )),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                          padding: EdgeInsets.only(right: 20, bottom: 20),
                          child: FloatingActionButton(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.add,
                                color: Colors.blue,
                              ))))
                ]))));
  }

  Widget _buildListView(data) {
    _datas.add(TaxModel("설명1", "설명2", "설명3", 600));
    _datas.add(TaxModel("설명1", "설명2", "설명3", 600));
    _datas.add(TaxModel("설명1", "설명2", "설명3", 600));
    _datas.add(TaxModel("설명1", "설명2", "설명3", 600));
    _datas.add(TaxModel("설명1", "설명2", "설명3", 600));

    return ListView.builder(
        itemCount: data.length,
        padding: EdgeInsets.only(top: 10, bottom: 40),
        itemBuilder: (context, i) {
          if (i == 0) {
            return _buildItem(data[i], 0X6530364D);
          } else {
            return _buildItem(data[i], 0XFF5562C0);
          }
        });
  }

  Widget _buildItem(TaxModel data, int colorHex) {
    return Card(
        clipBehavior: Clip.antiAlias,
        color: Color(colorHex),
        child: ListTile(
          title: SizedBox(
              child: Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 0, right: 20),
                  child: Icon(
                    Icons.favorite,
                    size: 32,
                  )),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("기타항목: ${data.description1}"),
                          Text(data.description2),
                          Text(data.description3)
                        ],
                      ))),
            ],
          )),
          trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(data.tax.toString()),
              ]),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DetailPage(data)));
          },
        ));
  }

  Future<List<TaxModel>> _getData() async {
    var data = await http.get("http://gilly.kr/homework_1.json");
    var jsonData = json.decode(utf8.decode(data.bodyBytes));
    var appbarImgPath = jsonData["appbar_img_path"];
    var dataList = jsonData["datas"];

    List<TaxModel> taxList = [];

    for (var data in dataList) {
      taxList.add(TaxModel(data["desc1"], data["desc2"], data["desc3"],
          int.parse(data["task"])));
    }

    return taxList;
  }
}

class DetailPage extends StatelessWidget {
  final TaxModel data;

  DetailPage(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data.tax.toString())),
    );
  }
}

/*
FlexibleSpaceBar(
centerTitle: true,
title: Text("Collapsing Toolbar",
style: TextStyle(color: Colors.white, fontSize: 16.0)),
background: Image.network(
"https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
fit: BoxFit.cover))*/
