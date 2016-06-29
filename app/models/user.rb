class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :validatable, :timeoutable, :rememberable and :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :omniauthable, omniauth_providers: [:twitter]

  belongs_to :team
  has_one :identity

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #   end
  # end

  def twitter
    identities.where( :provider => "twitter" ).first
  end

  def twitter_client
    @twitter_client ||= Twitter.client( access_token: twitter.accesstoken )
  end

  def handle
    identity.nickname
  end

end
