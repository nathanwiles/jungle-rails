require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should save successfully when all fields are set' do
      @user = User.new(name: 'test', email: 'test', password: 'password', password_confirmation: 'password')
      expect(@user.save).to be true
    end

    context 'presence validations' do
      it 'should validate email is present' do
        @user = User.new(email: nil, name: 'test', password: 'password', password_confirmation: 'password')
        @user.save
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'should validate name is present' do
        @user = User.new(email: 'test', name: nil, password: 'password', password_confirmation: 'password')
        @user.save
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end
      it 'should validate password is present' do
        @user = User.new(name: 'test', email: 'test', password: nil, password_confirmation: 'password')
        @user.save
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'should validate password_confirmation is present' do
        @user = User.new(name: 'test', email: 'test', password: 'password', password_confirmation: nil)
        @user.save
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end
    end

    context 'email uniqueness' do
      it 'should validate email is unique' do
        @user = User.new(name: 'test', email: 'test', password: 'password', password_confirmation: 'password')
        @user.save
        @user2 = User.new(name: 'test', email: 'test', password: 'password', password_confirmation: 'password')
        @user2.save
        expect(@user2.errors.full_messages).to include('Email has already been taken')
      end
      it 'should validate email is unique (case insensitive)' do
        @user = User.new(name: 'test', email: 'test', password: 'password', password_confirmation: 'password')
        @user.save
        @user2 = User.new(name: 'test', email: 'TEST', password: 'password', password_confirmation: 'password')
        @user2.save
        expect(@user2.errors.full_messages).to include('Email has already been taken')
      end
    end

    context 'password validations' do
      it 'should validate that password and password_confirmation match' do
        @user = User.new(name: 'test', email: 'test', password: 'password', password_confirmation: 'notpassword')
        @user.save
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'should validate that password is at least 8 characters' do
        @user = User.new(name: 'test', email: 'test', password: 'pass', password_confirmation: 'pass')
        @user.save

        expect(@user.errors.full_messages).to include('Password is too short (minimum is 8 characters)')
      end
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return a user when email and password are correct' do
      @user = User.new(name: 'test', email: 'test', password: 'password', password_confirmation: 'password')
      @user.save
      expect(User.authenticate_with_credentials('test', 'password')).to eq(@user)
    end
    it 'should return nil when email is not found' do
      @user = User.new(name: 'test', email: 'test', password: 'password', password_confirmation: 'password')
      @user.save
      expect(User.authenticate_with_credentials('notfound', 'password')).to be nil
    end
    it 'should return nil when password is incorrect' do
      @user = User.new(name: 'test', email: 'test', password: 'password', password_confirmation: 'password')
      @user.save
      expect(User.authenticate_with_credentials('test', 'notpassword')).to be nil
    end
    it 'should return user when email is correct but has leading/trailing whitespace' do
      @user = User.new(name: 'test', email: 'test', password: 'password', password_confirmation: 'password')
      @user.save
      expect(User.authenticate_with_credentials('  test  ', 'password')).to eq(@user)
    end
    it 'should return user when email is correct but has wrong case' do
      @user = User.new(name: 'test', email: 'test', password: 'password', password_confirmation: 'password')
      @user.save
      expect(User.authenticate_with_credentials('TEST', 'password')).to eq(@user)
    end
  end
end
