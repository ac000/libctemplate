#! /bin/sh

../template weather.tmpl title "Current Weather" \
  `date "+weekday %A month %B day %d year %Y hour %H min %M sec %S"` \
  loop { header Temperature value 65 } \
       { header "Dew Point" value 63 } \
       { header Humidity  value 80% } \
       { header "Wind Speed" value "2 mph" } \
       { header "Wind Gust"  value "8 mph" } \
       { header "Wind Direction" value ESE } \
       { header Visibility value "5 mi." } \
       { header Ceiling  value "1000 ft." } \
       { header Conditions value Overcast }
