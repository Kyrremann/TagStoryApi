require_relative 'DatabaseHandler.rb'

def get_stories
  result = get_stories_from_cloudant
  if result.has_key? 'error'
    result
  else
    result['rows']
  end
end

def get_story(id)
  result = get_story_from_cloudant id
  if result.has_key? 'error'
    result
  else
    story = clean_story(result['story'])
    unless story['UUID'] == result['_id']
      p 'Another story upgraded'
      story['UUID'] = result['_id']
      result['story'] = story
      save_to_cloudant(result.to_json)
    end
    return story
  end
end

def get_key_from_story(id, key)
  return NOT_VALID_KEY_ERROR(key) unless valid_key?(key)

  result = get_story id
  if result.has_key? 'error'
    result
  else
    result[key] || DEFAULT_ERROR
  end
end

private

VALID_KEYS = [ 'version' ]
def valid_key?(key)
  VALID_KEYS.include?(key)
end

def clean_story(story)
  story.delete("editors")
  story
end
