$ ->
  current_currency =
    if in_euro_zone(navigator.language)
      'EUR'
    else
      'USD'

  current_frequency = 'y'

  hide_all_plans = ->
    $('.plan.EUR, .plan.USD').not('.free').hide()

  show_selected_plans = ->
    hide_all_plans()

    combined_selector = $(".plan.#{current_currency}.#{current_frequency}")
    combined_selector.show()

  show_selected_plans()

  toggle_currency = ->
    if current_currency is 'EUR'
      current_currency = 'USD'
    else
      current_currency = 'EUR'

    show_selected_plans()

  set_dollar = ->
    current_currency = 'USD'
    show_selected_plans()

  set_euro = ->
    current_currency = 'EUR'
    show_selected_plans()

  hide_all_currencies = ->
    $('.switch-currency').find('.EUR, .USD').hide()

  show_active_currency = ->
    hide_all_currencies()
    $(".switch-currency .#{current_currency}").show()

  show_active_currency()

  $('.switch-currency').on 'click', ->
    toggle_currency()
    show_active_currency()

  toggle_frequency = ->
    if current_frequency is 'y'
      current_frequency = 'm'
    else
      current_frequency = 'y'

    show_selected_plans()

  hide_all_frequencies = ->
    $('.switch-frequency').find('.y, .m').hide()

  show_active_frequency = ->
    hide_all_frequencies()
    $(".switch-frequency .#{current_frequency}").show()

  show_active_frequency()

  $('.switch-frequency').on 'click', ->
    toggle_frequency()
    show_active_frequency()
