require("spec_helper")

describe("Specialty") do
  describe(".all") do
    it("starts off with no specialties") do
      expect(Specialty.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you the specialty's name") do
      specialty = Specialty.new({:name => "Orthopedics", :id => nil})
      expect(specialty.name()).to(eq("Orthopedics"))
    end
  end

  describe("#id") do
    it("sets specialty's ID when you save it") do
      specialty = Specialty.new({:name => "Orthopedics", :id => nil})
      specialty.save()
      expect(specialty.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save the specialty to the database") do
      specialty = Specialty.new({:name => "Optometry", :id => nil})
      specialty.save()
      expect(Specialty.all()).to(eq([specialty]))
    end
  end

  describe("#==") do
    it("is the same specialty if it has the same name and id") do
      specialty1 = Specialty.new({:name => "Optometry", :id => nil})
      specialty2 = Specialty.new({:name => "Optometry", :id => nil})
      expect(specialty1).to(eq(specialty2))
    end
  end
  #
  describe(".find") do
    it("returns a specialty by its ID") do
      specialty1 = Specialty.new({:name => "Optometry", :id => nil})
      specialty1.save()
      specialty2 = Specialty.new({:name => "Neurosurgery", :id => nil})
      specialty2.save()
      expect(Specialty.find(specialty2.id())).to(eq(specialty2))
    end
  end

  describe("#doctors") do
    it("returns an array of doctors for that specialty") do
      test_specialty = Specialty.new({:name => "Optometry", :id => nil})
      test_specialty.save()
      test_doctor = Doctor.new({:name => "Dr. Andrews", :specialty => "Optometry", :specialty_id => test_specialty.id(), :id => nil})
      test_doctor.save()
      test_doctor2 = Doctor.new({:name => "Dr. Carter", :specialty => "Optometry", :specialty_id => test_specialty.id(), :id => nil})
      test_doctor2.save()
      expect(test_specialty.doctors(test_specialty.id())).to(eq([test_doctor, test_doctor2]))
    end
  end

end
