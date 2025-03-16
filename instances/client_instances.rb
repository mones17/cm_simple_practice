require_relative '../models/client'    
require_relative '../models/client_contact_details'    
  
class ClientInstances  
  def self.valid_client  
    Client.new.tap do |client|  
      client.client_type = "Adult"  
      client.first_name = "John"  
      client.last_name = "Doe"  
      client.date_of_birth = Date.new(1990, 1, 1)  
      client.prefered_name = "JD"  
      client.client_status = "Active"  
      client.wait_list = false  
      client.location = ""  
      client.phone = [  
        ClientContactDetails.new.tap do |contact|  
          contact.contact = "123-456-7890"  
          contact.type = "Mobile"  
          contact.permission = "Text OK"  
        end,  
        ClientContactDetails.new.tap do |contact|  
          contact.contact = "123-456-7891"  
          contact.type = "Home"  
          contact.permission = "Do not use"  
        end  
      ]  
      client.upcoming_appointments = false
      client.incomplete_documents = false  
      client.cancellations = true  
    end  
  end  
end  