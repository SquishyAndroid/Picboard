OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['344644069075513'], ENV['d174c3911d44483acc14d99637f64f29']
end