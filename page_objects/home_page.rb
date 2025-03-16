require 'selenium-webdriver'  
require 'rspec' 
require 'selenium/webdriver/support/select'
  
class HomePage  
  def initialize(driver)  
    @driver = driver  
    @wait = Selenium::WebDriver::Wait.new(timeout: 30)
  end  
  
  def create_button  
    @driver.find_element(:xpath, "//button[contains(@class,'create')]")
  end  
  
  def create_client_button  
    @driver.find_element(:xpath, "//button/text()[contains(., 'Create client')]/..")
  end  
  
  def first_name_input  
    @driver.find_element(:xpath, "//input[contains(@id,'firstName')]")  
  end  
  
  def last_name_input  
    @driver.find_element(:xpath, "//input[contains(@id,'lastName')]")  
  end  
  
  def prefered_name_input  
    @driver.find_element(:id, "nickname")  
  end  
  
  def month_of_birth_dropdown  
    @driver.find_element(:xpath, "//select[@name='month']")  
  end  
  
  def day_of_birth_dropdown  
    @driver.find_element(:xpath, "//select[@name='day']")  
  end  
  
  def year_of_birth_dropdown  
    @driver.find_element(:xpath, "//select[@name='year']")  
  end  
  
  def refered_by_select_box  
    @driver.find_element(:id, "select-box-el-194")  
  end  
  
  def waitlist_checkbox  
    @driver.find_element(:id, "waitlistCheckbox-mask")  
  end  
  
  def client_location_dropdown  
    @driver.find_element(:id, "new-client-office")  
  end  
  
  def add_email_button  
    @driver.find_element(:xpath, "//text()[contains(.,'Add email')]/..")  
  end  
  
  def add_phone_button  
    @driver.find_element(:xpath, "//text()[contains(.,'Add phone')]/..")  
  end  
  
  def continue_button  
    @driver.find_element(:xpath, "//button[contains(text(),'Continue')]")  
  end  
  
  def clients_link_button  
    @driver.find_element(:xpath, "//span[text()='Clients' and @class='link-text']")  
  end  
  
  def create_client  
    @wait.until { create_button.displayed? && create_button.enabled? }  
    raise "Create button not displayed." unless create_button.displayed?  
  
    create_button.click  
  
    @wait.until { create_client_button.displayed? && create_client_button.enabled? }  
    raise "Create client button not displayed." unless create_client_button.displayed?  
  
    create_client_button.click  
  end  

  def select_element(select_element)  
    Selenium::WebDriver::Support::Select.new(select_element)
  end
  
  def set_date_of_birth(date_of_birth)  
    valid_month = Date::MONTHNAMES[date_of_birth.month]  
    select_element(month_of_birth_dropdown).select_by(:text, valid_month)  
    select_element(day_of_birth_dropdown).select_by(:text, date_of_birth.day.to_s)  
    select_element(year_of_birth_dropdown).select_by(:text, date_of_birth.year.to_s)  
  end

  def fill_client_details(client)  
    js = @driver  
    @wait.until { first_name_input.displayed? && first_name_input.enabled? }  
    raise "First Name input not displayed." unless first_name_input.displayed?  
  
    if client.client_type && !client.client_type.empty?  
        client_type_radio_button = @driver.find_element(:xpath, "//label/text()[contains(.,'#{client.client_type}')]/preceding-sibling::input")  
        client_type_radio_button.click  
    end  
  
    first_name_input.clear  
    first_name_input.send_keys(client.first_name)  
  
    last_name_input.clear  
    last_name_input.send_keys(client.last_name)  
  
    if client.prefered_name && !client.prefered_name.empty?  
        prefered_name_input.clear  
        prefered_name_input.send_keys(client.prefered_name)  
    end  
  
    set_date_of_birth(client.date_of_birth)  
  
    if client.refered_by && !client.refered_by.empty?  
        refered_by_select_box.click  
        refered_by_option = @driver.find_element(:xpath, "//div[text()='#{client.refered_by}']")  
        raise "Refered By option not displayed." unless refered_by_option.displayed?  
  
        refered_by_option.click  
    end  
  
    waitlist_checkbox.click if client.wait_list  
  
    if client.client_status && !client.client_status.empty?  
        client_status_radio_button = @driver.find_element(:xpath, "//label/text()[contains(.,'#{client.client_status}')]/preceding-sibling::input")  
        client_status_radio_button.click  
    end  
  
    if client.location && !client.location.empty?  
        select_element(client_location_dropdown).select_by(:text, client.location)  
    end  
  
    js.execute_script("arguments[0].scrollIntoView();", add_phone_button)  
  
    # Adding dynamic emails  
    if client.email 
      client.email.each_with_index do |email, index|  
        @wait.until { add_email_button.displayed? && add_email_button.enabled? }  
        add_email_button.click  
  
        email_input = @driver.find_element(:xpath, "(//input[@name='email'])[#{index + 1}]")  
        @wait.until { email_input.displayed? && email_input.enabled? }  
        email_input.send_keys(email.contact)  
  
        email_type_dropdown = @driver.find_element(:xpath, "((//div[@class='contact-details-section-container']//tbody)[1]//td[2]//button)[#{index + 1}]")  
        js.execute_script("arguments[0].scrollIntoView(true);", email_type_dropdown)  
        @wait.until { email_type_dropdown.displayed? && email_type_dropdown.enabled? }  
        email_type_dropdown.click  
  
        email_type_option = @driver.find_element(:xpath, "//span[text()='#{email.type}']/../parent::div[contains(@class,'item ember-view')]/button")  
        js.execute_script("arguments[0].scrollIntoView(true);", email_type_option)  
        @wait.until { email_type_option.displayed? && email_type_option.enabled? }  
        email_type_option.click  
  
        email_permission_dropdown = @driver.find_element(:xpath, "((//div[@class='contact-details-section-container']//tbody)[1]//td[3]//button)[#{index + 1}]")  
        js.execute_script("arguments[0].scrollIntoView(true);", email_permission_dropdown)  
        @wait.until { email_permission_dropdown.displayed? && email_permission_dropdown.enabled? }  
        email_permission_dropdown.click  
  
        email_permission_option = @driver.find_element(:xpath, "//span[text()='#{email.permission}']/../parent::div[contains(@class,'item ember-view')]/button")  
        js.execute_script("arguments[0].scrollIntoView(true);", email_permission_option)  
        @wait.until { email_permission_option.displayed? && email_permission_option.enabled? }  
        email_permission_option.click  
      end  
    end    
  
    # Adding dynamic phones  
    if client.phone  
      client.phone.each_with_index do |phone, index|  
        @wait.until { add_phone_button.displayed? && add_phone_button.enabled? }  
        add_phone_button.click  
  
        phone_input = @driver.find_element(:xpath, "(//input[@name='phone'])[#{index + 1}]")  
        @wait.until { phone_input.displayed? && phone_input.enabled? }  
        phone_input.send_keys(phone.contact)  
  
        phone_type_dropdown = @driver.find_element(:xpath, "((//div[@class='contact-details-section-container']//tbody)[2]//td[2]//button)[#{index + 1}]")  
        js.execute_script("arguments[0].scrollIntoView(true);", phone_type_dropdown)  
        @wait.until { phone_type_dropdown.displayed? && phone_type_dropdown.enabled? }  
        phone_type_dropdown.click  
  
        phone_type_option = @driver.find_element(:xpath, "//span[text()='#{phone.type}']/../parent::div[contains(@class,'item ember-view')]/button")  
        js.execute_script("arguments[0].scrollIntoView(true);", phone_type_option)  
        @wait.until { phone_type_option.displayed? && phone_type_option.enabled? }  
        sleep(2)
        phone_type_option.click  
  
        phone_permission_dropdown = @driver.find_element(:xpath, "((//div[@class='contact-details-section-container']//tbody)[2]//td[3]//button)[#{index + 1}]")  
        js.execute_script("arguments[0].scrollIntoView(true);", phone_permission_dropdown)  
        @wait.until { phone_permission_dropdown.displayed? && phone_permission_dropdown.enabled? }  
        phone_permission_dropdown.click  
  
        phone_permission_option = @driver.find_element(:xpath, "//span[text()='#{phone.permission}']/../parent::div[contains(@class,'item ember-view')]/button")  
        js.execute_script("arguments[0].scrollIntoView(true);", phone_permission_option)  
        @wait.until { phone_permission_option.displayed? && phone_permission_option.enabled? }  
        phone_permission_option.click  
      end  
    end  
  
    # Creation of dynamic elements instead of using 3 different elements just for 1 word difference  
    reminder_options = "//span[text()='?']/../preceding-sibling::div/span"  
  
    if client.upcoming_appointments  
        upcoming_appointments_toggle_button = @driver.find_element(:xpath, reminder_options.gsub("?", "Upcoming appointments"))  
        js.execute_script("arguments[0].scrollIntoView();", upcoming_appointments_toggle_button)  
        upcoming_appointments_toggle_button.click  
    end  
  
    if client.incomplete_documents  
        incomplete_documents_toggle_button = @driver.find_element(:xpath, reminder_options.gsub("?", "Incomplete documents"))  
        js.execute_script("arguments[0].scrollIntoView();", incomplete_documents_toggle_button)  
        incomplete_documents_toggle_button.click  
    end  
  
    if client.cancellations  
        cancellations_toggle_button = @driver.find_element(:xpath, reminder_options.gsub("?", "Cancellations"))  
        js.execute_script("arguments[0].scrollIntoView();", cancellations_toggle_button)  
        cancellations_toggle_button.click  
    end  
  
    continue_button.click  
  end

  def navigate_to_clients_page  
    @wait.until { clients_link_button.displayed? && clients_link_button.enabled? }  
    raise "Clients link button not displayed." unless clients_link_button.displayed?  
  
    clients_link_button.click  
  end
end