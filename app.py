from flask import Flask , render_template, request, redirect, url_for, session, flash, make_response
from db import connection
from functools import wraps


app = Flask (__name__)
app.secret_key ='your key'
def no_cache(view):
    @wraps(view)
    def decorated_view(*args, **kwargs):
        # We now create a response object from the view's return value
        response = make_response(view(*args, **kwargs))
        response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
        response.headers['Pragma'] = 'no-cache'
        response.headers['Expires'] = '0'
        return response
    return decorated_view
@app.route("/")
def home():
    return render_template("index.html")

@app.route('/patient')  # route for patient.html
def patien():
    return render_template("patient.html")

@app.route('/dr', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        # Get the form data
        username = request.form['username']
        password = request.form['password']
        conn=connection()
        cursor= conn.cursor(dictionary=True)
        query= "select * from doctors where doctor_name =%s AND doctor_password= %s "
        cursor.execute(query,(username,password))
        user=cursor.fetchone()
        conn.close()
        # Simple check for a valid username and password
        if user:
            session['username'] = user['doctor_name']  # Store the username in the session
            session['doctor_id'] = user['doctor_id']
            flash("login successfully")
            return redirect(url_for('dr_profile'))
        else:
            flash("Invalid username or password")
            return redirect(url_for('login')) # A more secure app would use a message here

    return render_template('dr.html')
@app.route('/doctor_profile')
@no_cache
def dr_profile():
    if 'username' in session and 'doctor_id' in session:
        username = session['username']
        conn = connection()
        cursor = conn.cursor(dictionary=True)
        query = "SELECT * FROM doctors WHERE doctor_name = %s"
        cursor.execute(query, (username,))
        user_info = cursor.fetchone()
        conn.close()
        if not user_info:
            session.clear()
            flash("User not found. Please log in again.")
            return redirect(url_for('login'))
        return render_template("dr_profile.html", doctor_info=user_info)
    else:
        return redirect(url_for('login'))
@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('home'))
@app.route('/<int:doctor_id>/edit' , methods= ['Post','Get'])
def edit_dr(doctor_id):
    conn = connection()
    cursor = conn.cursor()
    if request.method == 'POST':
        name = request.form["name"]
        phone=request.form["phone"]
        email = request.form["email"]
        specialization = request.form["specialization"]
        experience  = request.form["experience"]
        query = "UPDATE doctors SET doctor_name = %s, doctor_phone = %s, doctor_email = %s, Specialization = %s, Experience = %s WHERE doctor_id = %s"
        cursor.execute(query, (name, phone, email, specialization, experience, doctor_id))
        conn.commit()
        cursor.close()
        conn.close()
        session['username'] = name
       
    conn = connection()
    cursor = conn.cursor(dictionary=True)
    query = "SELECT * FROM doctors WHERE doctor_id = %s"
    cursor.execute(query, (doctor_id,))
    doctor_info = cursor.fetchone()
    conn.close()
    flash("Profile updated successfully!")
    return render_template("dr_profile.html", doctor_info=doctor_info)
@app.route("/register_new_patient", methods =['POST','GET'])
def patient_registers():
    if request.method == 'POST':
        pid = request.form["pid"]
        fname = request.form["fname"]
        lname = request.form["lname"]
        gender= request.form["gender"]
        paddress = request.form["paddress"]
        pphone = request.form ["pphone"]
        pemail = request.form ["pemail"]
        pallergy = request.form ['pallergy']
        pillness= request.form["pillness"]
        ptreatment= request.form["ptreatment"]
        conn= connection()
        cursor= conn.cursor(dictionary=True)
        query_security_id="select * from patient where patient_securitynum = %s"
        cursor.execute(query_security_id,(pid,))
        pid_info= cursor.fetchone()
        if pid_info:
            flash("this security ID is already exsited")
            return redirect (url_for('dr_profile'))
        else: 
            patient_insert = "insert into patient (patient_securitynum ,patient_fname, patient_lname,gender, patient_address, patient_phone, patient_email,patient_allergies, patient_illness,patient_treatment)VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            cursor.execute(patient_insert,(pid,fname,lname,gender,paddress,pphone,pemail,pallergy,pillness,ptreatment))
            conn.commit()
            cursor.close()
            conn.close()
            flash("New patient registered successufully")
            return redirect(url_for('dr_profile'))
@app.route("/add_appointment", methods=['POST','GET'])
def appointment_record(): 
    if request.method == 'POST':
        patient_sid= request.form['sid']
        doctor_username= session.get('username')
        appointment_date = request.form['date']
        diaganois= request.form['dia_treatment']
        note= request.form['note']
        try:
            conn= connection()
            cursor=conn.cursor(dictionary=True)
            pid_fetch_query= "select patient_id from patient where patient_securitynum = %s"
            cursor.execute(pid_fetch_query,(patient_sid,))
            patient_record=cursor.fetchone()
            if not patient_record:
                flash("Patient not found with that Security ID.")
                return redirect(url_for('dr_profile'))
            patient_id = patient_record['patient_id']
            did_fetch_query = "SELECT doctor_id FROM doctors WHERE doctor_name= %s"
            cursor.execute(did_fetch_query, (doctor_username,))
            doctor_record = cursor.fetchone()
            if not doctor_record:
                flash("Doctor not found.")
                return redirect(url_for('login')) # Redirect to login if doctor not found
            doctor_id = doctor_record['doctor_id']
            record_query= "insert into appointments (patient_id,doctor_id ,appointment_date,diago_treatment,note)values (%s,%s,%s,%s,%s)"
            cursor.execute(record_query,(patient_id, doctor_id, appointment_date,diaganois,note))
            conn.commit()
            flash("Appointment record added successfully.")
            return redirect(url_for('dr_profile'))
        except Exception as e:
            conn.rollback()
            flash(f"An error occurred: {e}")
            return redirect(url_for('dr_profile'))
        finally:
            cursor.close()
            conn.close()
@app.route("/add_prescription" , methods= ['POST','GET'])
def add_prescription():
    if request.method =='POST':
        pres_id= request.form ['pre_sid']
        doctor_username= session.get('username')
        pres_date= request.form['date']
        pres_medicine=request.form['medicine']
        pres_strength= request.form['strength']
        pres_duration= request.form['duration']
        pres_instructions=request.form['instructions']
        try:
            conn=connection()
            cursor=conn.cursor(dictionary= True)
            pid="select patient_id from patient where patient_securitynum = %s"
            cursor.execute(pid,(pres_id,))
            pid_find=cursor.fetchone()
            if not pid_find:
                flash("this patient is not exsited")
                return redirect(url_for('dr_profile'))
            newpid= pid_find['patient_id']
            did= "select doctor_id from doctors where doctor_name=%s"
            cursor.execute(did,(doctor_username,))
            did_find=cursor.fetchone()
            if not did_find:
                flash("doctor not exsisted")
                return redirect(url_for('login'))
            newdid= did_find['doctor_id']
            prescription_query="insert into prescription(patient_id,doctor_id,prescription_date,medicine,strength,instructions,duration)values(%s,%s,%s,%s,%s,%s,%s)"
            cursor.execute(prescription_query,(newpid,newdid,pres_date,pres_medicine,pres_strength,pres_duration,pres_instructions))
            conn.commit()
            flash("prescription has successfully added")
            return redirect(url_for('dr_profile'))
        except Exception as e:
            conn.rollback()
            flash(f"there is this issue{e}")
            return redirect(url_for('dr_profile'))
        finally:
            cursor.close()
            conn.close()
if __name__ == "__main__":
    app.run(debug=True)
 