def retrieve_keen_params(params)
  to_keen = {}
  to_keen[:source] = params["source"]
  to_keen[:update] = params["update"]
  to_keen[:language] = params["language"]
  to_keen[:android_version] = params["android_version"]
  to_keen[:app_version] = params["app_version"]
  to_keen.delete_if { | k, v | v.nil? }
  to_keen
end
