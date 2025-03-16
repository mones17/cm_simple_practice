require 'selenium-webdriver'  
require 'rspec'  
require_relative '../page_objects/login_page'  
require_relative '../page_objects/home_page'  
require_relative '../page_objects/clients_page'  
require_relative '../data/simple_practice_data'  
  
RSpec.describe 'simple_practice_test' do  
  before(:each) do  
    options = Selenium::WebDriver::Chrome::Options.new  
    #options.add_argument('headless')  
    options.add_argument('no-sandbox')  
    options.add_argument('disable-dev-shm-usage')  
      
    @driver = Selenium::WebDriver.for :chrome, options: options  
    @driver.navigate.to 'https://secure.simplepractice.com'  
    @driver.manage.window.maximize  
    @driver.manage.timeouts.implicit_wait = 30  
  end  
  
  after(:each) do  
    @driver.quit  
  end  
  
  it 'executes the simple test' do  
    test_data = SimplePracticeData.valid_user.first  # Obtener el primer elemento del arreglo  
    simple_user = test_data[:user]  # Acceder al usuario  
    client = test_data[:client]  # Acceder al cliente  
  
    login_page = LoginPage.new(@driver)  
    login_page.login(simple_user)  
  
    home_page = HomePage.new(@driver)  
    home_page.create_client  
    home_page.fill_client_details(client)  
    home_page.navigate_to_clients_page  
  
    clients_page = ClientsPage.new(@driver)  
    clients_page.search_client_by_name("#{client.first_name} #{client.last_name}")  
  end  
end  