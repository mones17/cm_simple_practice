require_relative '../instances/user_instances'
require_relative '../instances/client_instances'  
  
class SimplePracticeData
  def self.valid_user
    [
      {
        user: UserInstances::valid_user,  
        client: ClientInstances::valid_client,  
        name: "SimpleTest",  
        description: "This is the test for Simple Practice interview."  
      }
    ]
  end
end