# Easycron

[EasyCron](https://www.easycron.com/) API Ruby Client.

[![Build Status](https://travis-ci.org/winebarrel/easycron.svg?branch=master)](https://travis-ci.org/winebarrel/easycron)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'easycron'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easycron

## Usage

```ruby
require 'uptimerobot'
require 'pp'

client = Easycron::Client.new(token: '...')

pp client.list
#=> {"status"=>"success",
#    "cron_jobs"=>
#     [{"cron_job_id"=>"123456",
#       "cron_job_name"=>"",
#       "user_id"=>"12345",
#       "url"=>"http://example.com",
#       "cron_expression"=>"* * * * *",
#       "number_failed_time"=>"0",
#       "engine_occupied"=>"1",
#       "log_output_length"=>"0",
#       "email_me"=>"0",
#       "status"=>"1",
#       "created"=>"2010-02-03 04:05:06",
#       "updated"=>"2010-02-03 04:05:06"},
#       ...

response = client.add(
  cron_expression: '0 0 * * *',
  url: 'http://example.com',
  email_me: 0,
  log_output_length: 0)

cron_job_id = response['cron_job_id']

response = client.edit(
  cron_expression: '*/5 * * * *',
  url: 'http://www.example.com',
  email_me: 0,
  log_output_length: 0)
```

## API Reference

- [API Document - EasyCron.com](https://www.easycron.com/document/)
