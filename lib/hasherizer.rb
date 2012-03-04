module Hasherizer

  # Extract instance variables names and values into a flat hash no matter how many levels deep your objects are.
  # 
  # @param [Object, #read] -- Object which instance variables are to be converted to a hash.
  # @return [Hash]/[Object] -- A hash or an object.
  def self.to_hash(object)
    # Check if object has hash behavior. Check before :each because hashes also respond to :each.
    if object.respond_to? :to_hash
      object
    # Check if object has array behavior.
    elsif object.respond_to? :each
      # If all elements have hash behavior, return them in a flat hash.
      if object.all? {|element| element.respond_to? :to_hash}
        hash = {}
        object.each {|element| hash.merge! element}
        hash
      # If all elements have instance variables, process each element.
      elsif object.all? {|element| element.instance_variables.size > 0}
        hash = {}
        object.each {|element| hash.merge! to_hash(element)}
        hash
      # Otherwise return the object/value.
      else
        object
      end
    # If no hash nor array, its either an object with instance variables or a value.
    else
      # Get object's instance variables.
      instance_vars = object.instance_variables.collect {|var| var[1..-1]}

      # If no instance variables, return object/value.
      if instance_vars.size.zero?
        object
      # If instance variables, process them.
      else
        hash = {}

        instance_vars.each do |var|
          resp = to_hash(object.instance_eval(var))

          # If instance variable has hash behavior add it to the returned hash values.
          if resp.respond_to? :to_hash
            hash.merge! resp
          # If instance variable does not have hash behavior, create hash entry for the variable name and its value.
          else
            hash.merge! var => resp
          end
        end

        hash
      end
    end
  end

end
