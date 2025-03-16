require 'selenium-webdriver'  
require 'rspec'  
  
class ClientsPage  
  def initialize(driver)  
    @driver = driver  
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)  
  end  
  
  def clients_contacts_header  
    @driver.find_element(xpath: "//h1[text()='Clients and contacts']")  
  end  
  
  def search_input  
    @driver.find_element(class: 'utility-search')  
  end  
  
  def search_client_by_name(client_name)  
    @wait.until { clients_contacts_header.displayed? && clients_contacts_header.enabled? }  
    is_client_and_contacts_page_displayed = clients_contacts_header.displayed?  
    RSpec::Expectations.fail_with("Clients & Contacts page is displayed") unless is_client_and_contacts_page_displayed  
  
    search_input.send_keys(client_name)  
    search_input.send_keys(:enter)  
  
    client_name_text = @driver.find_element(xpath: "//div/a[text()='#{client_name}']")  
    is_client_name_displayed = client_name_text.displayed?  
    RSpec::Expectations.fail_with("Client name is displayed on client list.") unless is_client_name_displayed  
  end  
end  