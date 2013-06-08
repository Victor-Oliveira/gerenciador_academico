class User

  attr_accessor :registry, :name, :login, :password

  def initialize(params)
    @registry = params[:registry]
    @name = params[:name]
    @login = params[:login]
    @password = params[:password]
  end

end
