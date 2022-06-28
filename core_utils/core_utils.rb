module Acha
  # Helperish functions used through all modules
  module CoreUtils

    # parses String:foo int:bar into %w[[String foo] [int bar]]
    def self.parse_data(attrs)
      attrs = attrs.map {|arg| arg.split ':'}
    end

    # TODO add comments on every method, yes every method !
    def initalizeClassData(name, attrs)
      parse_data attrs
      fields = create_fields attrs
      constructor = plain_constructor name, attrs
      fields + "\n\n" + constructor
    end

    def create_fields(attrs)
      fields = ""
      attrs.each {|arg| fields.concat "final #{arg[0]} #{arg[1]};\n"}
      fields
    end

    def plain_constructor(className, attrs)
      constructor = "#{className}({})"
      attrs.each {|arg| constructor.insert -2, "this.#{arg[1]},"}
      constructor
    end


    def self.generate_class(name, attribtues)
      initializedData = initalizeClassData(name, attributes)
      %Q(
        class #{name}{
          #{initializedData}
          {{*}}
        }
      )
    end

    def write_file(name, data)
      File.write(name, data)
    end

  end
end
