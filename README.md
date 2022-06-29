*~*~*~*~*~*~*~**~* Welcome to Acha *~*~*~*~*~*~*~*~**~*~*
*~*~ A Ruby library for Metaprogramming Flutter Apps *~*~

Acha is inspired by Ruby On Rails Scaffolding. It's basically scaffolding
for Flutter projects where you pass in your models name and its attributes. This
tool saves you time by creating the MVC directories for you as well as the
respective files. Acha will also generate the widgets and http request for your model,
that way you can focus on building an awesome UI.

Although the files generated follow my personal conventions for Dart MVC Acha is
open sourced, free to use so customize to your hearts desire !

Example:
  ruby acha.rb -m User -d name:String,email:String,id:int -p /path/to/my/flutterprojects/lib

  Running this command will generate:
    lib/models:
      user_model.dart
    lib/controllers:
      base_controller.dart
      user_controller.dart
    lib/views:
      index_user.dart
      show_user.dart
      partial_user.dart

TODO:
  - Add FutureBuilders to index_model widget
  - Add routing from index_model to show_model
  - Add create, update and destroy views
  - Make model names lowercase in files 
  - Package as gem, Write Test ???
