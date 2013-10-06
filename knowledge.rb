class Module
    def attribute att
        attr_accessor att
        define_method(att.to_s + "?") do
            if send(att) 
                true
            else
                false
            end
        end
    end
end
=begin
class C
 attribute :a
end

o = C::new
p o.a?      # query - true if @a
p o.a = 42  # setter - sets @a
p o.a       # getter - gets @a 
p o.a?      # query - true if @a
=end