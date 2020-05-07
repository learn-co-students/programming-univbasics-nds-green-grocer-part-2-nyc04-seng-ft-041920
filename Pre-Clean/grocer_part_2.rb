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
      
			# Compare Values and then shove into cart if the return is true.
      if coupon_hash[:item] == cart_hash[:item]
        
        # The cart_hash[:count] needs to be reduced to reflect the coupon_hash count
        if coupon_hash[:num] > cart_hash[:count] # Checks to see if the cart is able to be discounted
          cart_hash[:count] -= coupon_hash[:num]
        else
          cart_hash[:count] = 0
        end

        discounted_price = coupon_hash[:cost] / coupon_hash[:num]    

				# The final array is shoveled specific Key:Values taken from cart_hash
        cart << {:item => "#{cart_hash[:item]} W/COUPON", 
        :price => discounted_price, 
        :clearance => cart_hash[:clearance],
        :count => coupon_hash[:num]
      } #Exp. 1
      
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
  # total_item_price = 0
  # coupon_price = 0
  # clearance_price = 0 
  # consolidate_cart(cart)
  # apply_coupons(cart, coupons)
  # apply_clearance(cart)




### These Pass the Majority of tests
### ======================================

  # # RUN ONLY THIS, VALUES DEVIATE IMMENSELY BUT ONLY 5 ERRORS
  # # Applies Coupon Discount
  # apply_coupons(cart, coupons).each do |coupon_item|
  #   coupon_price += coupon_item[:price]
  # end

  # # RUN ONLY THIS IT GIVES THE CLOSEST VALUES BUT 8 ERRORS
  # apply_clearance(cart).each do |clearance_item|
  #   clearance_price += clearance_item[:price]
  # end

  #   # Returns clearance AOH and then adds reduced value of [:price] to clearance_price
  # apply_clearance(consolidate_cart(cart)).each do |items|
  #   clearance_price += items[:price]
  # end

  # # RUN ONLY THIS IT GIVES THE CLOSEST VALUES BUT 8 ERRORS
  # apply_clearance(apply_coupons(consolidate_cart(cart), coupons)).each do |clearance_item|
  #   clearance_price += clearance_item[:price]
  # end


  # RUN ONLY THIS IT GIVES 2 ERRORS
  apply_clearance(apply_coupons(consolidate_cart(cart), coupons)).each do |item_list|
    # p item_list #Returns full check of entire given cart
    # total_price += item_list[:price] # is only returning minimal amount?????
    # total_price += item_list[:price] + item_list[:count]
    # p item_list[:count].value
    # puts "HI"
    # total_price += item_list[:price] + item_list[:count] # returns 75.3? should be returning  ≈130
    # total_price += item_list[:price] * item_list[:count] # Returns 38.4 wat even
    total_price += item_list[:price] * item_list[:count] # returns 12? should be returning 130
  end

  # final_price = total_item_price #+ coupon_price + clearance_price

  # Checks to see if the value of final_price is greater than 100 then applies 10% discount.
  if total_price > 100 
    total_price -= (10 * total_price) / 100
  end

  return total_price
end

p checkout(grocer_cart, grocer_coupons)