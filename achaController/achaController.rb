module Acha
  module AchaController
    # TODO might want to add model.fromJson calls directly to API
    BASE_CONTROLLER_FILE = "base_controller.dart"
    ACTIONS = %i[index show create update destroy]

    # Generates controller, creates ParentController if necessary and
    # appends routes to parent controller.
    def generate_controller(model, attrs)
      create_parent_controller unless parent_controller_present?
      append_route(create_route(model))
      attrs = parse_data attrs # TODO extend, include, or prepend CoreUtils?
      create_child_controller model, attrs
    end

    # The parent controller holds routes, headers and other constants, it
    # is the super class for all other controllers.
    def create_parent_controller
      c = %Q(
          //The parent controller holds routes, headers and other constants, it
          //is the super class for all other controllers.
          class ParentController{
            static String base = "http://localhost:3000";
            // TODO change base to production domain

            static var api = base + "/api/v1/";
            // Ex. var foosPat = api + "foo/";

            Map<String,String> headers = {
              "Content-Type": "application/json; charset=UTF-8"
            };
          }
      )
      write_file "parent_controller.dart", c
    end

    def create_route(model)
      m = model.downcase
      r = "var #{m}Path = api + \"#{m}\";\n\t"
    end

    def append_route(route)
      # TODO open parent and add route
    end


    def parent_controller_present?

    end

    def create_child_controller(model, attrs)
      # TODO find parent file inside dir and import
      d = %Q(
          import 'dart:conver';
          import 'package:http/http.dart' as http;
          // TODO import ParentController
          class #{model}Controller extends ParentController{
            #{ACTIONS.each do |action| eval "create_#{action}(#{model.downcase})"}
          }
      )
      write_file "#{model}_model.dart", d
    end

    def create_index(m)
      %Q(
      Future<List<dynamic>> #{m}Index() async {
        final response = await http.get(super.#{m}Path, headers: super.headers);

        #{response_decode}
      }\n
      )
    end

    def create_show(m)
      %Q(
      Future<Map<String,dynamic>> #{m}Show(int id) async {
        var path = super.#{m}Path + "${id}";
        final response = await http.get(path, headers: super.headers);

        #{response_decode}
      }\n
      )
    end

    def create_create(m) # TODO might need to fix
      %Q(
        Future<Map<String,dynamic>> #{m}Create(Map<String,dyanmic> data) async{
          final response = await http.post(super.#{m}Path, body: data, headers: super.headers);

          #{response_decode}
       }\n
      )
    end

    def create_update(m) #TODO find correct HTTP verb
      %Q(
        Future<Map<String,dynamic>> #{m}Update(Map<String,dyanmic> data) async{
          final response = await http.patch(super.#{m}Path, body: data, headers: super.headers);

          #{response_decode}
       }\n
      )
    end

    def create_destroy(m)
      %Q(
        Future<Map<String,dynamic>> #{m}destroy(int id) async{
        var path = super.#{m}Path + "${id}";
        final response = await http.delete(path, headers: super.headers);

        #{response_decode}
       }\n
      )
    end

    # An if/else dart conditional for responses
    def response_decode
      %Q(
        if (response.statusCode == 200){
          var body = jsonDecode(response.body);
          return body;
        } else{
          return null;
        }
      )
    end

  end
end