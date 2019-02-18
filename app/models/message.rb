# comment
class Message < ApplicationRecord
  mount_uploader :picture, PictureUploader
end
