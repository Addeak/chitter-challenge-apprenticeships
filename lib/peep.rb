require_relative 'database_connection'

class Peep
  attr_reader :id, :message

  def initialize(id:, message:)
    @id = id
    @message = message
  end

  def self.create(message:)
    result = DatabaseConnection.query("INSERT INTO peeps (message) VALUES($1) RETURNING id, message;", [message])
    Peep.new(
      id: result[0]['id'],
      message: result[0]['message']
    )
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM peeps;")
    result.map do |peep|
      Peep.new(id: peep['id'], message: peep['message'])
    end
  end
end
