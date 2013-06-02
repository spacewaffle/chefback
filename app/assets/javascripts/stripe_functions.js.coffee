jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  subscription.setupForm()

subscription =
  setupForm: ->
    $('#new_user').submit ->
      #$('input[type=submit]').attr('disabled', true)
      subscription.processCard()
      false
  
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, subscription.handleStripeResponse)
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
