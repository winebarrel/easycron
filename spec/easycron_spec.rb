require 'spec_helper'

describe Easycron::Client do
  let(:token) { 'b6ab1e77ed71a29f76496770aeb38de3' }
  let(:query_string) { '' }

  subject do
    stubs = Faraday::Adapter::Test::Stubs.new
    params = CGI.parse(query_string)
    symbolized_params = params.map {|k, v| [k.to_sym, v] }.to_h

    client = described_class.new(token: token) {|faraday|
      faraday.adapter :test, stubs do |stub|
        stub.get("/rest/#{method_name}") do |env|
          expect(env.params).to eq params.merge('token' => token)
          [200, {'Content-Type' => 'text/html'}, response]
        end
      end
    }

    if params.empty?
      client.send(method_name)
    else
      client.send(method_name, **symbolized_params)
    end
  end

  context 'when success' do
    # https://www.easycron.com/document/list
    describe '#list' do
      let(:method_name) { :list }

      let(:query_string) do
        'sortby=cronId&order=desc'
      end

      let(:response) do
        '{"status":"success","cron_jobs":[{"cron_job_id":"2107","cron_job_name":"Read feeds","user_id":"1","url":"http:\/\/www.domain.com\/readfeeds","cron_expression":"15 1 * * *","number_failed_time":"0","engine_occupied":"2","log_output_length":"10240","email_me":"2","status":"0","created":"2012-03-19 17:04:18","updated":"2012-08-11 14:25:23"},{"cron_job_id":"1807","cron_job_name":"Backup database","user_id":"1","url":"http:\/\/example.com\/cron\/backupdatabase","cron_expression":"55 23 * * *","number_failed_time":"0","coin_occupied":"2","log_output_length":"0","email_me":"0","status":"0","created":"2012-01-31 10:07:48","updated":"2012-07-19 05:42:32"},{"cron_job_id":"1604","cron_job_name":"Send newsletters","user_id":"1","url":"http:\/\/www.domain.com\/sendmails","cron_expression":"* * * * *","number_failed_time":"0","coin_occupied":"536","log_output_length":"0","email_me":"0","status":"0","created":"2011-12-31 20:43:13","updated":"2012-08-11 14:25:55"}]}'
      end

      it { is_expected.to eq JSON.parse(response) }
    end

    # https://www.easycron.com/document/add
    describe '#add' do
      let(:method_name) { :add }

      let(:query_string) do
        'cron_expression=* * * * *&url=http%3A%2F%2Fwww.domain.com%2Fsendemails&email_me=2&log_output_length=10240&via_tor=1'
      end

      let(:response) do
        '{"status":"success","cron_jobs":[{"cron_job_id":"2107","cron_job_name":"Read feeds","user_id":"1","url":"http:\/\/www.domain.com\/readfeeds","cron_expression":"15 1 * * *","number_failed_time":"0","engine_occupied":"2","log_output_length":"10240","email_me":"2","status":"0","created":"2012-03-19 17:04:18","updated":"2012-08-11 14:25:23"},{"cron_job_id":"1807","cron_job_name":"Backup database","user_id":"1","url":"http:\/\/example.com\/cron\/backupdatabase","cron_expression":"55 23 * * *","number_failed_time":"0","coin_occupied":"2","log_output_length":"0","email_me":"0","status":"0","created":"2012-01-31 10:07:48","updated":"2012-07-19 05:42:32"},{"cron_job_id":"1604","cron_job_name":"Send newsletters","user_id":"1","url":"http:\/\/www.domain.com\/sendmails","cron_expression":"* * * * *","number_failed_time":"0","coin_occupied":"536","log_output_length":"0","email_me":"0","status":"0","created":"2011-12-31 20:43:13","updated":"2012-08-11 14:25:55"}]}'
      end

      it { is_expected.to eq JSON.parse(response) }
    end

    # https://www.easycron.com/document/add
    describe '#add' do
      let(:method_name) { :add }

      let(:query_string) do
        'cron_expression=* * * * *&url=http%3A%2F%2Fwww.domain.com%2Fsendemails&email_me=2&log_output_length=10240&via_tor=1'
      end

      let(:response) do
        '{"status":"success","cron_jobs":[{"cron_job_id":"2107","cron_job_name":"Read feeds","user_id":"1","url":"http:\/\/www.domain.com\/readfeeds","cron_expression":"15 1 * * *","number_failed_time":"0","engine_occupied":"2","log_output_length":"10240","email_me":"2","status":"0","created":"2012-03-19 17:04:18","updated":"2012-08-11 14:25:23"},{"cron_job_id":"1807","cron_job_name":"Backup database","user_id":"1","url":"http:\/\/example.com\/cron\/backupdatabase","cron_expression":"55 23 * * *","number_failed_time":"0","coin_occupied":"2","log_output_length":"0","email_me":"0","status":"0","created":"2012-01-31 10:07:48","updated":"2012-07-19 05:42:32"},{"cron_job_id":"1604","cron_job_name":"Send newsletters","user_id":"1","url":"http:\/\/www.domain.com\/sendmails","cron_expression":"* * * * *","number_failed_time":"0","coin_occupied":"536","log_output_length":"0","email_me":"0","status":"0","created":"2011-12-31 20:43:13","updated":"2012-08-11 14:25:55"}]}'
      end

      it { is_expected.to eq JSON.parse(response) }
    end

    # https://www.easycron.com/document/detail
    describe '#detail' do
      let(:method_name) { :detail }

      let(:query_string) do
        'id=2107'
      end

      let(:response) do
        '{"status":"success","cron_job":{"cron_job_id":"2107","cron_job_name":"Read feeds","user_id":"1","url":"http:\/\/www.domain.com\/readfeeds","cron_expression":"15 1 * * *","number_failed_time":"0","engine_occupied":"2","log_output_length":"10240","email_me":"2","cookies":"","posts":"","via_tor":"0","status":"0","created":"2012-03-19 17:04:18","updated":"2012-08-11 14:25:23"}}'
      end

      it { is_expected.to eq JSON.parse(response) }
    end

    # https://www.easycron.com/document/edit
    describe '#edit' do
      let(:method_name) { :edit }

      let(:query_string) do
        'id=2107&cron_expression=* * * * *&url=http%3A%2F%2Fwww.domain.com%2Fsendemails&email_me=2&log_output_length=10240&via_tor=1'
      end

      let(:response) do
        '{"status":"success","cron_job_id":"2107"}'
      end

      it { is_expected.to eq JSON.parse(response) }
    end

    # https://www.easycron.com/document/enable
    describe '#enable' do
      let(:method_name) { :enable }

      let(:query_string) do
        'id=2107'
      end

      let(:response) do
        '{"status":"success","cron_job_id":"2107"}'
      end

      it { is_expected.to eq JSON.parse(response) }
    end

    # https://www.easycron.com/document/disable
    describe '#disable' do
      let(:method_name) { :disable }

      let(:query_string) do
        'id=2107'
      end

      let(:response) do
        '{"status":"success","cron_job_id":"2107"}'
      end

      it { is_expected.to eq JSON.parse(response) }
    end

    # https://www.easycron.com/document/logs
    describe '#logs' do
      let(:method_name) { :logs }

      let(:query_string) do
        'id=2107'
      end

      let(:response) do
        '{"status":"success","logs":[{"cron_job_id":"3801","scheduled_time":"2012-08-12 23:28:00","fire_time":"2012-08-12 23:28:03","done_time":"2012-08-12 23:28:03","execute_time":"0.508","http_code":"200","total_time":"0.509","truncated_output":"HTTP\/1.1 200 OK\r\nDate: Sun, 12 Aug 2012 15:28:02 GMT\r\nServer: Apache\/2.2.3 (CentOS)\r\nX-Powered-By: PHP\/5.2.17\r\nSet-Cookie: PHPSESSID=mh61fe968296o56uhmnofsf214; path=\/\r\nExpires: Thu, 19 Nov 1981 08:52:00 GMT\r\nCache-Control: no-store, no-cache, must-revalidate, post-check=0, pre-check=0\r\nPragma: no-cache\r\nVary: Accept-Encoding,User-Agent\r\nTransfer-Encoding: chunked\r\nContent-Type: text\/html; charset=UTF-8\r\n\r\n<!DOCTYPE HTML PUBLIC \"-\/\/W3C\/\/DTD XHTML 1.0 Transitional\/\/EN\" \"http:\/\/www.w3.org\/TR\/xhtml1\/DTD\/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http:\/\/www.w3.org\/1999\/xhtml\">\r\n<head><\/head>\r\n<body>Cron Job Done.\r\n<\/body>\r\n<\/html>"}]}'
      end

      it { is_expected.to eq JSON.parse(response) }
    end

    # https://www.easycron.com/document/timezone
    describe '#timezone' do
      let(:method_name) { :timezone }

      let(:response) do
        '{"status":"success","timezone":"Asia\/Hong_Kong"}'
      end

      it { is_expected.to eq JSON.parse(response) }
    end
  end

  context 'when error' do
    describe '#list' do
      let(:method_name) { :list }

      let(:query_string) do
        'sortby=cronId&order=desc'
      end

      let(:response) do
        '{"status":"error","error":{"code":"1","message":"Wrong API token."}}'
      end

      specify do
        expect { subject }.to raise_error('Wrong API token.')
      end
    end
  end
end
