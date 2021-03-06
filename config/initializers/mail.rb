unless Rails.env.development?
  ActionMailer::Base.smtp_settings = {
    port:              587,
    address:           'smtp.mailgun.org',
    user_name:         ENV['MAILGUN_SMTP_LOGIN'],
    password:          ENV['MAILGUN_SMTP_PASSWORD'],
    domain:            'https://fast-stream-50091.herokuapp.com',
    authentication:    :plain,
    content_type:      'text/html'
  }
  ActionMailer::Base.delivery_method = :smtp
end

if Rails.env.development?
  # Makes debugging *way* easier.
  ActionMailer::Base.raise_delivery_errors = false
end

# This interceptor just makes sure that local mail
# only emails you.
# http://edgeguides.rubyonrails.org/action_mailer_basics.html#intercepting-emails
class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.to =  'youremail@website.com'
    message.cc = nil
    message.bcc = nil
  end
end

# Locally, outgoing mail will be 'intercepted' by the
# above DevelopmentMailInterceptor before going out
if Rails.env.development?
  ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor)
end
