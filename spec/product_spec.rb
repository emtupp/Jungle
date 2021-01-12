RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "saves successfully when given all required fields" do
      @category = Category.new(name: 'Pet Supplies')
      @product = Product.new(name: 'Cat Hammock', description: Faker::Hipster.paragraph(4), quantity: 8, price: 137.99, category_id: 1)
    end

    it "is not valid without a name" do
      @category = Category.new(name: 'Pet Supplies')
      @product = Product.new(name: nil, description: Faker::Hipster.paragraph(4), quantity: 8, price: 137.99, category_id: 1)
      expect(@product).to_not be_valid
    end

    it "is not valid without a price" do
      @category = Category.new(name: 'Pet Supplies')
      @product = Product.new(name: 'Cat Hammock', description: Faker::Hipster.paragraph(4), quantity: 8, price: nil, category_id: 1)
      expect(@product).to_not be_valid
    end

    it "is not valid without a name" do
      @category = Category.new(name: 'Pet Supplies')
      @product = Product.new(name: 'Cat Hammock', description: Faker::Hipster.paragraph(4), quantity: nil, price: 137.99, category_id: 1)
      expect(@product).to_not be_valid
    end

    it "is not valid without a category" do
      @category = Category.new(name: 'Pet Supplies')
      @product = Product.new(name: 'Cat Hammock', description: Faker::Hipster.paragraph(4), quantity: 8, price: 137.99, category_id: nil)
      expect(@product).to_not be_valid
    end

  end
end