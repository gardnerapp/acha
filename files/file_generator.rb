module Acha
  # sets up relevant directories and files if necessary
  class FileGenerator
    DIRECTORIES = %i[models controllers views]
    BASE_CONTROLLER_FILE = "base_controller.dart"

    def initalize(path, model, attrs)
      path += "/" unless path[-1] == "/"
      @path = path
      @model = model
      @attrs = attrs
    end

    # create methods for generating model,controller and view directories
    DIRECTORIES.each do |dir|
      define_singleton_method "generate_#{dir}_dir" do
        directory = @path + "#{dir}"
        puts "Generating #{dir} Directory:\t #{directory}\n"
        system "mkdir #{directory}"
      end
    end

    def self.generate_directories
      puts "Invoking Directory Generators...\n"
      DIRECTORIES.each {|dir| self.send "generate_#{dir}_dir"}
    end

    def generate_model_file
      # generate model file
      name = "#{@model.downcase}_model.dart"
      file = @path + name
      puts "Creating #{file}\n"
      system "touch #{file}"
      #write to model file
      puts "Writing model to #{file}\n"
      Acha::AchaModel.write_model_file(file, @model, @attrs)
    end

    def self.generate_controller_files
      base = @path + BASE_CONTROLLER_FILE

      # Generate base controller file if it does not exist
      if !File.file?(base)
        puts "Creating base_controller.dart...\n"
        system("touch #{base}")
        puts "Writing BaseController.....\n "
        Acha::AchaController.create_base_controller base
      end

      # Generate a controller file
      controller_file = @path + @model + "_controller.dart"
      puts "Creating child controller file...\n"
      system "touch #{controller_file}"
      puts "Writing to child controller file....\n"
      Acha::AchaController.create_child_controller @model, @attrs, controller_file
    end

    def self.generate_view_files

    end


  end
end
