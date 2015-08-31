class Listing < ActiveRecord::Base
    has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "default.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
    validates :name, presence: true
    validates :description, presence: true
    validates :price, numericality: { greater_than: 0 }
    belongs_to :user
    has_many :orders
end