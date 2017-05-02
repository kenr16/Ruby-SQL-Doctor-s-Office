class Specialty
  attr_accessor(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_specialties = DB.exec("SELECT * FROM specialties;")
    specialties = []
    returned_specialties.each() do |specialty|
      name = specialty.fetch("name")
      id = specialty.fetch("id").to_i()
      specialties.push(Specialty.new({:name => name, :id => id}))
    end
    specialties
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO specialties (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_specialty|
    self.name().==(another_specialty.name()).&(self.id().==(another_specialty.id()))
  end

  define_singleton_method(:find) do |id|
    found_specialty = nil
    Specialty.all().each() do |specialty|
      if specialty.id().==(id)
        found_specialty = specialty
      end
    end
    found_specialty
  end

  define_method(:doctors) do |specialty_id|
    found_doctors = []
    Doctor.all().each() do |doctor|
      if doctor.specialty_id().==(specialty_id)
        found_doctors.push(doctor)
      end
    end
    found_doctors
  end



end
