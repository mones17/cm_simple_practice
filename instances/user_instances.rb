require_relative '../models/user'    
  
class UserInstances  
  def self.valid_user 
    User.new.tap do |user|  
      user.username = "somab63683@lewenbo.com"  
      user.password = "GoodLuck777"  
    end  
  end  
end  