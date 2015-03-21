require_relative 'DatabaseHandler.rb'

def get_stories
  result = get_stories_from_cloudant
  unless result.has_key? 'error'
    return result['rows']
  end

  result
end

def get_story(id)
  result = get_story_from_cloudant id
  unless result.has_key? 'error'
    return result['story']
  end
  
  result
end

def get_key_from_story(id, key)
  result = get_story id
  unless result.has_key? 'error'
    return result[key] || DEFAULT_ERROR
  end
  
  result
end
