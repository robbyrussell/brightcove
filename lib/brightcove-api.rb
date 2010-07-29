require 'httparty'

module Brightcove
  class API
    include HTTParty
    
    VERSION = '1.0.0'.freeze
    
    DEFAULT_HEADERS = {
      'User-Agent' => "brightcove-api gem #{VERSION}"
    }
        
    API_URL = 'http://api.brightcove.com/services/library'
        
    # Brightcove returns text/html as the Content-Type for a response even though the response is JSON.
    # So, let's just parse the response as JSON
    format(:json)
    
    # Initialize with your API token  
    def initialize(token, api_url = API_URL)
      @token = token
      @api_url = api_url
    end
    
    def debug(location = $stderr)
      self.class.debug_output(location)
    end
    
    # Call Brightcove using a particular API method, api_method. The options hash is where you can add any parameters appropriate for the API call.
    def get(api_method, options = {})
      options.merge!({:command => api_method})
      options.merge!({:token => @token})

      query = {}
      query.merge!({:query => options})
            
      self.class.get(@api_url, query)
    end    
  end
end