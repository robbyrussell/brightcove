require 'helper'
require 'fakeweb'

class TestBrightcoveApi < Test::Unit::TestCase
  def setup
    FakeWeb.allow_net_connect = false
  end
  
  def teardown
    FakeWeb.allow_net_connect = true
  end
  
  def test_find_all_videos
    FakeWeb.register_uri(:get, 
                         'http://api.brightcove.com/services/library?page_size=5&token=0Z2dtxTdJAxtbZ-d0U7Bhio2V1Rhr5Iafl5FFtDPY8E.&command=find_all_videos', 
                         :body => File.join(File.dirname(__FILE__), 'fakeweb', 'find_all_videos_response.json'), 
                         :content_type => "application/json")
                         
    brightcove = Brightcove::API.new('0Z2dtxTdJAxtbZ-d0U7Bhio2V1Rhr5Iafl5FFtDPY8E.')
    brightcove_response = brightcove.get('find_all_videos', {:page_size => 5})
    
    assert_equal 5, brightcove_response['items'].size
    assert_equal 0, brightcove_response['page_number']
  end
end
