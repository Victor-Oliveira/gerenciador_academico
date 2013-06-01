#lembrete: conseguir um modo de mostrar o usuário se é admin ou estudante

class User
  #attr_accessor :type
  attr_reader :login, :pw

  def initialize(params)
    #@type = params[:type]
    @login = params[:login]
    @pass = params[:pw]
  end
end
