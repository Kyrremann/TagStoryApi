Api.route('v1') do | r |

  # /stories branch
  r.on 'stories' do
    response['Content-Type'] = "application/json; charset=utf-8"

    r.get ':id/:key' do | id, key |
      http = Keen.publish_async("story_key", { :source => r.params["source"], :story_id => id, :key => key})
      get_key_from_story(id, key).to_json
    end

    r.get ':id' do | id |
      http = Keen.publish_async("story", { :source => r.params["source"], :story_id => id, :update => r.params["update"] })
      get_story(id).to_json
    end

    # GET /stories
    r.get do
      http = Keen.publish_async("list_stories", { :source => r.params["source"] })
      get_stories.to_json
    end
  end

  r.on "statistics" do
    response['Content-Type'] = "application/json; charset=utf-8"

    r.get ':user' do | user |
    end

    r.get do
    end
  end
end
