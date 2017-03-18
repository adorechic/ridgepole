include ERBh

ERBh.define_method(:i) do |obj|
  if obj.nil? or (obj.respond_to?(:empty?) and obj.empty?)
    @_erbout.sub!(/,\s*\z/, '')
    ''
  else
    obj.modern_inspect_without_brace
  end
end

ERBh.define_method(:add_index) do |table_name, column_name, options|
  if options[:length].is_a?(Hash)
    options[:length] = options[:length].symbolize_keys
  end

  @_erbout.sub!(/\bend\s*\z/, '')

  <<-EOS
      t.index #{column_name.inspect}, #{options.modern_inspect_without_brace}
    end
  EOS
end

ERBh.define_method(:unsigned) do |value, *conds|
  if condition(*conds)
    {unsigned: value}
  else
    {}
  end
end

ERBh.define_method(:limit) do |value, *conds|
  if condition(*conds)
    {limit: value}
  else
    {}
  end
end
