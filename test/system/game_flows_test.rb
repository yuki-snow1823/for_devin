require "application_system_test_case"

class GameFlowsTest < ApplicationSystemTestCase
  setup do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: 'google_oauth2',
      uid: '123456',
      info: {
        name: 'テストユーザー',
        email: 'test@example.com'
      }
    })
    
    @user = User.create(name: "テストユーザー", email: "test@example.com", uid: "123456", provider: "google_oauth2")
    @room = Room.create(status: "waiting")
  end

  test "ゲームの一連のフロー" do
    visit root_path
    assert_selector "h1", text: "AI判定ゲームへようこそ！"
    
    click_on "Googleでログイン"
    
    click_on "ゲームに参加する"
    
    assert_selector "h2", text: "ゲームルーム"
    
    within all(".card")[1] do
      fill_in "answer_text", with: "テスト回答1"
      click_on "回答する"
    end
    
    assert_text "あなたの回答: テスト回答1"
    
    within all(".card")[2] do
      fill_in "answer_text", with: "テスト回答2"
      click_on "回答する"
    end
    
    within all(".card")[3] do
      fill_in "answer_text", with: "テスト回答3"
      click_on "回答する"
    end
    
    assert_text "相手は人間ですか、それともAIですか？"
    
    choose "AI"
    click_on "判定する"
    
    assert_text "あなたの判定: AI"
  end
end
