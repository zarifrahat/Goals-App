require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:session_token) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  it { should have_many(:goals) }

  describe 'uniqueness' do
    before :each do
      create :user
    end
      it { should validate_uniqueness_of(:username) }
      it { should validate_uniqueness_of(:session_token) }
  end

  describe 'is_password?' do 
    let!(:user) { create :user}

    context 'with a valid password' do
      it 'should be true' do 
        expect(user.is_password?('firebolt')).to be true
      end
    end

    context 'with an invalid password' do
      it 'should be false' do 
        expect(user.is_password?('securepassword321')).to be false
      end
    end

    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
  end

  # describe 'password=' do
  #   let(:user) { create :user }
  #   # (:user) is naming our variable. 
  #   # { create :user } is creating user from user factory
    
  #   context 'password length greater than or equal to 6 chars' do
  #     it 'create a password digest' do
  #       # debugger
  #       expect(user.password=('firebolt')).to eq(user.password_digest)
  #       # user references the :user created by our let! block

  #       #   def is_password?(password)
  #       # # debugger
  #       # bcrypt_password = BCrypt::Password.new(self.password_digest)
  #       # bcrypt_password.is_password?(password)
  #       end
  #     end
  #   end

  #   context 'password length less than 6 chars' do
  #     it 'raises an error' do
  #     expect { raise StandardError, 'try again' }.to raise_error('try again')
  #     end
  #   end
    
  # end


  describe 'User::find_by_credentials' do
    let!(:user) { create :user }
    # (:user) is naming our variable. 
    # { create :user } is creating user from user factory

    context 'username exists' do
      it 'finds user model instance with that username if they exist' do
        username = user.username
        expect(user.username).to eq(username)
        # user references the :user created by our let! block
      end
    end

    context 'username doesnt exist' do
      it 'returns nil if username doesnt exist' do
        username = User.new(username: "not username", password: "not password")
        expect(user.username).to_not eq(username)
        # user references the :user created by our let! block
      end
    end

    context 'password length less than 6 chars' do
      it 'raises an error' do
      expect { raise StandardError, 'try again' }.to raise_error('try again')
      end
    end
    
  end




  
end

