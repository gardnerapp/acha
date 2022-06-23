module FlutterGen
  module Widget
    include CoreUtils

    # methods prefixed with create return the widget string
    # methods prefixed with generate write the created widget to a file

    #args follows Flutter typing syntax String:title
    def generateStateLessWidget(name, attrs, file )
      widget = createStatelessWidget(name, attrs, nil)
      if File.read(file) || File.open(file)
        File.write(file, widget)
      end
    end

    def createStatelessWidget(name, attrs, body)
      parse_data attrs
      fields = create_fields attrs
      constructor = attrs.each {|attr| "".concat("this.#{attr[1]},")}

      widgetReturn = body ? body : "Container()"
      widget = %Q(
                #{import_material}
                class #{name} extends StatelessWidget {
                  #{fields}
                  const #{name}({Key key, #{constructor}}) : super(key: key);

                  @override
                  Widget build(BuildContext context) {
                    return #{widgetReturn};
                  }
                })
    end



  end
end
