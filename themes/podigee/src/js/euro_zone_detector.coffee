# accepts a string formatted like "en-US"
# you probably want to pass navigator.language into here
window.in_euro_zone = (navigator_language) ->
  countries = [
    'AT'
    'BE'
    'CY'
    'DE'
    'EE'
    'ES'
    'FI'
    'FR'
    'GR'
    'IE'
    'IT'
    'LU'
    'LV'
    'MT'
    'NL'
    'PT'
    'SI'
    'SK'
  ]

  return false unless navigator_language
  split_language = navigator_language.split('-')
  country = split_language[split_language.length-1]
  return false unless country

  countries.indexOf(country.toUpperCase()) != -1

