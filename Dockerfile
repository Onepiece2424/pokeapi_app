FROM ruby:2.7.5

# 必要なパッケージ
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  yarn \
  build-essential \
  libpq-dev

# 作業ディレクトリ
WORKDIR /app

# Gemfileをコピー
COPY Gemfile Gemfile.lock ./

# bundle install
RUN bundle install

# アプリ全体をコピー
COPY . .

# ポート開放
EXPOSE 3000

# 起動コマンド
CMD ["rails", "server", "-b", "0.0.0.0"]
