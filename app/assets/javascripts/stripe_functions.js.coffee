jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  stripe_user.setupForm()

stripe_user =
  setupForm: ->
    $('#new_user').submit ->
      #$('input[type=submit]').attr('disabled', true)
      if $('#card_number').length
        stripe_user.processCard()
        false
      else
        true
  
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, stripe_user.handleStripeResponse)
    console.log("processing card");
    console.log(card);
  
  handleStripeResponse: (status, response) ->
    console.log("got a response!")
    if status == 200
      $('#user_stripe_id').val(response.id)
      $('#new_user')[0].submit()
    else
      $('#stripe_error').text(response.error.message)
      #$('input[type=submit]').attr('disabled', false)