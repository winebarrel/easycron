# see https://www.easycron.com/document
class Easycron::Client
  ENDPOINT = 'https://www.easycron.com'
  USER_AGENT = "EasyCron API Ruby Cient/#{Easycron::VERSION}"

  DEFAULT_ADAPTERS = [
    Faraday::Adapter::NetHttp,
    Faraday::Adapter::Test
  ]

  def initialize(token: , **options)
    raise ArgumentError, ':token is required.' if token.nil?

    @token = token
    @options = {
      url: ENDPOINT,
    }.merge(options)

    @conn = Faraday.new(@options) do |faraday|
      faraday.request  :url_encoded
      faraday.response :json # content-type: text/html
      faraday.response :raise_error

      yield(faraday) if block_given?

      unless DEFAULT_ADAPTERS.any? {|i| faraday.builder.handlers.include?(i) }
        faraday.adapter Faraday.default_adapter
      end
    end

    @conn.headers[:user_agent] = USER_AGENT
  end

  def list(page: nil, size: nil, sortby: nil, order: nil)
    request(:list,
      page: page,
      size: size,
      sortby: sortby,
      order: order,
    )
  end

  def add(cron_job_name: nil, cron_expression:, url: , email_me: , log_output_length: , cookies: nil, posts: nil, via_tor: nil)
    request(:add,
      cron_job_name: cron_job_name,
      cron_expression: cron_expression,
      url: url,
      email_me: email_me,
      log_output_length: log_output_length,
      cookies: cookies,
      posts: posts,
      via_tor: via_tor,
    )
  end

  def detail(id: )
    request(:detail, id: id)
  end

  def edit(id: ,cron_job_name: nil, cron_expression:, url: , email_me: , log_output_length: , cookies: nil, posts: nil, via_tor: nil)
    request(:edit,
      id: id,
      cron_job_name: cron_job_name,
      cron_expression: cron_expression,
      url: url,
      email_me: email_me,
      log_output_length: log_output_length,
      cookies: cookies,
      posts: posts,
      via_tor: via_tor,
    )
  end

  def enable(id: )
    request(:enable, id: id)
  end

  def disable(id: )
    request(:disable, id: id)
  end

  def delete(id: )
    request(:delete, id: id)
  end

  def logs(id: )
    request(:logs, id: id)
  end

  def timezone
    request(:timezone)
  end

  private

  def request(method_name, params = {})
    params = params.merge(token: @token)
    params.reject! {|k, v| v.nil? }

    response = @conn.get do |req|
      req.url "/rest/#{method_name}"
      req.params = params
      yield(req) if block_given?
    end

    json = response.body
    validate_response!(json)
    json
  end

  def validate_response!(json)
    if json.nil?
      raise Easycron::Error
    elsif json['status'] == 'error'
      raise Easycron::Error, json
    end
  end
end
