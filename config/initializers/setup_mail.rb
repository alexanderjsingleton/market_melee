# if Rails.env.development? || if Rails.env.production?
if Rails.env.development?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address:        'smtp.sendgrid.net',
    port:           '587',
    authentication: :plain,
    user_name:      'app36472752@heroku.com',
    password:       'jawcrx2o',
    domain:         'melee.herokuapp.com',
    enable_starttls_auto: true
  }
end

