require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

    # SETUP
    before :each do
      @category = Category.create! name: 'Apparel'
  
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end

    scenario "They can click on product to go to details page" do
      visit root_path
      first('a[href="/products/1"]').click
      expect(page).to have_css '.products-show'
    end

end
