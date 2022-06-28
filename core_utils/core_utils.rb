module Acha
  # Helperish functions used through all modules
  module CoreUtils

    # parses String:foo int:bar into %w[[String foo] [int bar]]
    def self.parse_data(attrs)
      attrs = attrs.map {|arg| arg.split ':'}
    end

    # Boiler plate for class and attributes
    def self.generate_class(name, attributes)
      initializedData = initalizeClassData(name, attributes)
      %Q(
        class #{name}{
          #{initializedData}
          {{*}}
        }
      )
    end

    # Class fields & constructor
    def self.initalizeClassData(name, attrs)
      fields = create_fields attrs
      constructor = plain_constructor name, attrs
      fields + "\n\n" + constructor
    end

    def self.create_fields(attrs)
      fields = ""
      attrs.each {|arg| fields.concat "final #{arg[1]} #{arg[0]};\n"}
      fields
    end

    def self.plain_constructor(className, attrs)
      constructor = "#{className}({"
      attrs.each {|arg| constructor.concat("this.#{arg[0]},")}
      constructor.concat ")};"
      constructor
    end

  end
end
