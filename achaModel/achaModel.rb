load "core_utils/core_utils.rb"

module Acha
  module AchaModel

    def write_model_file(file)
      obj = CoreUtils.generate_class(@model, @attrs)

      json_methods = "#{from_json_method}\n#{to_json_method}"
      obj.gsub!("{{*}}", json_methods)
      File.write(file, obj)
    end

    def from_json_method
      %Q(
      factory #{@model}.fromJson(Map<string,dynamic> json){
        return #{@model}{
          #{unpack_json},
        };
      })
    end

    def to_json_method
      fields = ""
      @attrs.each {|arg| fields.concat "'#{arg[0]}': this.#{arg[0]},\n"}
      %Q(
      Map<String,dynamic> toJson(){
        return {
          #{fields}
        };
      })
    end

    def unpack_json
      json = ""
      @attrs.each {|arg| json.concat "#{arg[0]}: json['#{arg[0]}'],"}
      json
    end

  end
end
