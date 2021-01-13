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
      @user = User.new(name: 'User 1', email: 'TEXT@TEXT.COM', password: 'password', password_confirmation: 'password').save
      @user2 = User.new(name: 'User 2', email: 'text@text.com', password: 'secure', password_confirmation: 'secure')
      expect(@user2).to_not be_valid
    end

    it "is not valid without a name" do
      @user = User.new(email: 'TEXT@TEXT.COM', password: 'password', password_confirmation: 'password')
      expect(@user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do

    it "validates successfully when given all required fields" do
      @user = User.new(name: 'User 1', email: 'TEXT@TEXT.COM', password: 'password', password_confirmation: 'password').save
      expect(User.authenticate_with_credentials('TEXT@TEXT.COM', 'password')).not_to eq(nil)
    end

    it "does NOT validates successfully when given non existant email" do
      @user = User.new(name: 'User 1', email: 'TEXT@TEXT.COM', password: 'password', password_confirmation: 'password').save
      expect(User.authenticate_with_credentials('wrong@email.com', 'password')).to eq(nil)
    end

    it "does NOT validates successfully when given wrong password" do
      @user = User.new(name: 'User 1', email: 'TEXT@TEXT.COM', password: 'password', password_confirmation: 'password').save
      expect(User.authenticate_with_credentials('TEXT@TEXT.COM', 'PASSWORD')).to eq(nil)
    end

    it "does NOT validates successfully when given only email" do
      @user = User.new(name: 'User 1', email: 'TEXT@TEXT.COM', password: 'password', password_confirmation: 'password').save
      expect(User.authenticate_with_credentials('TEXT@TEXT.COM', '')).to eq(nil)
    end

    it "does NOT validates successfully when given no input" do
      @user = User.new(name: 'User 1', email: 'TEXT@TEXT.COM', password: 'password', password_confirmation: 'password').save
      expect(User.authenticate_with_credentials('', '')).to eq(nil)
    end

    # it "does NOT have case sensitive email" do
    #   @user = User.new(name: 'User 1', email: 'TEXT@TEXT.COM', password: 'password', password_confirmation: 'password').save
    #   expect(User.authenticate_with_credentials('text@text.com', 'password')).not_to eq(nil)
    # end

    it "does NOT read trailing and leading spaces in email" do
      @user = User.new(name: 'User 1', email: 'TEXT@TEXT.COM', password: 'password', password_confirmation: 'password').save
      expect(User.authenticate_with_credentials('   TEXT@TEXT.COM   ', 'password')).not_to eq(nil)
    end

  end

end