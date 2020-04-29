class User < ApplicationRecord
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: { minimum: 6}, allow_nil: true

    # has_many :goals,
    # class_name: :Goal,
    # primary_key: :id,
    # foreign_key: :user_id

    
    after_initialize :ensure_session_token
    attr_accessor :password

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        return nil unless user && user.is_password?(password)
        user
    end

    def reset_session_token!
        self.update!(session_token: self.class.generate_session_token)
        self.session_token
    end

    def password=(password)
        # debugger
        @password = password
        self.password_digest = BCrypt::Password.create(password)
        
        # return self.password_digest
    end



    def is_password?(password)
        # debugger
        bcrypt_password = BCrypt::Password.new(self.password_digest)
        bcrypt_password.is_password?(password)
    end

    private

    def self.generate_sessession_token
        SecureRandom::urlsafe_base64(16)
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_sessession_token
    end

end
