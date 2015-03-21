STORIES_TABLE = 'stories'

def get_story_from_cloudant(id)
  begin
    JSON.parse(RestClient.get("#{CLOUDANT_URL}/#{STORIES_TABLE}/#{id}"))
  rescue RestClient::ResourceNotFound => error
    puts "Could not find story with id #{id}"
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

def save_story_to_cloudant(story)
  save_to_cloudant(STORIES_TABLE, story.to_json)
end

private
def save_to_cloudant(table, json)
  begin
    @respons =  JSON.parse(RestClient.post("#{CLOUDANT_URL}/#{table}", json, {:content_type => :json, :accept => :json}))
    if @respons["ok"] then
      puts "OK"
      return @respons
    else
      p @respons
      # something bad :\
    end
  rescue => e
    p e # inform someone
  end
end
