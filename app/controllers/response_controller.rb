
class ResponseController < ApplicationController
  def show
    @link = flash[:link]
  end

  def create
    message_length = params[:message].length
    ## Check to see if length is between 0 and 256 and set alert if it is
    under_or_over_length = message_length <= 0 || message_length > 256

    ## Make API call only if the length is between not zero or greater than 256
    if under_or_over_length
      flash[:alert] = "You didn't say anything or the message length is greater than 256."
    else
      results = $wit_session.send_message(params[:message])
      if results.confidence < 0.5
        link = "nope1"
      else
        case results.intent
        when "greetings"
          link = '0Bmhjf0rKe8'
        else
          link = "nope2"
        end
      end
      flash[:link] = link
    end
    redirect_to action: "show"
  end
end
