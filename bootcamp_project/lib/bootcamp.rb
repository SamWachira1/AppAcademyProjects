class Bootcamp

    def initialize(name, slogan, student_capacity )
        @name = name 
        @slogan = slogan
        @student_capacity = student_capacity
        @teachers = []
        @students = []
        @grades = Hash.new{|h,k| h[k] = []}
    end

    def name 
        @name
    end

    def slogan 
        @slogan
    end

    def teachers 
        @teachers
    end

    def students
        @students
    end

    def hire(teacher_str)
        @teachers << teacher_str
    end

    def enroll(student_str)
        if students.length < @student_capacity
            @students << student_str
            return true 
        else
            return false
        end
    end

    def enrolled?(student_str)
        @students.include?(student_str)
    end

    def student_to_teacher_ratio
        @students.length / @teachers.length
    end

    def add_grade(student_str, grade)
        if self.enrolled?(student_str)
           @grades[student_str] << grade 
           return true
        else
            false
        end
    end

    def num_grades(student_str)
        @grades[student_str].length
    end

    def average_grade(student_str)
        return nil if !(self.enrolled?(student_str) && self.num_grades(student_str) > 0)
        @grades[student_str].sum / @grades[student_str].length
    end

end

