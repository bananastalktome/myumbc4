# config/initializers/attribute_normalizer.rb
AttributeNormalizer.configure do |config|
  # 
  # config.normalizers[:currency] = lambda do |value, options|
  #   value.is_a?(String) ? value.gsub(/[^0-9\.]+/, '') : value
  # end
  # 
  # config.normalizers[:truncate] = lambda do |text, options|
  #   if text.is_a?(String)
  #     options.reverse_merge!(:length => 30, :omission => "...")
  #     l = options[:length] - options[:omission].mb_chars.length
  #     chars = text.mb_chars
  #     (chars.length > options[:length] ? chars[0...l] + options[:omission] : text).to_s
  #   else
  #     text
  #   end
  # end
  
  # Remove whitespace, but not line breaks
  config.normalizers[:whitespace] = lambda do |value, options|
    value.is_a?(String) ? value.strip.gsub(/[^\S\n]+/, ' ') : value
  end

  config.normalizers[:true_or_nil] = lambda do |value, options|
    if value == true
      true
    else
      nil
    end
  end
  
  config.normalizers[:slugify] = lambda do |value, options|
    Utils::Slugger.slugify(value)
  end
  
  config.normalizers[:uniq] = lambda do |value, options|
    value.uniq if value.respond_to?(:uniq)
  end

  # The default normalizers if no :with option or block is given is to apply the :strip and :blank normalizers (in that order).
  # You can change this if you would like as follows:
  # config.default_normalizers = :blank, :strip

  # You can enable the attribute normalizers automatically if the specified attributes exist in your column_names. It will use
  # the default normalizers for each attribute (e.g. config.default_normalizers)
  # config.default_attributes = :name, :title

  # Also, You can add a specific attribute to default_attributes using one or more normalizers:
  # config.add_default_attribute :name, :with => :truncate
end