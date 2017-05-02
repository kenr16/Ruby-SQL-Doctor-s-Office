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

end
