class Doctor
  attr_accessor(:name, :specialty, :specialty_id, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @specialty = attributes.fetch(:specialty)
    @specialty_id = attributes.fetch(:specialty_id)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      specialty = doctor.fetch("specialty")
      id = doctor.fetch("id").to_i()
      specialty_id = doctor.fetch("specialty_id").to_i()
      doctors.push(Doctor.new({:name => name, :specialty => specialty, :specialty_id => specialty_id, :id => id}))
    end
    doctors
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctors (name, specialty, specialty_id) VALUES ('#{@name}', '#{@specialty}', '#{@specialty_id}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_doctor|
    self.name().==(another_doctor.name()).&(self.id().==(another_doctor.id())).&(self.specialty().==(another_doctor.specialty()))
  end

  define_singleton_method(:find) do |id|
    found_doctor = nil
    Doctor.all().each() do |doctor|
      if doctor.id().==(id)
        found_doctor = doctor
      end
    end
    found_doctor
  end

  define_method(:patients) do |id|
    found_patients = []
    Patient.all().each() do |patient|
      if patient.doctor_id().==(id)
        found_patients.push(patient)
      end
    end
    found_patients
  end



end
