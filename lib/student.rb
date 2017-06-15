class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    DB[:conn].execute("CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, grade TEXT)")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end

  def save
    sql = ("INSERT INTO students (name, grade) VALUES (?, ?)")
    arg = [self.name, self.grade]
    DB[:conn].execute(sql, arg)
    @id = DB[:conn].execute("SELECT * FROM students ORDER BY id LIMIT 1").flatten.first
  end

  def self.create(hash)
    name = hash[:name]
    grade = hash[:grade]
    new_student = Student.new(name, grade)
    new_student.save
    new_student
  end


end
