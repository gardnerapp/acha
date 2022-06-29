load "achaController/achaController.rb"
load "achaModel/achaModel.rb"
#load "achaView/achaView.rb"

module Acha
  # sets up relevant directories and files if necessary
  module AchaFile
    include Acha::AchaModel
    include Acha::AchaController


    DIRECTORIES = %i[models controllers views]
    BASE_CONTROLLER_FILE = "base_controller.dart"

  # methods for generating model,controller and view directories
    DIRECTORIES.each do |dir|
      define_method "generate_#{dir}_dir" do
        directory = @path + "#{dir}"
        puts "Generating #{dir} Directory:\t #{directory}\n"
        system "mkdir #{directory}"
      end
    end

    def generate_directories
      puts "Invoking Directory Generators...\n"
      DIRECTORIES.each {|dir| self.send "generate_#{dir}_dir"}
    end

    def generate_files
      generate_model_file
      generate_controller_files
      generate_view_files
    end

    # generate model file
    def generate_model_file
      name = "#{@model.downcase}_model.dart"
      file = @path + "models/" + name
      puts "Creating #{file}\n"
      system "touch #{file}"
      #write to model file
      puts "Writing model to #{file}\n"
      write_model_file(file)
    end

    def generate_controller_files
      base = @path + "controllers/" + BASE_CONTROLLER_FILE

      # Generate base controller file if it does not exist
      if !File.file?(base)
        puts "Creating base_controller.dart...\n"
        system("touch #{base}")
        puts "Writing BaseController.....\n "
        create_base_controller base
      end

      # Generate a controller file
      controller_file = @path + @model + "_controller.dart"
      puts "Creating child controller file...\n"
      system "touch #{controller_file}"
      puts "Writing to child controller file....\n"
      create_child_controller controller_file
    end

    def generate_view_files
      views = %i[index show partial]
      path = @path + "views/"
      views.each do |view|
        system "touch #{path}#{view}_#{@model}"
      end
    end 
  end
end
