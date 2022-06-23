module Acha
  # Generates Flutter models, views & respective controllers

  # TODO create index view that unpacks http req and renders cards with future builder
  # TODO rename API to Controller, its just an http controller its getting whatever from the DB
  # TODO check if index action is plural in rails controller if so modify routes

  module AchaGenerator
    def invoke_scaffold(name, attrs)
      invoke_model(name, attrs); invoke_view(name, attrs); invoke_api(name,attrs)
    end

    %i[model view api].each do |set|
      define_methhod "invoke_#{set}" do |name, attrs|
        # TODO add generate method to each acha module
        eval("Acha::Acha#{set}.send(generate_#{set}, model_name, attrs)")
      end
    end
  end
end
