require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature do

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

  scenario "They can add a product to cart" do
    visit root_path
    click_button("Add")
    puts page.html
    # save_and_open_screenshot
    # expect(page).to have_css '.cart-show'
    expect(page).to have_content("My Cart (1)")
  end

  scenario "They can open cart" do
    visit root_path
    click_button("Add")
    first('a[href="/cart"]').click
    # puts page.html
    # save_and_open_screenshot
    expect(page).to have_css '.cart-show'
  end

  scenario "They can add a product to cart and open cart" do
    visit root_path
    click_button("Add")
    first('a[href="/cart"]').click
    # puts page.html
    # save_and_open_screenshot
    expect(page).to have_content("$64.99")
  end

end
