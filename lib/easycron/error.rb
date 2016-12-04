class Easycron::Error < StandardError
  DEFAULT_ERROR_MESSAGE = 'An unexpected error has occurred.'

  attr_reader :response
  attr_reader :code

  def initialize(response = nil)
    @response = response

    if response.nil?
      super DEFAULT_ERROR_MESSAGE
    else
      @code = response.fetch('error', {}).fetch('code', DEFAULT_ERROR_MESSAGE)
      errmsg = response.fetch('error', {}).fetch('message', DEFAULT_ERROR_MESSAGE)
      super errmsg
    end
  end
end
