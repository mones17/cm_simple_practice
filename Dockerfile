FROM ruby:3.4.1  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
    wget \  
    gnupg2 \  
    unzip \  
    chromium-driver \  
    chromium \  
    && apt-get clean && rm -rf /var/lib/apt/lists/*  
  
ENV DISPLAY=:99  
RUN apt-get update && apt-get install -y \  
    xvfb \  
    && apt-get clean && rm -rf /var/lib/apt/lists/*  
  
WORKDIR /app  
  
COPY Gemfile Gemfile.lock ./  
  
RUN bundle install  
  
COPY . .  
  
CMD ["rspec", "tests/simple_practice_test.rb"]