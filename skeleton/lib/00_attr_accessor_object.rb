class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      define_method(name) do
        puts "defining the getter"
        self.instance_variable_get("@#{name}")
      end

      define_method("#{name}=") do |val|
        puts "defining the setter"
        self.instance_variable_set("@#{name}", val)
      end
    end
  end
end
