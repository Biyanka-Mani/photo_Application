Rails.configuration.stripe = {
  publishable_key:"pk_test_51Pd5hdHczqJdVP4PISedP7hi729aYues3UCYWJ0J9Eozqslemubpta7rzkXb8HkvPoYFfa8wjJKRnM4H8mh9NNJL00nEO6QYbt",
  secret_key: "sk_test_51Pd5hdHczqJdVP4PRrPIZXSAZUpZIFZ70h1IkN2WGQSCQuBKhiQWe4gaFrWXBYqLKaNTLqG2OU0ZPeUOM6hMymqz001LyC1KVI"
}
Stripe.api_key = Rails.configuration.stripe[:secret_key]