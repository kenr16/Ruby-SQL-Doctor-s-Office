require("spec_helper")

describe("Doctor") do
  describe(".all") do
    it("starts off with no doctors") do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you the doctor's name") do
      doctor = Doctor.new({:name => "Dr. Andrews", :specialty => "Optometry", :specialty_id => 1, :id => nil})
      expect(doctor.name()).to(eq("Dr. Andrews"))
    end
  end

  describe("#specialty") do
    it("tells you the doctor's specialty") do
      doctor = Doctor.new({:name => "Dr. Andrews", :specialty => "Optometry", :specialty_id => 1, :id => nil})
      expect(doctor.specialty()).to(eq("Optometry"))
    end
  end

  describe("#id") do
    it("sets doctors ID when you save it") do
      doctor = Doctor.new({:name => "Dr. Andrews", :specialty => "Optometry", :specialty_id => 1, :id => nil})
      doctor.save()
      expect(doctor.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save the doctors to the database") do
      doctor = Doctor.new({:name => "Dr. Andrews", :specialty => "Optometry", :specialty_id => 1, :id => nil})
      doctor.save()
      expect(Doctor.all()).to(eq([doctor]))
    end
  end

  describe("#==") do
    it("is the same doctor if it has the same name and id") do
      doctor1 = Doctor.new({:name => "Dr. Andrews", :specialty => "Optometry", :specialty_id => 1, :id => nil})
      doctor2 = Doctor.new({:name => "Dr. Andrews", :specialty => "Optometry", :specialty_id => 1, :id => nil})
      expect(doctor1).to(eq(doctor2))
    end
  end

  describe(".find") do
    it("returns a doctor by its ID") do
      doctor1 = Doctor.new({:name => "Dr. Andrews", :specialty => "Optometry", :specialty_id => 1, :id => nil})
      doctor1.save()
      doctor2 = Doctor.new({:name => "Dr. Carter", :specialty => "Neurosurgery", :specialty_id => 1, :id => nil})
      doctor2.save()
      expect(Doctor.find(doctor2.id())).to(eq(doctor2))
    end
  end

  describe("#patients") do
    it("returns an array of patients for that doctor") do
      test_doctor = Doctor.new({:name => "Dr. Andrews", :specialty => "Optometry", :specialty_id => 1, :id => nil})
      test_doctor.save()
      test_patient = Patient.new({:name => "Mark Jones", :doctor_id => test_doctor.id(), :birthday => "2008-11-11"})
      test_patient.save()
      test_patient2 = Patient.new({:name => "Ann Stevens", :doctor_id => test_doctor.id(), :birthday => "2008-11-11"})
      test_patient2.save()
      expect(test_doctor.patients(test_doctor.id())).to(eq([test_patient, test_patient2]))
    end
  end

end
