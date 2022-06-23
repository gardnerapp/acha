require "optparse"

options = {}
repo_url = "https://github.com/foo"

#TODO add print statements to modules showng which dirs & files are being created
# and written to.

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

  opts.on('-d', '--data type1:var1 type2:var2',
    'A list of your models instance variables and their respective types.') do |v|
      options[:data] = Acha::CoreUtils.parse_data(v)
  end

  opts.on('-h', '--help', 'Display this screen') {puts opts; exit!}

  opts.on_tail "\n\t\tExample:"
  opts.on_tail "\t\truby #{__FILE__} -m User -d String:name String:email int:id\n\n"
end

opts.order!
if options.empty?
  puts "Invalid Syntax please use -h or --help"
  exit!
end

p options
