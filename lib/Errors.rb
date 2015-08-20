def DEFAULT_ERROR
  {
    "error" => "not_found",
    "reason" => "missing"
  }
end

def NOT_VALID_KEY_ERROR(key)
  {
    "error" => "not_valid",
    "reson" => "'#{key}' is not a valid key"
  }
end
