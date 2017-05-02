require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/specialties")
require("./lib/doctors")
require("./lib/patients")
require("pg")
require("pry")

DB = PG.connect({:dbname => "doctors_office"})

get("/") do
  erb(:index)
end

get("/viewdoctors") do
  @doctors = Doctor.sort()
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
  @doctors = Doctor.sort()
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



post("/doctors_add") do
  doctor_name = params.fetch("doctor_name")
  specialty = params.fetch("specialty")
  specialty_id = params.fetch("specialty_id").to_i()
  @specialty = Specialty.find(specialty_id)
  @doctor = Doctor.new({:name => doctor_name, :specialty => specialty, :specialty_id => specialty_id, :id => nil})
  @doctor.save()
  erb(:specialty)
end






get("/specialties/new") do
  erb(:specialties_form)
end

get("/viewspecialties") do
  @specialties = Specialty.all()
  erb(:specialties_list)
end

post("/specialties") do
  name = params.fetch("specialty_name")
  specialty = Specialty.new({:name => name, :id => nil})
  specialty.save()
  @specialties = Specialty.all()
  erb(:specialties_list)
end

get("/specialty/:id") do
  @specialty = Specialty.find(params.fetch("id").to_i())
  erb(:specialty)
end
