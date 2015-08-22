unless CLOUDANT_URL = ENV['CLOUDANT_URL']
  raise "You must specify the CLOUDANT_URL env variable"
end

unless KEEN_PROJECT_ID = ENV['KEEN_PROJECT_ID']
  raise "You must specify the KEEN_PROJECT_ID env variable"
end

unless KEEN_WRITE_KEY = ENV['KEEN_WRITE_KEY']
  raise "You must specify the KEEN_WRITE_KEY env variable"
end

unless KEEN_API_URL = ENV['KEEN_API_URL']
  raise "You must specify the KEEN_API_URL env variable"
end
