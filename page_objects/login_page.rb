require 'selenium-webdriver'  
require 'rspec'  
require_relative '../models/user'
  
class LoginPage
  def initialize(driver)
    @driver = driver  
  end  
  
  def username_text_box  
    @driver.find_element(:id, "user_email")  
  end  
  
  def password_text_box  
    @driver.find_element(:id, "user_password")  
  end  
  
  def login_submit  
    @driver.find_element(:id, "submitBtn")  
  end  
  
  def index_header_container  
    @driver.find_element(:id, "submitBtn")
  end  
  
  def login(user)  
    wait = Selenium::WebDriver::Wait.new(timeout: 10)
      
    username_text_box.clear  
    username_text_box.send_keys(user.username)  
  
    password_text_box.clear  
    password_text_box.send_keys(user.password)  
  
    wait.until { login_submit.displayed? && login_submit.enabled? }  
    login_submit.click  
  
    wait.until { index_header_container.displayed? }  
  
    is_login_successful = index_header_container.displayed?  
    raise "Login was not successful" unless is_login_successful  
  end  
end  