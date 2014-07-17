class Hash

  # Converts all of the keys to strings, optionally formatting key name
  def underscore_keys!
    keys.each{|k|
      v = delete(k)
      new_key = k.to_s.underscore
      self[new_key] = v
      v.underscore_keys! if v.is_a?(Hash)
      v.each{|p| p.underscore_keys! if p.is_a?(Hash)} if v.is_a?(Array)
    }
    self
  end

  def camelize_keys!
    keys.each{|k|
      v = delete(k)
      new_key = k.to_s.camelize(:lower)
      self[new_key] = v
      v.camelize_keys! if v.is_a?(Hash)
      v.each{|p| p.camelize_keys! if p.is_a?(Hash)} if v.is_a?(Array)
    }
    self
  end

end