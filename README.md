*~*~*~*~*~*~*~**~* Welcome to Acha *~*~*~*~*~*~*~*~**~*~*
*~*~ A Ruby library for Metaprogramming Flutter Apps *~*~

Acha is inspired by Ruby On Rails and shares the command syntax of Rails generators.\
For example you can do this:

  acha g scaffold Item String:name String:price int:id List<String>:tags

  output:

  Invoking Acha::ModelGen .......

  Created "my_flutter_project/lib/models/item.dart"

  Invoking Acha::ControllerGen ......

  Checking if "my_flutter_project/lib/controllers/base_controller.dart" exist
  creating "my_flutter_project/lib/controllers/base_controller.dart"
  creating "my_flutter_project/lib/controllers/item_controller.dart"

  Invoking Acha::ViewGen .........

  Created "my_flutter_project/lib/views/item_index.dart"
  Created "my_flutter_project/lib/views/item_partial.dart"
  Created "my_flutter_project/lib/views/item_page.dart"

  Please add the following line to the BaseController
  ~>  var itemsPath = api + "items"   <~

You can also use:
      acha g model MODEL_NAME DATA_TYPE:VARIABLE
      acha g controller MODEL_NAME DATA_TYPE:VARIABLE
      acha g view MODEL_NAME DATA_TYPE:VARIABLE

Acha, like Rails generators, does a lot of the heavy lifting for us. The widgets,
files and objects it generates are not perfect but serve as a solid stepping stone
for application development. Feel free to fork, customize or even contribute to Acha !

TODO create controller actions and views for creating, updating and destroying models
