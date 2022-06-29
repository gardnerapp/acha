module Acha
  module AchaController
    ACTIONS = %i[index show create update destroy]

    # Writes the superclass for all controllers
    def create_base_controller(file)
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
      File.write file, c
    end

    def create_child_controller(file)
      d = %Q(
          import 'dart:conver';
          import 'package:http/http.dart' as http;
          // TODO import ParentController
          class #{@model}Controller extends ParentController{
            #{ACTIONS.each do |action|
              eval "create_#{action}"
            end
            }
          }
      )
      File.write(file, d)
    end

    def create_index
      %Q(
      Future<List<dynamic>> #{@model}Index() async {
        final response = await http.get(super.#{@model}Path, headers: super.headers);

        #{response_decode}
      }\n
      )
    end

    def create_show
      %Q(
      Future<Map<String,dynamic>> #{@model}Show(int id) async {
        var path = super.#{@model}Path + "${id}";
        final response = await http.get(path, headers: super.headers);

        #{response_decode}
      }\n
      )
    end

    def create_create
      %Q(
        Future<Map<String,dynamic>> #{@model}Create(Map<String,dyanmic> data) async{
          final response = await http.post(super.#{@model}Path, body: data, headers: super.headers);

          #{response_decode}
       }\n
      )
    end

    def create_update
      %Q(
        Future<Map<String,dynamic>> #{@model}Update(Map<String,dyanmic> data) async{
          final response = await http.patch(super.#{@model}Path, body: data, headers: super.headers);

          #{response_decode}
       }\n
      )
    end

    def create_destroy
      %Q(
        Future<Map<String,dynamic>> #{@model}destroy(int id) async{
        var path = super.#{@model}Path + "${id}";
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
