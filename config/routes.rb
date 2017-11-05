Rails.application.routes.draw do
    post 'typeform/survey', to: 'trend_generator#test'
end
