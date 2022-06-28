module Acha
  # Generates Views for a given model
  module AchaView
#todo invoke these methods and test
    # Create methods for creating partial and show methods
    %i[partial show].each do |view|
      define_singleton_method "create_#{view}" do |model|
        widget = "#{model.capitalize}#{view.capitalize}"
        %Q(
          class #{widget} extends StatelessWidget{
            final #{model.capitalize} #{model};

            const #{widget}({Key key, this.#{model}}) : super(key: key);
            @override
            Widget build(BuildContext context) {
              return Container();
            }
          }
        )
      end
    end

    def create_index(model)
      widget = "#{model.capitalize}Index"
      %Q(
        class #{widget} extends StatelessWidget{

          const #{widget}({Key key}) : super(key: key);

          @override
          Widget build(BuildContext context) {
            #{model.capitalize}Controller #{model}Controller = #{model.capitalize}Controller();
            return FutureBuilder(
              future: #{model}Controller.index(),
              builder: (context, snapShot) {
                if (snapShot.hasData) {
            return ListView.separated(
                itemBuilder: (BuildContext context, int indx) {
                  return #{model.capitalize}Partial(
                    #{model}: snapShot.data[indx],
                  );
                },
                separatorBuilder: (BuildContext context, int indx) {
                  return SizedBox(height: 40);
                },
                itemCount: snapShot.data.length);
              } else if(snapShot.hasError){
                 return Container(
                   child: InfoGraphic(msg: 'Error :\(\n\n Please Try Later'));
              }
              return Container(
            height: 100.0,
            child: Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
                  strokeWidth: 10.0,
            )));
            }
            );
          }
        }
      )
  end
end
