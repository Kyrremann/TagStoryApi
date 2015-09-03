def retrieve_keen_params(params)
  to_keen = {}
  to_keen[:source] = params["source"]
  to_keen[:update] = params["update"]
  to_keen[:language] = params["language"]
  to_keen[:android_version] = params["android_version"]
  to_keen[:app_version_name] = params["app_version_name"]
  to_keen[:app_version_code] = params["app_version_code"]
  to_keen[:country] = params["country"]
  to_keen.delete_if { | k, v | v.nil? }
  to_keen
end
