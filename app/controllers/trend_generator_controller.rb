class TrendGeneratorController < ActionController::API
    def send_link
        name, email, color, bag, style = params[:name], params[:email], params[:color], params[:bag], params[:style]
        jewelry = params[:jewelry]

        score = 0
        score += evaluate(["NEUTRAL EARTH", "NEUTRAL OCEAN", "PASTELS", "COLORFUL"], color, 3)
        score += evaluate(["Minimal", "Sporty", "Classy/Preppy", "Rocker chic"], style, 4)
        score += evaluate(["Don't use jewelry", " ", "Minimal", "Statement"], jewelry, 2)
        score += evaluate(["None", "Clutches", "Handbags", "Backpacks"], bag, 1)
        case score
            when 10..16
                url = "https://www.pinterest.com/OwnTheTrend1/outfit-inspo-1"
            when 17..21
                url = "https://www.pinterest.com/OwnTheTrend1/outfit-inspo-2"
            when 22..28
                url = "https://www.pinterest.com/OwnTheTrend1/outfit-inspo-3"
            when 29..35
                url = "https://www.pinterest.com/OwnTheTrend1/outfit-inspo-4"
            when 36..40
                url = "https://www.pinterest.com/OwnTheTrend1/outfit-inspo-5"
            else
                url = "https://www.pinterest.com/OwnTheTrend1/outfit-inspo-6"
        end
        to_map = [{email: email, name: name}, {email: "ana@ownthetrend.com", name: "Ana Paula Tenorio"}]
        sub_map = {
            "%name%": name,
            "%url%": url,

        }
        send_email(to_map, sub_map)
    end

    def evaluate(options, value, weight)
        case value
            when options[0]
                return 1 * weight
            when options[1]
                return 2 * weight
            when options[2]
                return 3 * weight
            when options[3]
                return 4 * weight
            else
                return 0
        end
    end

    def send_email(to_map, sub_map)
        sendgrid = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

        json = {
            from: {
                email: "ana@ownthetrend.com",
                name: "Ana from Own The Trend"
            },
            personalizations: [
                {
                    to: to_map,
                    substitutions: sub_map
                }
            ],
            template_id: "1a02968c-8603-483f-b398-1c642da580dc",
            content: [
                {
                    type: "text/html",
                    value: "<html><p></p></html>"
                }
            ]
        }

        data = JSON.parse(json.to_json)
        begin
            response = sendgrid.client.mail._('send').post(request_body: data)
            {success: true, response: response}.to_json
        rescue => e
            puts "Sendgrid Error: #{e.message}"
            halt 400, {error: "#{e.message}"}.to_json
        end
    end
end