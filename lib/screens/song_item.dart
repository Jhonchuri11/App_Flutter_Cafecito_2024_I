import 'package:cafecitodev/model/song_model.dart';
import 'package:flutter/material.dart';

class SongItem extends StatelessWidget {
  final SongModel? model;
  final Function? onDelete;

  const SongItem({
    Key? key,
    this.model,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/edit-song', arguments: {
          'model': model,
        });
      },
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 9.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: cartItem(context),
        ),
      ),
    );
  }

  Widget cartItem(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          alignment: Alignment.center,
          margin: EdgeInsets.all(10),
          child: Image.network(
            (model?.image == null || model?.image == "")
                ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                : model!.image!,
            height: 70,
            fit: BoxFit.scaleDown,
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model!.title,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${model!.description}",
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 180,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                      onTap: () {},
                    )
                  ],
                ),
              )
            ],
          ),
        ))
      ],
    );
  }
}
