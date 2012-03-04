require 'spec_helper.rb'

describe Hasherizer do

	#############
	# HASH-LIKE #
	#############
	context "When a hash-like object (respond_to?(:to_hash) == true) is passed" do

		it "should return the hash-like object passed" do
			hash = {a: 'a'}
			Hasherizer.to_hash(hash).should equal(hash)
		end

	end

	##############
	# ARRAY-LIKE #
	##############
	context "When an array-like object (respond_to?(:each) == true) is passed" do

		context "When all its elements are hash-like (respond_to?(:to_hash) == true)" do

			it "should return a flat hash (a one level hash) of all hash-like elements" do
				Hasherizer.to_hash([{a: 'a'}, {b: 'b'}]).should == {a: 'a', b: 'b'}
			end

		end

		context "When all its elements contain instance variables" do

			it "should return a hash which keys are the instance variable names and which values are the instance variables values" do
				foo = Foo.new('My title', 9.99)
				bar = Bar.new('Joe Doe')

				Hasherizer.to_hash([foo, bar]).should == {'title' => 'My title', 'price' => 9.99, 'name' => 'Joe Doe'}
			end

		end

		context "When at least one element is neither a hash-like object nor contains instance variables" do

			it "should return the object passed" do
				array1 = [{a: 'a'}, 'not hash-like']
				array2 = [Bar.new('Joe Doe'), 'no instance variables here']
				array3 = [{a: 'a'}, Bar.new('Joe Doe'), 'neither hash-like nor instance variables here']

				Hasherizer.to_hash(array1).should equal(array1)
				Hasherizer.to_hash(array2).should equal(array2)
				Hasherizer.to_hash(array3).should equal(array3)
			end

		end

	end

	####################################
	# NEITHER HASH-LIKE NOR ARRAY-LIKE #
	####################################
	context "When the object passed is neither hash-like nor array-like" do

		context "When the object does not contain any instance variables" do

			it "should return the object passed" do
				string = "just a string"
				Hasherizer.to_hash(string).should equal(string)
			end

		end

		context "When the object contains instance variables NOT containing other objects with instance variables" do

			it "should return all instance variables and their values in hash format" do
				Hasherizer.to_hash(Foo.new('My title', 9.99)).should == {'title' => 'My title', 'price' => 9.99}
			end

		end

		context "When the object contains instance variables containing other objects with instance variables" do

			it "should return all instance variables and their values in a flat hash format" do
				price = Price.new(9.99, 'USD')
				foo 	= Foo.new('My title', price)
				Hasherizer.to_hash(foo).should == {'title' => 'My title', 'amount' => 9.99, 'currency' => 'USD'}
			end

		end

	end

end
