$ ->
  add_monthly_year_prices = ->
    $('.plan').each ->
      html = $(this).find('.plan-price.y').html()
      yearly_string = html.replace('$', '')
      yearly = parseInt(yearly_string, 10)
      monthly = yearly/12
      monthly = Math.round(monthly * 100) / 100
      $(this).find('.yearly-month-price').text(monthly)

  add_monthly_year_prices()

  current_currency =
    if in_euro_zone(navigator.language)
      'EUR'
    else
      'USD'

  current_frequency = 'm'

  hide_all_plans = ->
    $('.plan.EUR, .plan.USD').hide()

  hide_all_frequencies = ->
    $('.plan .y, .plan .m').hide()

  show_selected_plans = ->
    hide_all_plans()
    hide_all_frequencies()

    $(".plan.#{current_currency}").show()
    $(".plan .#{current_frequency}").show()

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

  hide_frequency_buttons = ->
    $('.switch-frequency').find('.y, .m').hide()

  show_active_frequency = ->
    hide_frequency_buttons()
    $(".switch-frequency .#{current_frequency}").show()

  show_active_frequency()

  $('.switch-frequency').on 'click', ->
    toggle_frequency()
    show_active_frequency()
