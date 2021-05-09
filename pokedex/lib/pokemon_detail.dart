import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pokedex/model/pokedex.dart';
import 'package:palette_generator/palette_generator.dart';

class PokemonDetail extends StatefulWidget {
  Pokemon pokemon;
  PokemonDetail({this.pokemon});

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {

  PaletteGenerator paletteGenerator;
  Color baskinRenk,acikRenk;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    baskinRenk = Colors.orangeAccent;
    baskinRengiBul();
    acikRenk = Colors.purple;
    acikRenkBul();
  }

  void acikRenkBul() {
    Future<PaletteGenerator> fPaletGenerator =  PaletteGenerator.fromImageProvider(NetworkImage(widget.pokemon.img));
    fPaletGenerator.then((value){
      paletteGenerator = value;
      setState(() {
        acikRenk = paletteGenerator.lightVibrantColor.color;
      });
    });
  }

  void baskinRengiBul()  {
    Future<PaletteGenerator> fPaletGenerator =  PaletteGenerator.fromImageProvider(NetworkImage(widget.pokemon.img));
    fPaletGenerator.then((value){
      paletteGenerator = value;
      // debugPrint("secilen renk :" + paletteGenerator.dominantColor.color.toString());

      if(paletteGenerator != null && paletteGenerator.vibrantColor != null){
        baskinRenk = paletteGenerator.vibrantColor.color;
        setState(() {

        });
      }else if(paletteGenerator != null && paletteGenerator.dominantColor != null){
        baskinRenk = paletteGenerator.dominantColor.color;
        setState(() {

        });
      }else{
        debugPrint("NULL COLOR");
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: acikRenk,
      appBar: AppBar(
        backgroundColor: baskinRenk,
        elevation: 0,
        title: Text(
          widget.pokemon.name,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return dikeyBody(context);
        } else {
          return yatayBody(context);
        }
      }),
    );
  }

  Widget yatayBody(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height - 100,
      width: MediaQuery
          .of(context)
          .size
          .width - 20,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Hero(
              tag: widget.pokemon.img,
              child: Container(
                width: 200,
                child: Image.network(
                  widget.pokemon.img,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          VerticalDivider(
            color: Colors.deepOrange,
            width: 20,
            thickness: 3,
            indent: 20,
            endIndent: 20,
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.pokemon.name,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "height: " + widget.pokemon.height,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "weight: " + widget.pokemon.weight,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "egg: " + widget.pokemon.egg,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "num: " + widget.pokemon.num,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "spawnTime: " + widget.pokemon.spawnTime,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Type",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.type
                        .map((tip) =>
                        Chip(
                          backgroundColor: acikRenk,
                          label: Text(
                            tip,
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                        .toList(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "Weakness",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.weaknesses
                        .map((tip) =>
                        Chip(
                          backgroundColor: Colors.brown,
                          label: Text(
                            tip,
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                        .toList(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "PrevEvolution",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.prevEvolution != null
                        ? widget.pokemon.prevEvolution
                        .map((evolution) =>
                        Chip(
                          backgroundColor: Colors.brown,
                          label: Text(
                            evolution.name,
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                        .toList()
                        : [
                      Text(
                        "İlk hali",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "NextEvolution",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.nextEvolution != null
                        ? widget.pokemon.nextEvolution
                        .map((evolution) =>
                        Chip(
                          backgroundColor: Colors.brown,
                          label: Text(
                            evolution.name,
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                        .toList()
                        : [
                      Text(
                        "Son hali",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Stack dikeyBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          height: MediaQuery
              .of(context)
              .size
              .height * (2 / 3),
          width: MediaQuery
              .of(context)
              .size
              .width - 20,
          left: 10,
          top: MediaQuery
              .of(context)
              .size
              .height * 0.1,
          child: ListView(
            children: [
              Card(
                margin: EdgeInsets.all(10),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      widget.pokemon.name,
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "height: " + widget.pokemon.height,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "weight: " + widget.pokemon.weight,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "egg: " + widget.pokemon.egg,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "num: " + widget.pokemon.num,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "spawnTime: " + widget.pokemon.spawnTime,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "Type",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.pokemon.type
                          .map((tip) =>
                          Chip(
                            backgroundColor: Colors.brown,
                            label: Text(
                              tip,
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                          .toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "Weakness",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.pokemon.weaknesses
                          .map((tip) =>
                          Chip(
                            backgroundColor: Colors.brown,
                            label: Text(
                              tip,
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                          .toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "PrevEvolution",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.pokemon.prevEvolution != null
                          ? widget.pokemon.prevEvolution
                          .map((evolution) =>
                          Chip(
                            backgroundColor: Colors.brown,
                            label: Text(
                              evolution.name,
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                          .toList()
                          : [
                        Text(
                          "İlk hali",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "NextEvolution",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.pokemon.nextEvolution != null
                          ? widget.pokemon.nextEvolution
                          .map((evolution) =>
                          Chip(
                            backgroundColor: Colors.brown,
                            label: Text(
                              evolution.name,
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                          .toList()
                          : [
                        Text(
                          "Son hali",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: widget.pokemon.img,
              child: Container(
                width: 150,
                height: 150,
                child: Image.network(
                  widget.pokemon.img,
                  fit: BoxFit.contain,
                ),
              ),
            ))
      ],
    );
  }
}
