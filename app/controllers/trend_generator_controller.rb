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
                puts "Board 1"
            when 17..21
                puts "Board 2"
            when 22..28
                puts "Board 3"
            when 29..35
                puts "Board 4"
            when 36..40
                puts "Board 5"
            else
                puts "Board 6"
        end
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
end