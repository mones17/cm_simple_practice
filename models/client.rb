require 'date'  
  
class Client  
  attr_accessor :client_type, :first_name, :last_name, :date_of_birth,  
                :prefered_name, :refered_by, :client_status, :wait_list,  
                :location, :email, :phone, :upcoming_appointments,  
                :incomplete_documents, :cancellations  
  
  def initialize  
    @client_type = ''  
    @first_name = ''  
    @last_name = ''  
    @date_of_birth = Date.new
    @prefered_name = ''  
    @refered_by = ''  
    @client_status = ''  
    @wait_list = false  
    @location = ''  
    @email = []
    @phone = []  
    @upcoming_appointments = false  
    @incomplete_documents = false  
    @cancellations = false  
  end  
end  