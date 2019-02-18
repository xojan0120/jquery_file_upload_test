class MessagesController < ApplicationController
  def new
    @limit = 5
    @message = Message.new
    @images = fetch_images(@limit)
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
      result: result,
      images: fetch_images(5)
    }

    respond_to do |format|
      format.json { render json: json }
    end
  end

  private

    def fetch_images(limit)
      images = []
      Message.all.order(created_at: :desc).limit(limit).each do |message|
        images << message.picture.url
      end
      images
    end
end
