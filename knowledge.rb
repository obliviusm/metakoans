class Module
    def attribute att, &block
        att_val = nil
        if att.is_a? Hash
            att_val = att.first[1]
            att = att.first[0]
        end
        
        define_method(att+"=") do |value|
            instance_variable_set("@#{att}", value)
        end

        define_method(att) do
            attr = instance_variable_get("@#{att}")
            if !instance_variables.include? "@#{att}".to_sym 
                attr ||= instance_eval &block if block_given?
                attr ||= att_val
            end
            attr
        end

        define_method(att.to_s+"?") do
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

def at atr
    atr.first[0]
end
p at 'a' => 42
=end