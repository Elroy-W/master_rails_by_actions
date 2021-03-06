class Product < ApplicationRecord

validates :category_id,presence: {message:"Index cannot be blank!"}
validates :title,presence: {message:"Title cannot be blank!"}
validates :status, inclusion:{ in: %w[on off], 
        message: "Thes status of product must be on | off"}
validates :amount, numericality:{only_integer: true,
    message: "The amount of product must be integer"},
    if: proc { |product| !product.amount.blank? }
validates :amount,presence: {message:"Amount cannot be blank!"}
validates :msrp,presence: {message:"MSRP cannot be blank!"}
validates :price,presence: {message:"Price cannot be blank!"}
validates :msrp, numericality:{message: "MSRP must be numerical"},
    if: proc{ |product| !product.msrp.blank?}
validates :price, numericality:{message: "Price must be numerical"},
    if: proc{ |product| !product.price.blank?}
validates :description,presence: {message:"The description cannot be blank!"}


belongs_to :category
has_many :product_images, -> { order(weight: 'desc') },
    dependent: :destroy
has_one :main_product_image,-> { order(weight: 'desc') },
    class_name: :ProductImage
   

before_create :set_default_attrs

scope :onshelf, -> { where(status: Status::On) }
# Ex:- scope :active, -> {where(:active => true)}

module Status
    On = 'on'
    Off = 'off'
end
private
def set_default_attrs
    self.uuid =  RandomCode.generate_product_uuid
end

end
