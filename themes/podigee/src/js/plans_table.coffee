$ ->
  $('.info-row').on('click', (event) ->
    event.preventDefault()
    more_info = $(this).data('show')

    $(more_info).toggleClass('hide')
  )
