require 'spec_helper'

describe User do

  before do
    @user = User.new(name: 'Example User', email: 'user@example.com',
                     password: 'foobar', password_confirmation: 'foobar')
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }

  it { should be_valid }

  context 'when name is not present' do
    before { subject.name = '' }
    it { should_not be_valid }
  end

  context 'when email is not present' do
    before { subject.email = '' }
    it { should_not be_valid }
  end

  context 'when name is too long' do
    before { subject.name = 'a' * 51 }
    it { should_not be_valid }
  end

  context 'when email format is invalid' do
    it 'should be invalid' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        subject.email = invalid_address
        # expect(subject).not_to be_valid
        should_not be_valid
      end
    end
  end

  context 'when email format is valid' do
    it 'should be valid' do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        subject.email = valid_address
        # expect(subject).to be_valid
        should be_valid
      end
    end
  end

  context 'when email address is already taken' do
    before do
      user_with_same_email = subject.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  context 'when password is not present' do
    before do
      @user = User.new(name: 'Example User', email: 'user@example.com',
                       password: ' ', password_confirmation: ' ')
    end
    it { should_not be_valid }
  end

  context 'when password does not match confirmation' do
    before { subject.password_confirmation = 'mismatch' }
    it { should_not be_valid }
  end

  context 'with a password that is too short' do
    before { subject.password = subject.password_confirmation = 'a' * 5 }
    it { should be_invalid }
  end

  context 'return value of authenticate method' do
    before { subject.save }
    let(:found_user) { User.find_by(email: subject.email) }

    context 'with valid password' do
      it { should eq found_user.authenticate(subject.password) }
    end

    context 'with invalid password' do
      let(:user_for_invalid_password) { found_user.authenticate('invalid') }

      it { should_not eq user_for_invalid_password }
      # specify { expect(user_for_invalid_password).to be_false }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe 'remember token' do
    before { subject.save }
    its(:remember_token) { should_not be_blank }
  end

end
