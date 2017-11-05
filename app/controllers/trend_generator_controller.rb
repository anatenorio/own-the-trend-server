class TrendGeneratorController < ActionController::API
    def send_link
        name = params[:name]
        puts "Hello #{name}"
    end
end