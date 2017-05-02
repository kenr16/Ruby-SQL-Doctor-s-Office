require("spec_helper")

describe(Patient) do
  describe('#==') do
    it("is the same patient if it has the same name") do
      patient1 = Patient.new({:name => "Mark Jones", :doctor_id => 1, :birthday => "2008-11-11"})
      patient2 = Patient.new({:name => "Mark Jones", :doctor_id => 1, :birthday => "2008-11-11"})
      expect(patient1==patient2).to(eq(true))
    end
  end

  describe(".all") do
    it("is empty at first") do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe('#save') do
    it("adds a patient to the array of saved patients") do
      test_patient = Patient.new({:name => "Mark Jones", :doctor_id => 1, :birthday => "2008-11-11"})
      test_patient.save()
      expect(Patient.all()).to(eq([test_patient]))
    end
  end

  describe('#name') do
    it("lets you view the patient's name") do
      test_patient = Patient.new({:name => "Mark Jones", :doctor_id => 1, :birthday => "2008-11-11"})
      expect(test_patient.name()).to(eq("Mark Jones"))
    end
  end

  describe('#doctor_id') do
    it("lets you view the patient's doctor id") do
      test_patient = Patient.new({:name => "Mark Jones", :doctor_id => 1, :birthday => "2008-11-11"})
      expect(test_patient.doctor_id()).to(eq(1))
    end
  end

  describe('#birthday') do
    it("lets you view the patient's birthday") do
      test_patient = Patient.new({:name => "Mark Jones", :doctor_id => 1, :birthday => "2008-11-11"})
      expect(test_patient.birthday()).to(eq("2008-11-11"))
    end
  end

end
