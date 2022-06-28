module Acha
  class Acha

    include AchaFile

    def initialize(model, attrs, path)
      @model = model
      @attrs = attrs
      @path = path.concat "/" unless path[-1] == "/"
    end

    def to_s
      p @model, @attrs, @path
    end

    def generate
      generate_directories
      generate_files
    end

  end
end
