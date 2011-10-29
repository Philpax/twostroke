module Twostroke::Runtime
  Lib.register do |scope|
    obj = Types::StringObject.constructor_function
    scope.set_var "String", obj
    
    proto = Types::Object.new
    proto.put "toString", Types::Function.new(->(scope, this, args) { this.is_a?(Types::StringObject) ? Types::String.new(this.string) : raise("TypeError: @TODO") }, nil, "toString", [])
    proto.put "valueOf", Types::Function.new(->(scope, this, args) { this.is_a?(Types::StringObject) ? Types::String.new(this.string) : Types.to_primitive(this) }, nil, "valueOf", [])
    obj.put "prototype", proto
    
    obj.put "fromCharCode", Types::Function.new(->(scope, this, args) {
      Types::String.new args.map { |a| Types.to_number(a).number.to_i.chr }.join
    }, nil, "fromCharCode", [])
  end
end