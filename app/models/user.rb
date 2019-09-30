class User < ApplicationRecord
  attr_accessor :skip_password_validation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

         has_many :sns_credentials, dependent: :destroy
         has_many :addresses
         has_many :phone_numbers
         has_one :card
        #  devise :validatable, password_length: 7..128
        validates :nickname, :lastname, :firstname, :lastkana, :firstkana, :birthyear, :birthmonth, :birthday, presence: true
        validates_format_of :password, :with => /([0-9].*[a-zA-Z]|[a-zA-Z].*[0-9])/, message:"は７文字以上128字以下の英数両方を含むよう入力してください。"
       

        def self.find_oauth(auth)
          uid = auth.uid
          provider = auth.provider
          snscredential = SnsCredential.where(uid: uid, provider: provider).first
          # binding.pry
      
          if snscredential.present? #sns登録のみ完了してるユーザー
            user = User.where(id: snscredential.user_id).first
            unless user.present? #ユーザーが存在しないなら
              user = User.new(
                # snsの情報
                # binding.pry
                nickname: auth.info.name,
                email: auth.info.email,
              )
            end
            sns = snscredential
            # binding.pry
      

          else #sns登録 未
            user = User.where(email: auth.info.email).first
            if user.present? #会員登録 済
              sns = SnsCredential.new(
                uid: uid,
                provider: provider,
                user_id: user.id
              )
            else #会員登録 未
              user = User.new(
                nickname: auth.info.name,
                email: auth.info.email
              )
              # binding.pry
              sns = SnsCredential.create(
                uid: uid,
                provider: provider
              )
              # binding.pry 
            end
          end
          # binding.pry
          # hashでsnsのidを返り値として保持しておく
          return { user: user , sns_id: sns.id }
        end
<<<<<<< HEAD
<<<<<<< HEAD
        
        
=======
>>>>>>> parent of fbc5bc0... SNS認証登録機能
=======
>>>>>>> parent of fbc5bc0... SNS認証登録機能

        
# 修正用に保存してます（上記のダミーemailについて）
    #     private
    #     def self.dummy_email(auth)
    #       "#{auth.uid}-#{auth.provider}@example.com"
    # end
end