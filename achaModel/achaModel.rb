module Acha
  module AchaModel

    def from_json_method(model, attrs)
      %Q(
      factory #{model}.fromJson(Map<string,dynamic> json){
        return #{model}{
          #{unpack_json attrs},
        };
      })
    end

    def to_json_method(attrs)
      fields = ""
      attrs.each {|arg| fields.concat "'#{arg}: this.#{arg},\n'"}
      %Q(
      Map<String,dynamic> toJson(){
        return {
          #{fields}
        };
      })
    end

    def unpack_json()
      json = ""
      attrs.each {|arg| json.concat "#{arg[1]}: json['#{arg[1]}']"}
      json
    end

    def self.write_model_file(file, model, attrs)
      obj = generate_class(model, attrs)

      json_methods = "#{from_json_method(model, attrs)}\n#{to_json_method(attrs)}"
      obj.gsub!("{{*}}", json_methods)
      File.write(file, obj)
    end

  end
end
