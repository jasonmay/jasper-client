require 'helper'

class TestJasperClient < Test::Unit::TestCase
  def setup_connection
    rest_uri = 'http://127.0.0.1:8080/jasperserver/rest'
    user = 'jasperadmin'
    pass = user
    JasperClient::RepositoryService.new(rest_uri, user, pass)
  end

  def bad_connection
    wsdl = 'http://127.0.0.1:8081/jasperserver/services/repository?wsdl'
    user = 'jasperadmin'
    pass = user
    JasperClient::RepositoryService.new(wsdl, user, pass)
  end

  should "respond to list requests" do
    client = setup_connection
    response = client.list :resource_type => "reportUnit"

    assert response.kind_of?(Array)
  end

  should "respond to runReport requests" do
    pend("Not implemented yet")
    client = setup_connection
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
    pend("Not implemented yet")
    assert_raise(Errno::ECONNREFUSED) do
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
    pend("Not implemented yet")
    client = setup_connection
    response = client.run_report do |req|
      req.resourceDescriptor :name => 'jrlogo', :wsType => 'img', :uriString => '/Reports/xfortys/user_list', :isNew => 'false'
    end

    assert(response.message.class == String)
  end

  should "return valid message on bad report path" do
    pend("Not implemented yet")
    client = setup_connection
    response = client.run_report do |req|
      req.resourceDescriptor :name => 'jrlogo', :wsType => 'img', :uriString => '/Reports/xfortys/user_list', :isNew => 'false'
    end

    assert(response.message.length > 0)
  end

  should "fetch on a bad resource path should be unsuccessful" do
    pend("Not implemented yet")
    client = setup_connection
    response = client.run_report do |req|
      req.resourceDescriptor :name => 'jrlogo', :wsType => 'img', :uriString => '/Reports/xfortys/user_list', :isNew => 'false'
    end
    assert(response.success? == false)
  end

  should "fetch on a bad resource path should have non 'OK' message" do
    pend("Not implemented yet")
    client = setup_connection
    response = client.run_report do |req|
      req.resourceDescriptor :name => 'jrlogo', :wsType => 'img', :uriString => '/Reports/xfortys/user_list', :isNew => 'false'
    end
    assert(response.message != 'OK')
  end
end
