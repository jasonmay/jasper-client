require 'helper'

class TestJasperClient < Test::Unit::TestCase
  def setup_connection
    wsdl = 'http://127.0.0.1:8080/jasperserver/services/repository?wsdl'
    user = 'jasperadmin'
    pass = user
    JasperClient::RepositoryService.new(wsdl, user, pass) rescue nil
  end
  
  def bad_connection
    wsdl = 'http://127.0.0.1:8081/jasperserver/services/repository?wsdl'
    user = 'jasperadmin'
    pass = user
    JasperClient::RepositoryService.new(wsdl, user, pass)
  end
  
  should "respond to list requests" do 
    client = setup_connection
    omit_if(client.nil?, "This test requires a Jasper server running on localhost:8080")
    response = client.list do |request|
      request.argument :name => "LIST_RESOURCES"
      request.argument 'reportUnit', :name => "RESOURCE_TYPE"
      request.argument '/Reports/xforty', :name => 'START_FROM_DIRECTORY'
    end

    assert(response.return_code == "0")
  end
  
  should "respond to get requests" do
    client = setup_connection
    omit_if(client.nil?, "This test requires a Jasper server running on localhost:8080")
    response = client.get do |req|
      req.resourceDescriptor :name => 'jrlogo', :wsType => 'img', :uriString => '/Reports/xforty/user_list', :isNew => 'false'
    end
    assert(response.return_code == "0")
  end

  should "respond to runReport requests" do
    client = setup_connection
    omit_if(client.nil?, "This test requires a Jasper server running on localhost:8080")
    response = client.run_report do |req|
      req.argument 'HTML', :name => 'RUN_OUTPUT_FORMAT'
  
      req.resourceDescriptor :name => 'JRLogo', 
        :wsType => 'img', 
        :uriString => '/reports/xforty/user_list', 
        :isNew => 'false'
    end
    assert(response.return_code == "0")
    assert(response.parts.count > 0)
  end

  should "should detect bad connection" do
    assert_raise(ArgumentError) do 
      client = bad_connection
      response = client.run_report do |req|
        req.argument 'HTML', :name => 'RUN_OUTPUT_FORMAT'
  
        req.resourceDescriptor :name => 'JRLogo', 
          :wsType => 'img', 
          :uriString => '/reports/xforty/user_list', 
          :isNew => 'false'
      end
    end
  end

  should "produce string message when report path is bad" do 
    client = setup_connection
    omit_if(client.nil?, "This test requires a Jasper server running on localhost:8080")
    response = client.run_report do |req|
      req.resourceDescriptor :name => 'jrlogo', :wsType => 'img', :uriString => '/Reports/xfortys/user_list', :isNew => 'false'
    end
    
    assert(response.message.class == String)
  end

  should "return valid message on bad report path" do 
    client = setup_connection
    omit_if(client.nil?, "This test requires a Jasper server running on localhost:8080")
    response = client.run_report do |req|
      req.resourceDescriptor :name => 'jrlogo', :wsType => 'img', :uriString => '/Reports/xfortys/user_list', :isNew => 'false'
    end
    
    assert(response.message.length > 0)
  end
  
  should "fetch on a bad resource path should be unsuccessful" do
    client = setup_connection
    omit_if(client.nil?, "This test requires a Jasper server running on localhost:8080")
    response = client.run_report do |req|
      req.resourceDescriptor :name => 'jrlogo', :wsType => 'img', :uriString => '/Reports/xfortys/user_list', :isNew => 'false'
    end
    assert(response.success? == false)
  end

  should "fetch on a bad resource path should have non 'OK' message" do
    client = setup_connection
    omit_if(client.nil?, "This test requires a Jasper server running on localhost:8080")
    response = client.run_report do |req|
      req.resourceDescriptor :name => 'jrlogo', :wsType => 'img', :uriString => '/Reports/xfortys/user_list', :isNew => 'false'
    end
    assert(response.message != 'OK')
  end
end