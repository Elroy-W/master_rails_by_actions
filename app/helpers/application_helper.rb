# frozen_string_literal: true

module ApplicationHelper
  def show_add_to_cart(product, options = {})
    html_class = 'btn btn-danger add-to-cart-btn'
    html_class += " #{options[:html_class]}" unless options[:html_class].blank?

    ShoppingCart.create_or_update!({
                                     user_uuid: 'n04xladt',
                                     product_id: 4,
                                     amount: 3
                                   })
    link_to 'Add to cart'.html_safe,
            shopping_carts_path,
            class: html_class, 'data-product-id': product.id
  end
end
