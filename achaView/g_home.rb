module Acha
  module AchaView



    def import_material; "import 'package:flutter/material.dart';"; end


    def theme(color)
      %Q(
        ThemeData(
            primarySwatch: Colors.#{color},
            splashColor: Colors.#{color},
            appBarTheme: AppBarTheme(elevation: 16.0),
            cardTheme: CardTheme(
              elevation: 20.0,
              shadowColor: Colors.deep#{color}),
            sliderTheme: SliderThemeData(
              activeTrackColor: Colors.deep#{color},
              inactiveTrackColor: Colors.grey,
              trackHeight: 3.0,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
            ),
          )
      )
    end
  end

end
