require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "saves successfully when given all required fields" do
      @user = User.new(name: 'User 1', email: 'TEXT@TEXT.COM', password: 'password', password_confirmation: 'password')
    end

    it "is not valid without a password" do
      @user = User.new(name: 'User 1', email: 'TEXT@TEXT.COM', password_confirmation: 'password')
      expect(@user).to_not be_valid
    end

    it "is not valid without a password confirmation" do
      @user = User.new(name: 'User 1', email: 'TEXT@TEXT.COM', password: 'password')
      expect(@user).to_not be_valid
    end

    it "is not valid with wrong password confirmation" do
      @user = User.new(name: 'User 1', email: 'TEXT@TEXT.COM', password: 'password', password_confirmation: 'wrong')
      expect(@user).to_not be_valid
    end

    it "is not valid with same password, but in upper case" do
      @user = User.new(name: 'User 1', email: 'TEXT@TEXT.COM', password: 'password', password_confirmation: 'PASSWORD')
      expect(@user).to_not be_valid
    end

    it "requires a password with a minimum length of five" do
      @user = User.new(name: 'User 1', email: 'TEXT@TEXT.COM', password: 'four', password_confirmation: 'four')
      expect(@user).to_not be_valid
    end

    it "is not valid without an email" do
      @user = User.new(name: 'User 1', password: 'password', password_confirmation: 'password')
      expect(@user).to_not be_valid
    end

    it "prevents two users from having the same email, not case sentsitive" do
      @user = User.new(name: 'User 1', email: 'TEXT@TEXT.COM', password: 'password', password_confirmation: 'password')
      @user2 = User.new(name: 'User 2', email: 'text@text.com', password: 'secure', password_confirmation: 'secure')
      expect(@user2).to_not be_valid
    end

    it "is not valid without a name" do
      @user = User.new(email: 'TEXT@TEXT.COM', password: 'password', password_confirmation: 'password')
      expect(@user).to_not be_valid
    end

  end

end