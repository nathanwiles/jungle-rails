require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should save successfully when all fields are set' do
      @user = User.new(name: 'test', email: 'test', password: 'password', password_confirmation: 'password')
      expect(@user.save).to be true
    end

    context 'presence validations' do
      it 'should not save when email is not present' do
        @user = User.new(email: nil, name: 'test', password: 'password', password_confirmation: 'password')
        expect(@user.save).to be false
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'should not save when name is not present' do
        @user = User.new(email: 'test', name: nil, password: 'password', password_confirmation: 'password')
        expect(@user.save).to be false
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end
      it 'should not save when password is not present' do
        @user = User.new(name: 'test', email: 'test', password: nil, password_confirmation: 'password')
        expect(@user.save).to be false
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'should not save when password_confirmation is not present' do
        @user = User.new(name: 'test', email: 'test', password: 'password', password_confirmation: nil)
        expect(@user.save).to be false
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end
    end

    context 'email uniqueness' do
      it 'should not save when email is not unique' do
        @user = User.new(name: 'test', email: 'test', password: 'password', password_confirmation: 'password')
        @user.save
        @user2 = User.new(name: 'test', email: 'test', password: 'password', password_confirmation: 'password')
        expect(@user2.save).to be false
        expect(@user2.errors.full_messages).to include('Email has already been taken')
      end
      it 'should not save when email is not unique (case insensitive)' do
        @user = User.new(name: 'test', email: 'test', password: 'password', password_confirmation: 'password')
        @user.save
        @user2 = User.new(name: 'test', email: 'TEST', password: 'password', password_confirmation: 'password')
        expect(@user2.save).to be false
        expect(@user2.errors.full_messages).to include('Email has already been taken')
      end
    end

    context 'password validations' do
      it 'should not save when password and password_confirmation do not match' do
        @user = User.new(name: 'test', email: 'test', password: 'password', password_confirmation: 'notpassword')
        expect(@user.save).to be false
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'should not save when password is less than 8 characters' do
        @user = User.new(name: 'test', email: 'test', password: 'pass', password_confirmation: 'pass')
        expect(@user.save).to be false
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 8 characters)')
      end
    end
  end
end
