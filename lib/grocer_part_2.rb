require_relative './part_1_solution.rb'

def apply_coupons(cart,coupon)
  coupons_applied = []
  or_count = 0
  cp_name = nil
  cart.each do |val|
    coupon.each do |cp|
      if val.has_value?(cp[:item]) && cp[:num] > 0 
         item = Marshal.load(Marshal.dump(val))
        # subtract cp from items in cart
        val[:count] = val[:count] - cp[:num]
      #   # new name for items
        cp_name = val[:item] +' '+ 'W/COUPON' 
        item[:count]= cp[:num]
        item[:price] = cp[:cost] / cp[:num]
        item[:item] = cp_name
        cart << item 
        cp[:num] = 0 
      end
    end
  end
  cart
  end
# apply_coupons(shelf,special)


def apply_clearance(arr) 
  arr.map {|val| 
  # p val 
  if (val[:clearance])
    percentage = (val[:price] / 100) * 20 
    discount = val[:price] - percentage
  if percentage != nil 
    val[:price] = discount
  end 
end
}
deals = arr
deals
end

def checkout(shelf, special)
  total =0
  new_cart = consolidate_cart(shelf)
  # p cart
  new_cart = apply_coupons(new_cart,special)
  # cart
  new_cart = apply_clearance(new_cart)
  
  new_cart.each {|item| total += item[:price] * item[:count]}
  total 
  if total > 100
  xdiscount = total / 100 * 10
  total = total - xdiscount
  end
  total
  end