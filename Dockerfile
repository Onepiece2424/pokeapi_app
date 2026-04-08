FROM ruby:3.2

# 必要なパッケージ
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  build-essential \
  libpq-dev

# 作業ディレクトリ
WORKDIR /app

# Gemfileのみコピー（←ここ修正）
COPY Gemfile ./

# bundler
RUN gem install bundler

# bundle install（ここでGemfile.lockが生成される）
RUN bundle install

# アプリ全体をコピー
COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
