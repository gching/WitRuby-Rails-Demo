
class ResponseController < ApplicationController
  def show
    @link = flash[:link]
  end

  def create
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
    redirect_to action: "show"
  end
end
