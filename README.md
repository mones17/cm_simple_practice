# Project of Automation with Selenium
  
This Project is a practice of automation using Selenium with Ruby and ChromeDriver.
  
## Requirements
  
- [Docker](https://www.docker.com/get-started) installed on your machine.
- You should have docker and docker-container.
  
## Build Docker image
  
To build the Docker image, run the following command in the root directory of the project (where the Dockerfile is located):
  
```bash  
docker-compose up --build
```

To run it in the second plane, use the following command:
  
Preferebly, run the following command:

```bash
docker-compose up --build -d
```

Run this to manage the dependencies of the gems in the Ruby application.

```bash
docker-compose run test bundle install
```

Run the test: *It does't matter if the container is marked as 'Exited'*

```bash
rspec tests/simple_practice_test.rb
```
