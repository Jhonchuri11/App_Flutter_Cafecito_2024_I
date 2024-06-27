import 'package:flutter/material.dart';
import 'package:cafecitodev/model/song_model.dart';

class EditSongPage extends StatefulWidget {
  final SongModel? songModel;

  const EditSongPage({Key? key, this.songModel}) : super(key: key);

  @override
  _EditSongPageState createState() => _EditSongPageState();
}

class _EditSongPageState extends State<EditSongPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageController;
  late TextEditingController _mp3Controller;
  late TextEditingController _authorController;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.songModel?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.songModel?.description ?? '');
    _imageController =
        TextEditingController(text: widget.songModel?.image ?? '');
    _mp3Controller = TextEditingController(text: widget.songModel?.mp3 ?? '');
    _authorController =
        TextEditingController(text: widget.songModel?.author ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    _mp3Controller.dispose();
    _authorController.dispose();
    super.dispose();
  }

  void _submit() {
    // Handle form submission to update song
    // Example: You can call your API service to update the song here
    // For simplicity, let's just print the updated values
    print('Updated Title: ${_titleController.text}');
    print('Updated Description: ${_descriptionController.text}');
    print('Updated Image URL: ${_imageController.text}');
    print('Updated MP3 URL: ${_mp3Controller.text}');
    print('Updated Author: ${_authorController.text}');

    // Navigate back to previous screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Song'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 4,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _mp3Controller,
                decoration: InputDecoration(labelText: 'MP3 URL'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(labelText: 'Author'),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Update Song'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
