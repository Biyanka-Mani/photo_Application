// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"


  var stripe = Stripe('pk_test_51Pd5hdHczqJdVP4PISedP7hi729aYues3UCYWJ0J9Eozqslemubpta7rzkXb8HkvPoYFfa8wjJKRnM4H8mh9NNJL00nEO6QYbt');
  var elements = stripe.elements();

  var card = elements.create('card')

  card.mount('#card-element');

  var form = document.querySelector('.cc_form');

  form.addEventListener('submit', function(event) {
    event.preventDefault();

    stripe.createToken(card).then(function(result) {
      if (result.error) {
        // Inform the user if there was an error
        var errorElement = document.getElementById('card-errors');
        errorElement.textContent = result.error.message;
      } else {
        // Send the token to your server
        var hiddenInput = document.createElement('input');
        hiddenInput.setAttribute('type', 'hidden');
        hiddenInput.setAttribute('name', 'payment[token]');
        hiddenInput.setAttribute('value', result.token.id);
        form.appendChild(hiddenInput);

        // Submit the form
        form.submit();
      }
    });
  });
