require 'rails_helper'

describe UserForm, type: :model do
  it 'is valid with screen name' do
    user_form = build(:user_form, screen_name: 'shifumin')
    expect(user_form).to be_valid
  end

  it 'is invalid with long screen name' do
    user_form = build(:user_form, screen_name: 'shifumin123456789012345')
    expect(user_form).to be_invalid
  end

  it 'is invalid without screen name' do
    user_form = build(:user_form)
    expect(user_form).to be_invalid
  end
end
