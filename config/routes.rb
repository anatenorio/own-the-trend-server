Rails.application.routes.draw do
    get 'typeform/survey', to: 'trend_generator#send_link'
end
