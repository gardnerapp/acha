module Acha
  module Widgets
    module Components

      def generateCard(name, attrs)
        body = %Q(
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  padding: EdgeInsets.all(10),
                  child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                          child: Container())); // TODO insert your child !
                  )
        widget = createStatelessWidget(name, attrs, body)
      end
    end
  end
end
