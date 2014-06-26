
class ResponseController < ApplicationController
  helper_method :youtube_link_decider
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
      flash[:link] = "wow"
    else
      results = $wit_session.send_message(params[:message])
      flash[:link] = youtube_link_decider(results)
    end
    redirect_to action: "show"
  end


  ## Assists in returning the correct youtube link given the wit.ai results
  ## Returns the string of the youtube link
  def youtube_link_decider(results)
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

    return link
  end
end
