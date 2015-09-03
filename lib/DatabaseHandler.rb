STORIES_TABLE = 'stories'

def get_story_from_cloudant(id)
  begin
    JSON.parse(RestClient.get("#{CLOUDANT_URL}/#{STORIES_TABLE}/#{id}"))
  rescue RestClient::ResourceNotFound => error
    puts "Could not find story with id '#{id}'"
    puts error
    JSON.parse error.response
  end
end

def get_stories_from_cloudant
  begin
    JSON.parse(RestClient.get("#{CLOUDANT_URL}/#{STORIES_TABLE}/_design/lists/_view/story_header"))
  rescue RestClient::ResourceNotFound => error
    puts "Could not find any stories, is CloudAnt down?"
    puts error
    JSON.parse error.response
  end
end

def save_to_cloudant(json)
  begin
    @respons =  JSON.parse(RestClient.post("#{CLOUDANT_URL}/#{STORIES_TABLE}", json, {:content_type => :json, :accept => :json}))
    puts @respons
  rescue => error
    p error
  end
end
