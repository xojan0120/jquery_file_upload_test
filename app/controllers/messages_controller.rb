class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    picture = params[:message][:picture]
    @message = Message.create(picture: picture)
    result = ""
    if @message.save
      #flash[:success] = 'created success!'
      result = "OK"
    else
      #flash[:notice] = 'created failure...'
      result = "NG"
    end

    json = {
      result: result
    }

    respond_to do |format|
      format.json { render json: json }
    end
  end
end
