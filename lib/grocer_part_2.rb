require_relative './part_1_solution.rb'

grocer_cart = 
	[
		{:item => "AVOCADO", :price => 3.00, :clearance => true},
		{:item => "AVOCADO", :price => 3.00, :clearance => true},
		{:item => "AVOCADO", :price => 3.00, :clearance => true},
		{:item => "KALE", :price => 3.00, :clearance => false},
		{:item => "BLACK_BEANS", :price => 2.50, :clearance => false},
		{:item => "ALMONDS", :price => 9.00, :clearance => false},
		{:item => "TEMPEH", :price => 3.00, :clearance => true},
		{:item => "CHEESE", :price => 6.50, :clearance => false},
		{:item => "BEER", :price => 13.00, :clearance => false},
		{:item => "PEANUTBUTTER", :price => 3.00, :clearance => true},
		{:item => "BEETS", :price => 2.50, :clearance => false},
		{:item => "SOY MILK", :price => 4.50, :clearance => true}
	]

# test_cart = [{:item => "BEETS", :price => 2.50, :clearance => false}]

grocer_coupons =
	[
		{:item => "AVOCADO", :num => 2, :cost => 5.00},
		{:item => "BEER", :num => 2, :cost => 20.00},
		{:item => "CHEESE", :num => 3, :cost => 15.00}
	]
def apply_coupons(cart, coupons)

	# Check the entire cart Array for hashes
  cart.each do |cart_hash|
    
		# Check the entire coupons array for hashes
    coupons.each do |coupon_hash|

      # p find_item_by_name_in_collection(coupon_hash[:item], cart)

			# Compare Values and then shove into cart if the return is true.
      if coupon_hash[:item] == cart_hash[:item] 

        # The cart_hash[:count] needs to be reduced to reflect the coupon_hash count
        if cart_hash[:count] >= coupon_hash[:num]# Checks to see if the cart is able to be discounted
           
          discounted_price = coupon_hash[:cost] / coupon_hash[:num]    

          cart_hash[:count] -= coupon_hash[:num] # Sets the final value of each items count
   
          # The final array is shoveled specific Key:Values taken from cart_hash
          cart << {
            :item => "#{cart_hash[:item]} W/COUPON", 
            :price => discounted_price, 
            :clearance => cart_hash[:clearance],
            :count => coupon_hash[:num]
          }
        else
          cart_hash[:count] = 1 # If !(cart_hash[:count] >= coupon_hash[:num]) then set cart_hash[:count] to 0
        end
      
      end 
		end	
  end
  
  return cart 
end

def apply_clearance(cart)
	# Check the entire cart Array for hashes
	cart.each do |cart_hash|
		# if cart_hash[:clearance] returns true then apply the percentage reduction
    if cart_hash[:clearance] == true
      cart_hash[:price] -= (20 * cart_hash[:price]) / 100
		end
  end
  
  # return cart
end # Exp. 2

def checkout(cart, coupons)
  total_price = 0
  # p apply_clearance(apply_coupons(consolidate_cart(cart), coupons))

  # Runs all of the methods, and does a check for each
  apply_clearance(apply_coupons(consolidate_cart(cart), coupons)).each do |item_list|
    # I need to iterate over the amount of items and then for each price add it into the var total_price
    item_list.each do |k, v|
      if k == :count
        total_price += item_list[:price] * v
      end
    end
    # p total_price.floor(2)
  end
  
  # Checks to see if the value of final_price is greater than 100 then applies 10% discount.
  if total_price > 100 
    total_price -= (10 * total_price) / 100
  end

  return total_price.floor(2)
end

p checkout(grocer_cart, grocer_coupons)


# So the problem is that when beer comes up it has a :cost value of 13, it's coupons set it to have a cost value of 10.
# However when the cost value comes up the beer without the coupon is not being added to the total why???


# I'm fucking stupid I was setting the :count values to 0
