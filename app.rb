require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/doctors")
require("./lib/patients")
require("pg")
require("pry")

DB = PG.connect({:dbname => "doctors_office"})

get("/") do
  erb(:index)
end

get("/viewdoctors") do
  @doctors = Doctor.all()
  erb(:doctors_list)
end

get("/doctors/new") do
  erb(:doctors_form)
end

post("/doctors") do
  name = params.fetch("name")
  specialty = params.fetch("specialty")
  doctor = Doctor.new({:name => name, :specialty => specialty, :id => nil})
  doctor.save()
  @doctors = Doctor.all()
  erb(:doctors_list)
end

get("/doctor/:id") do
  @doctor = Doctor.find(params.fetch("id").to_i())
  erb(:doctor)
end

post("/patients_add") do
  patient_name = params.fetch("patient_name")
  birthday = params.fetch("birthday")
  doctor_id = params.fetch("doctor_id").to_i()
  @doctor = Doctor.find(doctor_id)
  @patient = Patient.new({:name => patient_name, :birthday => birthday, :doctor_id => doctor_id})
  @patient.save()
  erb(:doctor)
end
