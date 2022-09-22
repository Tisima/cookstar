require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "内容に問題ない場合" do
        expect(@user).to be_valid
      end
      it 'emailが255文字以下のユーザーが作成可能' do
        @user.email = 'a' * 245 + '@sample.jp'
        expect(@user).to be_valid
      end
      it 'emailは全て小文字で保存される' do
        @user.email = 'SAMPLE@SAMPLE.JP'
        @user.save!
        expect(@user.reload.email).to eq 'sample@sample.jp'
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nameが空だと登録できない" do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailが256文字以上のユーザーを許可しない' do
        @user.email = 'a' * 246 + '@sample.jp'
        @user.valid?
        expect(@user.errors).to be_added(:email, :too_long, count: 255)
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下であれば登録できない" do
        @user.password = "00000"
        @user.password_confirmation = "00000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordが半角英数字混合でなければ登録できない" do
        @user.password = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordが全角であれば登録できない" do
        @user.password = "ああああああ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password is invalid")
      end
     end
   end

  describe 'パスワードの検証' do
    it 'パスワードと確認用パスワードが間違っている場合、無効であること' do
      @user.password = 'password'
      @user.password_confirmation = 'pass'
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'パスワードが暗号化されていること' do
      expect(@user.encrypted_password).to_not eq 'password'
    end
  end

  describe 'フォローの検証' do
  it'ユーザーが他のユーザーをフォロー、フォロー解除可能である' do
    tester1   = FactoryBot.create(:user)
    tester2   = FactoryBot.create(:user)
    tester1.follow(tester2.id)
    expect(tester1.following?(tester2)).to eq true
    tester1.unfollow(tester2.id)
    expect(tester1.following?(tester2)).to eq false
  end
 end
end
