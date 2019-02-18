class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    content = params[:message][:content]
    picture = params[:message][:picture]
    @message = Message.create(content: content, picture: picture)
    if @message.save
      flash[:success] = "created success!"
    else
      flash[:notice] = "created failure..."
    end

    data = [{ name: "test" }]
    json = JSON.generate({ files: data })

    respond_to do |format|
      format.json { render json: json }
      format.js
      format.html
    end
  end
end
