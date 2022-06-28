require "optparse"
load "core_utils/core_utils.rb"
load "files/file_generator.rb"

# todo handle missed args, add path option
options = {}
repo_url = "https://github.com/foo"

# Eliminate -d flag grab everything after model as args

# For now we are only doing scaffolding, other generators will be added later
opts = OptionParser.new do |opts|
  opts.banner = %Q(
                        ~()*~()*~()* ~()*~()*~()* Acha ~()*~()*~()*~()*~()*~()*
                        ~()*~()*~()*~()* MetaProgram Flutter Widgets ~()*~()*~()*~()*

                        Usage: #{__FILE__} -m [Model] -d [type1:var1 type2:var2]

                        Model name should be capitalized !!
                        Typing of Variables should follow Dart syntax !!

                                           ** NOTICE **
                        The generators are not meant to be perfect but do
                        provide a way to quicky automate the boring stuff and speed
                        up app development.

                        For more information visit #{repo_url}.
                        Feel free to contribute and customize to your hearts desire !\n\n)

  opts.on('-m', '--model MyModel', 'The name of the model you would like to use') do |v|
    options[:model] = v.downcase.capitalize
  end

  opts.on('-a', '--attributes type1:var1,type2:var2',
    'A list of your models attributes and their types.') do |v|
    options[:attrs] = Acha::CoreUtils.parse_data(v.split(","))
  end

  opts.on('-p', '--path ~/path_to_my_flutter_proj/lib',
  'The absolute path to your flutter lib directory') do |v|
    options[:path] = v
  end

  opts.on('-h', '--help', 'Display this screen') {puts opts; exit!}

  opts.on_tail "\n\t\t\t\tExample:"
  opts.on_tail "\t\t\t\truby #{__FILE__} -m User -d String:name,String:email,int:id\n\n -p absolute_path_of_projects_lib_directory"
end


opts.order!
if options.empty?
  puts opts
  exit!
end

puts "Your options are:"
p options
puts "\n\n"

# unpack -> map = {:foo => :bar}.each_pair {|k,v| eval("#{k} = #{v}")}


# Generate necessary directories
acha = Acha::FileGenerator.new(options[:path], options[:model], options[:attrs])

acha.generate
