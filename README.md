# AI判定ゲーム

2人のプレイヤー（人間またはAI）が3つの質問に答え合い、「相手が人間かAIか」を推理するシンプルなゲームです。

## 技術スタック

- Ruby on Rails 8
- Ruby 3.3
- Google OAuth認証（omniauth-google-oauth2）
- Bootstrap 5.3.0

## 主な機能

- Googleログイン
- プレイヤー参加（2人揃うとゲーム開始、AI混在あり）
- 質問出題（YAMLからランダムに3問選出）
- 回答入力（各質問に自由回答）
- 推理入力（相手が人間 or AIを選択）
- 勝敗判定（推理が正しければ勝利、人間-人間は双方一致で引き分け）

## セットアップ

1. リポジトリをクローン
```
git clone [リポジトリURL]
cd ai_human_game
```

2. 依存関係をインストール
```
bundle install
```

3. データベースをセットアップ
```
rails db:create
rails db:migrate
rails db:seed
```

4. 環境変数を設定
`.env`ファイルを作成し、以下の内容を設定：
```
GOOGLE_CLIENT_ID=your_client_id
GOOGLE_CLIENT_SECRET=your_client_secret
```

5. サーバーを起動
```
rails server
```

6. ブラウザでアクセス
```
http://localhost:3000
```

## テスト

テストを実行するには以下のコマンドを使用：
```
rails test
```
