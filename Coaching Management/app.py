from datetime import datetime
import pytz
from flask import Flask, render_template, request, redirect, session, flash, abort
from db_config import get_db_connection
from datetime import datetime
from functools import wraps

import os

app = Flask(__name__)
app.secret_key = os.environ.get("SECRET_KEY", "DEV_SECRET_CHANGE_ME")

# ======================================================
# HELPERS
# ======================================================

def login_required(fn):
    @wraps(fn)
    def decorated(*args, **kwargs):
        if 'user' not in session:
            return redirect('/')
        return fn(*args, **kwargs)
    return decorated


def role_required(role):
    def wrapper(fn):
        @wraps(fn)
        def decorated(*args, **kwargs):
            if session.get('role') != role:
                flash("Unauthorized access", "danger")
                return redirect('/')
            return fn(*args, **kwargs)
        return decorated
    return wrapper




# ======================================================
# LOGIN / LOGOUT
# ======================================================

@app.route('/', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']

        conn = cursor = None
        try:
            conn = get_db_connection()
            cursor = conn.cursor(dictionary=True)

            # ADMIN
            cursor.execute(
                "SELECT * FROM admin WHERE email=%s AND password=%s",
                (email, password)
            )
            admin = cursor.fetchone()
            if admin:
                session.clear()
                session['role'] = 'admin'
                session['user'] = admin
                return redirect('/admin')

            # TEACHER
            cursor.execute(
                "SELECT * FROM teachers WHERE email=%s AND password=%s",
                (email, password)
            )
            teacher = cursor.fetchone()
            if teacher:
                session.clear()
                session['role'] = 'teacher'
                session['user'] = teacher
                return redirect('/teacher')

            # STUDENT
            cursor.execute(
                "SELECT * FROM students WHERE email=%s AND password=%s",
                (email, password)
            )
            student = cursor.fetchone()
            if student:
                session.clear()
                session['role'] = 'student'
                session['user'] = student
                return redirect('/student')

            flash("Invalid credentials", "danger")

        finally:
            if cursor: cursor.close()
            if conn: conn.close()

    return render_template('login.html')




@app.route('/logout')
def logout():
    session.clear()
    return redirect('/')

# ======================================================
# ADMIN
# ======================================================

@app.route('/admin')
@login_required
@role_required('admin')
def admin_dashboard():
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("SELECT COUNT(*) total FROM students")
        students = cursor.fetchone()['total']

        cursor.execute("SELECT COUNT(*) total FROM teachers")
        teachers = cursor.fetchone()['total']

        cursor.execute("SELECT COUNT(DISTINCT class) total FROM students")
        classes = cursor.fetchone()['total']

        cursor.execute("""
            SELECT class, COUNT(*) count
            FROM students GROUP BY class
        """)
        
        classwise = cursor.fetchall()


        return render_template(
            'admin_dashboard.html',
            students=students,
            teachers=teachers,
            classes=classes,
            classwise=classwise
        )
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

# ======================================================
# ADMIN TEACHERS CRUD
# ======================================================
@app.route('/admin/add_teacher', methods=['GET', 'POST'])
@login_required
@role_required('admin')
def add_teacher():
    if request.method == 'POST':
        conn = cursor = None
        try:
            conn = get_db_connection()
            cursor = conn.cursor()
            cursor.execute("""
                INSERT INTO teachers (name,email,password,subject)
                VALUES (%s,%s,%s,%s)
            """, (
                request.form['name'],
                request.form['email'],
                request.form['password'],  # PLAIN
                request.form['subject']
            ))

            conn.commit()
            flash("Teacher added", "success")
            return redirect('/admin')
        finally:
            if cursor: cursor.close()
            if conn: conn.close()

    return render_template('add_teacher.html')

@app.route('/admin/edit_teacher/<int:id>', methods=['GET','POST'])
@login_required
@role_required('admin')
def edit_teacher(id):
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("SELECT * FROM teachers WHERE teacher_id=%s", (id,))
        teacher = cursor.fetchone()
        if not teacher:
            abort(404)

        if request.method == 'POST':
            cursor.execute("""
                UPDATE teachers
                SET name=%s,email=%s,subject=%s
                WHERE teacher_id=%s
            """, (
                request.form['name'],
                request.form['email'],
                request.form['subject'],
                id
            ))
            conn.commit()
            flash("Teacher updated", "success")
            return redirect('/admin/teachers')

        return render_template('edit_teacher.html', teacher=teacher)
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

@app.route('/admin/delete_teacher/<int:id>')
@login_required
@role_required('admin')
def delete_teacher(id):
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM teachers WHERE teacher_id=%s", (id,))
        conn.commit()
        flash("Teacher deleted", "success")
        return redirect('/admin/teachers')
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

       

# ======================================================
# ADMIN STUDENTS CRUD
# ======================================================

@app.route('/admin/students')
@login_required
@role_required('admin')
def admin_students():
    search = request.args.get('search', '')
    class_filter = request.args.get('class', '')

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    query = "SELECT * FROM students WHERE 1=1"
    params = []

    if search:
        query += " AND name LIKE %s"
        params.append(f"%{search}%")

    if class_filter:
        query += " AND class=%s"
        params.append(class_filter)

    query += " ORDER BY class"

    cursor.execute(query, params)
    students = cursor.fetchall()

    cursor.execute("SELECT DISTINCT class FROM students ORDER BY class")
    classes = cursor.fetchall()

    conn.close()

    return render_template(
        "admin_students.html",
        students=students,
        classes=classes,
        search=search,
        class_filter=class_filter
    )



@app.route('/admin/add_student', methods=['GET', 'POST'])
@login_required
@role_required('admin')
def add_student():
    if request.method == 'POST':
        conn = cursor = None
        try:
            conn = get_db_connection()
            cursor = conn.cursor()
            cursor.execute("""
                INSERT INTO students (name,email,password,class,gender)
                VALUES (%s,%s,%s,%s,%s)
            """, (
                request.form['name'],
                request.form['email'],
                request.form['password'],
                request.form['class'],
                request.form.get('gender', 'Not Specified')
            ))


            conn.commit()
            flash("Student added", "success")
            return redirect('/admin')
        finally:
            if cursor: cursor.close()
            if conn: conn.close()

    return render_template('add_student.html')


@app.route('/admin/edit_student/<int:id>', methods=['GET','POST'])
@login_required
@role_required('admin')
def edit_student(id):
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("SELECT * FROM students WHERE student_id=%s", (id,))
        student = cursor.fetchone()
        if not student:
            abort(404)

        if request.method == 'POST':
            cursor.execute("""
                UPDATE students SET name=%s,email=%s,class=%s,gender=%s
                WHERE student_id=%s
            """, (
                request.form['name'],
                request.form['email'],
                request.form['class'],
                request.form['gender'],
                id
            ))
            conn.commit()
            return redirect('/admin/students')

        return render_template('edit_student.html', student=student)
    finally:
        if cursor: cursor.close()
        if conn: conn.close()


@app.route('/admin/delete_student/<int:id>')
@login_required
@role_required('admin')
def delete_student(id):
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM students WHERE student_id=%s", (id,))
        conn.commit()
        flash("Student deleted", "success")
        return redirect('/admin/students')
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

# ======================================================
# ADMIN TEACHERS CRUD (SAME PATTERN)
# ======================================================

@app.route('/admin/teachers')
@login_required
@role_required('admin')
def admin_teachers():
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM teachers")
        return render_template('admin_teachers.html', teachers=cursor.fetchall())
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

# ======================================================
# TEACHER
# ======================================================

@app.route('/teacher')
@login_required
@role_required('teacher')
def teacher_dashboard():
    teacher_id = session['user']['teacher_id']

    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("""
            SELECT
                class,
                subject,
                lecture_date,
                start_time,
                end_time
            FROM timetable
            WHERE
                is_extra = 1
                AND status = 'Active'
                AND teacher_id = %s
                AND (
                    lecture_date > CURDATE()
                    OR (lecture_date = CURDATE() AND end_time >= CURTIME())
                )
            ORDER BY lecture_date, start_time
        """, (teacher_id,))

        extra_lectures = cursor.fetchall()

        return render_template(
            'teacher_dashboard.html',
            extra_lectures=extra_lectures
        )

    finally:
        if cursor: cursor.close()
        if conn: conn.close()


@app.route('/today_lectures')
@login_required
@role_required('teacher')
def today_lectures():
    # ✅ Force India timezone (Render runs in UTC)
    ist = pytz.timezone("Asia/Kolkata")
    now = datetime.now(ist)

    today_date = now.date()
    today_day = now.strftime('%A')
    current_time = now.time()

    teacher_id = session['user']['teacher_id']

    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        # ✅ FIX: handle BOTH normal + extra lectures
        cursor.execute("""
            SELECT * FROM timetable
            WHERE teacher_id = %s
              AND (
                    (lecture_date IS NULL AND day = %s)
                 OR (lecture_date = %s)
              )
        """, (teacher_id, today_day, today_date))

        lecture = None
        for row in cursor.fetchall():
            start = (datetime.min + row['start_time']).time()
            end = (datetime.min + row['end_time']).time()

            # ✅ Check running lecture window
            if start <= current_time <= end:
                lecture = row
                break

        return render_template(
            'today_lectures.html',
            lecture=lecture
        )

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

#Add marks
@app.route('/add_marks', methods=['GET','POST'])
@login_required
@role_required('teacher')
def add_marks():
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        if request.method == 'POST':
            cursor.execute("""
                INSERT INTO exams (student_id, subject, marks, exam_name)
                VALUES (%s,%s,%s,%s)
            """, (
                request.form['student_id'],
                request.form['subject'],
                request.form['marks'],
                request.form['exam_name']
            ))
            conn.commit()
            flash("Marks added", "success")
            return redirect('/teacher')

        cursor.execute("SELECT student_id,name,class FROM students")
        return render_template('add_marks.html', students=cursor.fetchall())
    finally:
        if cursor: cursor.close()
        if conn: conn.close()
       

# ======================================================
# ATTENDANCE (NO DUPLICATES)
# ======================================================

@app.route('/attendance/<int:class_no>', methods=['GET','POST'])
@login_required
@role_required('teacher')
def attendance(class_no):
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        if request.method == 'POST':
            ist = pytz.timezone("Asia/Kolkata")
            date = datetime.now(ist).date()

            for k, v in request.form.items():
                if k.startswith("student_"):
                    sid = k.split("_")[1]
                    cursor.execute("""
                        SELECT 1 FROM attendance
                        WHERE student_id=%s AND date=%s
                    """, (sid, date))
                    if not cursor.fetchone():
                        cursor.execute("""
                            INSERT INTO attendance (student_id,class,date,status)
                            VALUES (%s,%s,%s,%s)
                        """, (sid, class_no, date, v))
            conn.commit()
            return redirect('/teacher')

        cursor.execute("SELECT student_id,name FROM students WHERE class=%s", (class_no,))
        return render_template('attendance_class.html', students=cursor.fetchall(), class_no=class_no)
    finally:
        if cursor: cursor.close()
        if conn: conn.close()


#Admin Attendance report

@app.route('/admin/attendance_report')
@login_required
@role_required('admin')
def admin_attendance_report():
    class_filter = request.args.get("class")
    month = request.args.get("month")
    from_date = request.args.get("from_date")
    to_date = request.args.get("to_date")

    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        query = """
            SELECT s.name, s.class, a.date, a.status
            FROM attendance a
            JOIN students s ON s.student_id = a.student_id
            WHERE 1=1
        """
        params = []

        if class_filter:
            query += " AND s.class = %s"
            params.append(class_filter)

        if month:
            query += " AND MONTH(a.date) = %s"
            params.append(month)

        if from_date and to_date:
            query += " AND a.date BETWEEN %s AND %s"
            params.extend([from_date, to_date])

        query += " ORDER BY s.class, a.date"

        cursor.execute(query, params)
        data = cursor.fetchall()

        # Fetch class list for filter dropdown
        cursor.execute("SELECT DISTINCT class FROM students ORDER BY class")
        classes = cursor.fetchall()

        # Month list
        months = [
            {"name": "January", "value": "01"},
            {"name": "February", "value": "02"},
            {"name": "March", "value": "03"},
            {"name": "April", "value": "04"},
            {"name": "May", "value": "05"},
            {"name": "June", "value": "06"},
            {"name": "July", "value": "07"},
            {"name": "August", "value": "08"},
            {"name": "September", "value": "09"},
            {"name": "October", "value": "10"},
            {"name": "November", "value": "11"},
            {"name": "December", "value": "12"}
        ]

        return render_template(
            'admin_attendance.html',
            data=data,
            classes=classes,
            months=months,
            class_filter=class_filter,
            month=month,
            from_date=from_date,
            to_date=to_date
        )

    finally:
        if cursor: cursor.close()
        if conn: conn.close()
#ADMIN section view student 
@app.route('/admin/student/<int:student_id>')
@login_required
@role_required('admin')
def admin_student_profile(student_id):
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute(
            "SELECT * FROM students WHERE student_id=%s",
            (student_id,)
        )
        student = cursor.fetchone()

        if not student:
            abort(404)

        # Attendance summary
        cursor.execute(
            "SELECT COUNT(*) total, SUM(status='Present') present "
            "FROM attendance WHERE student_id=%s",
            (student_id,)
        )
        att = cursor.fetchone()

        percentage = round(
            (att['present'] / att['total']) * 100, 2
        ) if att['total'] else 0

        return render_template(
            'admin_student_profile.html',
            student=student,
            attendance=att,
            percentage=percentage
        )

    finally:
        if cursor: cursor.close()
        if conn: conn.close()
# admin teacher view profile 
@app.route('/admin/teacher/<int:teacher_id>')
@login_required
@role_required('admin')
def admin_teacher_profile(teacher_id):
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        # Teacher info
        cursor.execute(
            "SELECT * FROM teachers WHERE teacher_id=%s",
            (teacher_id,)
        )
        teacher = cursor.fetchone()
        if not teacher:
            abort(404)

        # Timetable
        cursor.execute("""
            SELECT day, class, subject, start_time, end_time
            FROM timetable
            WHERE teacher_id=%s
            ORDER BY FIELD(day,
                'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'),
                start_time
        """, (teacher_id,))
        timetable = cursor.fetchall()

        return render_template(
            "admin_teacher_profile.html",
            teacher=teacher,
            timetable=timetable
        )

    finally:
        if cursor: cursor.close()
        if conn: conn.close()
#Admin Extra Lecture 
# ======================================================
# ADMIN EXTRA LECTURE (FINAL REBUILT VERSION)
# ======================================================

@app.route('/admin/extra_lecture', methods=['GET', 'POST'])
@login_required
@role_required('admin')
def admin_extra_lecture():
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        if request.method == 'POST':
            class_no = request.form['class']
            teacher_id = request.form['teacher_id']
            subject = request.form['subject']
            date = request.form['date']
            start = request.form['start_time']
            end = request.form['end_time']

            # ✅ Derive correct day from date (NO DB change)
            day = datetime.strptime(date, "%Y-%m-%d").strftime('%A')

            # ✅ Clash check (teacher OR class)
            cursor.execute("""
                SELECT 1
                FROM timetable
                WHERE
                    (teacher_id = %s OR class = %s)
                    AND lecture_date = %s
                    AND (
                        (%s BETWEEN start_time AND end_time)
                        OR (%s BETWEEN start_time AND end_time)
                        OR (start_time BETWEEN %s AND %s)
                    )
            """, (teacher_id, class_no, date, start, end, start, end))

            if cursor.fetchone():
                flash("Lecture time clashes with existing schedule", "danger")
                return redirect('/admin/extra_lecture')

            # ✅ INSERT EXTRA LECTURE
            cursor.execute("""
                INSERT INTO timetable
                (
                    class,
                    subject,
                    teacher_id,
                    day,
                    start_time,
                    end_time,
                    lecture_date,
                    is_extra,
                    status
                )
                VALUES (%s, %s, %s, %s, %s, %s, %s, 1, 'Active')
            """, (
                class_no,
                subject,
                teacher_id,
                day,
                start,
                end,
                date
            ))

            # ✅ THIS IS THE KEY PART (timetable_id)
            timetable_id = cursor.lastrowid

            conn.commit()

            # (Optional but useful for debugging)
            print("Extra lecture inserted with timetable_id:", timetable_id)

            flash("Extra lecture scheduled successfully", "success")
            return redirect('/admin')

        # ✅ GET request (load teachers)
        cursor.execute("SELECT teacher_id, name FROM teachers")
        teachers = cursor.fetchall()

        return render_template(
            "admin_extra_lecture.html",
            teachers=teachers
        )

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

#delete Extra lecture 
@app.route('/admin/delete_extra_lecture/<int:timetable_id>', methods=['POST'])
@login_required
@role_required('admin')
def delete_extra_lecture(timetable_id):
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        # ✅ HARD DELETE (extra lectures only)
        cursor.execute("""
            DELETE FROM timetable
            WHERE timetable_id = %s
              AND is_extra = 1
        """, (timetable_id,))

        conn.commit()
        flash("Extra lecture deleted successfully", "success")

    except Exception as e:
        if conn:
            conn.rollback()
        flash("Failed to delete extra lecture", "danger")

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

    return redirect('/admin/extra_lectures')

#Create a VIEW route for Extra Lectures
@app.route('/admin/extra_lectures')
@login_required
@role_required('admin')
def admin_extra_lectures():
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("""
            SELECT 
                t.class,
                t.subject,
                te.name AS teacher,
                t.day,
                t.lecture_date,
                t.start_time,
                t.end_time
            FROM timetable t
            JOIN teachers te ON te.teacher_id = t.teacher_id
            WHERE t.is_extra = 1
            ORDER BY t.lecture_date DESC, t.start_time
        """)

        lectures = cursor.fetchall()

        return render_template(
            "admin_extra_lectures_list.html",
            lectures=lectures
        )

    finally:
        if cursor: cursor.close()
        if conn: conn.close()


#Admin Result report
@app.route('/admin/results_report')
@login_required
@role_required('admin')
def admin_results_report():
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT s.name, s.class, e.subject, e.exam_name, e.marks
            FROM exams e
            JOIN students s ON s.student_id = e.student_id
        """)
        return render_template('admin_results.html', data=cursor.fetchall())
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

@app.route('/admin/fees_report')
@login_required
@role_required('admin')
def admin_fees_report():
    conn = cursor = None
    try:
        search = request.args.get('search','').strip()
        class_filter = request.args.get('class','').strip()
        status_filter = request.args.get('status','').strip()

        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        query = """
            SELECT s.student_id, s.name, s.class,
                   f.amount, f.status, f.date
            FROM fees f
            JOIN students s ON s.student_id = f.student_id
            WHERE 1=1
        """
        params = []

        if search:
            query += " AND s.name LIKE %s"
            params.append(f"%{search}%")

        if class_filter:
            query += " AND s.class = %s"
            params.append(class_filter)

        if status_filter:
            query += " AND f.status = %s"
            params.append(status_filter)

        query += " ORDER BY f.date DESC"

        cursor.execute(query, params)
        data = cursor.fetchall()

        total_collection = sum(
            row['amount'] for row in data if row['status'] == 'Paid'
        )

        return render_template(
            'admin_fees.html',
            data=data,
            total_collection=total_collection
        )

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()
#✅ 3️⃣ ADMIN PAY ACTION ROUTE
@app.route('/admin/pay_fee/<int:student_id>', methods=['POST'])
@login_required
@role_required('admin')
def admin_pay_fee(student_id):
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("""
            UPDATE fees
            SET status='Paid',
                payment_mode='Cash',
                date=NOW()
            WHERE student_id=%s
        """, (student_id,))

        conn.commit()
        flash("Payment marked as Paid", "success")

    except Exception as e:
        if conn:
            conn.rollback()
        flash("Payment update failed", "danger")

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()

    # ✅ SAFE REDIRECT
    return redirect('/admin/fees_report')

    
@app.route('/admin/set_fees', methods=['GET', 'POST'])
@login_required
@role_required('admin')
def set_fees():
    conn = None
    cursor = None

    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        if request.method == 'POST':
            class_no = request.form['class']
            amount = request.form['amount']

            # Insert or update fee structure
            cursor.execute(
                "SELECT * FROM fee_structure WHERE class=%s",
                (class_no,)
            )

            if cursor.fetchone():
                cursor.execute(
                    "UPDATE fee_structure SET amount=%s WHERE class=%s",
                    (amount, class_no)
                )
            else:
                cursor.execute(
                    "INSERT INTO fee_structure (class, amount) VALUES (%s, %s)",
                    (class_no, amount)
                )

            # Create unpaid fee records for students of that class
            cursor.execute(
                "SELECT student_id FROM students WHERE class=%s",
                (class_no,)
            )
            students = cursor.fetchall()

            for s in students:
                cursor.execute("""
                    SELECT * FROM fees
                    WHERE student_id=%s AND class=%s
                """, (s['student_id'], class_no))

                if not cursor.fetchone():
                    cursor.execute("""
                        INSERT INTO fees (student_id, class, amount, status, date)
                        VALUES (%s, %s, %s, 'Unpaid', CURDATE())
                    """, (s['student_id'], class_no, amount))

            conn.commit()

        # Fetch all fee structures for display
        cursor.execute("SELECT * FROM fee_structure ORDER BY class")
        fees = cursor.fetchall()

        return render_template('admin_set_fees.html', fees=fees)

    except Exception as e:
        conn.rollback()
        return f"Error occurred: {e}"

    finally:
        if cursor:
            cursor.close()
        if conn:
            conn.close()


# ======================================================
# STUDENT
# ======================================================

@app.route('/student')
@login_required
@role_required('student')
def student_dashboard():
    return render_template('student_dashboard.html')


@app.route('/my_attendance')
@login_required
@role_required('student')
def my_attendance():
    sid = session['user']['student_id']
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("SELECT * FROM attendance WHERE student_id=%s", (sid,))
        records = cursor.fetchall()

        total = len(records)
        present = sum(1 for r in records if r['status'] == 'Present')
        percentage = round((present / total) * 100, 2) if total else 0

        return render_template(
            'student_attendance.html',
            records=records,
            total=total,
            present=present,
            percentage=percentage
        )
    finally:
        if cursor: cursor.close()
        if conn: conn.close()
#Result View
@app.route('/my_results')
@login_required
@role_required('student')
def my_results():
    sid = session['user']['student_id']
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("SELECT subject, marks, exam_name FROM exams WHERE student_id=%s", (sid,))
        results = cursor.fetchall()

        subjects = [r['subject'] for r in results]
        marks = [r['marks'] for r in results]

        return render_template(
            'student_results.html',
            results=results,
            subjects=subjects,
            marks=marks
        )
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

@app.route('/my_fees')
@login_required
@role_required('student')
def my_fees():
    sid = session['user']['student_id']
    class_no = session['user']['class']

    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        # Latest fee row for this student/class
        cursor.execute("""
            SELECT * FROM fees 
            WHERE student_id=%s AND class=%s
            ORDER BY fee_id DESC LIMIT 1
        """, (sid, class_no))
        fee = cursor.fetchone()

        # Full history
        cursor.execute("""
            SELECT * FROM fees 
            WHERE student_id=%s AND class=%s
            ORDER BY date DESC
        """, (sid, class_no))
        history = cursor.fetchall()

        return render_template('student_fees.html',
                               fee=fee,
                               history=history)

    finally:
        if cursor: cursor.close()
        if conn: conn.close()


@app.route('/pay_fees', methods=['POST'])
@login_required
@role_required('student')
def pay_fees():
    sid = session['user']['student_id']
    class_no = session['user']['class']
    mode = request.form['mode']

    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        # Get unpaid fee
        cursor.execute("""
            SELECT amount FROM fees
            WHERE student_id=%s AND class=%s AND status='Unpaid'
            LIMIT 1
        """, (sid, class_no))
        fee = cursor.fetchone()

        if not fee:
            return redirect('/my_fees')

        amount = fee[0]

        # Mark as paid
        cursor.execute("""
            UPDATE fees
            SET status='Paid', payment_mode=%s, date=CURDATE()
            WHERE student_id=%s AND class=%s AND status='Unpaid'
            LIMIT 1
        """, (mode, sid, class_no))

        conn.commit()
        return redirect('/my_fees')

    finally:
        if cursor: cursor.close()
        if conn: conn.close()





# ======================================================
# TIMETABLE (ROLE BASED)
# ======================================================

@app.route('/timetable')
@login_required
def timetable():
    role = session['role']
    conn = cursor = None
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        if role == 'admin':
            cursor.execute("SELECT * FROM timetable")
        elif role == 'teacher':
            cursor.execute("SELECT * FROM timetable WHERE teacher_id=%s",
                           (session['user']['teacher_id'],))
        else:
            cursor.execute("SELECT * FROM timetable WHERE class=%s",
                           (session['user']['class'],))

        return render_template('timetable.html', timetable=cursor.fetchall())
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

# ======================================================

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)






