require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end

  def self.find_by_title(title)
    play = PlayDBConnection.instance.execute(<<-SQL, title)
      SELECT *
      FROM plays
      WHERE title = ?
    SQL

    return nil if play.empty?

    Play.new(play.first)
  end

  def self.find_by_playwright(name)
    playwright = Playwright.find_by_name(name)
    raise "#{name} not found in database" unless playwright

    plays = PlayDBConnection.instance.execute(<<-SQL, playwright.id)
      SELECT *
      FROM plays
      WHERE playwright_id = ?
    SQL

    play.map {|play| Play.new(play)}
  end
end


class Playwright
  attr_accessor :name, :birth_year
  attr_reader :id

  def self.all
    data = PlayDBConnection.instance.execute('SELECT * FROM playwrights')
    data.map {|playwright| Playwright.new(playwright)}
  end

  def self.find_my_name(name)
    person = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT *
      FROM playwright
      WHERE name = ?
    SQL

    return nil if person.empty?
    Playwright.new(person.first)
  end

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def insert
    raise "#{self} already in database" if self.id

    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
      INSERT INTO playwright(name, birth_year)
      VALUES (?, ?)
    SQL

    self.id = PlayDBConnection.instance.last_insert_row_id
  end

end
