class Easycron::Error < StandardError
  DEFAULT_ERROR_MESSAGE = 'An unexpected error has occurred.'

  attr_reader :response

  def initialize(response = nil)
    @response = response

    if response.nil?
      super DEFAULT_ERROR_MESSAGE
    else
      errmsg = response.fetch('error', {}).fetch('message', DEFAULT_ERROR_MESSAGE)
      super errmsg
    end
  end
end
