require_relative './part_1_solution.rb'
require 'pry'


def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  consolidated_cart = cart 
  new_arr = []
  
  cart.each do |cart_item| 
    if coupons.length > 0 
      found_coupon = coupons.find do |coupon|
        coupon[:item] == cart_item[:item]
      end 
      if found_coupon
        num_uncouponed = cart_item[:count] - found_coupon[:num]
        price_per_unit = (found_coupon[:cost]/found_coupon[:num]).round(2)
        temp = Marshal.load(Marshal.dump(cart_item))
        if num_uncouponed < 1  
          temp[:item] = "#{cart_item[:item]} W/COUPON"
          temp[:price] = price_per_unit
          new_arr << temp   
          cart_item[:count] = 0 #keeping original but setting count 0 
          new_arr << cart_item
        else
          temp2 = Marshal.load(Marshal.dump(cart_item))
          temp[:item] = "#{cart_item[:item]} W/COUPON"
          temp[:price] = price_per_unit
          temp[:count] = found_coupon[:num]
          
          temp2[:count] = num_uncouponed
          new_arr << temp 
          new_arr << temp2
        end 
      else #found_coupon
        new_arr << cart_item
      end 
    else 
      new_arr << cart_item
    end 
  end 
    cart = new_arr
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |cart_item|
    if cart_item[:clearance]
      cart_item[:price] = (cart_item[:price] * 0.80).round(2)
    end 
  end 
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
    consolidated_cart = consolidate_cart(cart)
    applied_coupons = apply_coupons(consolidated_cart, coupons)
    final_cart = apply_clearance(applied_coupons)
    
    total = final_cart.reduce(0) { |sum, cart_item|
      sum + (cart_item[:count] * cart_item[:price])
    }
     
    if total > 100
      total = 0.90 * total
    end  
    total.round(2)
end
