class Listing < ActiveRecord::Base
  if Rails.env.development?
    has_attached_file :image, styles: { medium: "200x", thumb: "100x100>" }, default_url: "default.png"
  else
    validates :name, presence: true
    validates :description, presence: true
    validates :price, numericality: { greater_than_0: true }
    has_attached_file :image, styles: { medium: "200x", thumb: "100x100>" }, default_url: "default.png",
                      :storage => :dropbox,
                      :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                      :path => ":style/:id_:filename"
    validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  end
end