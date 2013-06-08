class Subject

  attr_accessor :course, :name

  def initialize(params)
    @course = params[:course]
    @name = params[:name]
  end

end
