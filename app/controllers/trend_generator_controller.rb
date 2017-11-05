class TrendGeneratorController < ActionController::API
    def send_link
        json = params[:json]
        name = json[:name]
        puts "Hello #{name}"
    end
end