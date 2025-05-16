const db = require('../config/database')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')

exports.sendOtp = async (req, res) => {
    console.log("Inside Controller - send otp");

    const { email } = req.body

    if (!email) {
        return res.status(400).json({
            success: false,
            message: "email is required"
        })
    }

    db.query(`select * from teacher , teacherPassword where email = ? and teacher.id = teacherPassword.teacher_id `, email, async (err, response) => {
        if (response) {
            return res.status(203).json({
                success: false,
                message: "user is already registered",
                data: response
            })
        }
    })

    let otp = otpGenerator.generate(6, {
        lowerCaseAlphabets: false,
        upperCaseAlphabets: false,
        specialChars: false
    });

    let result = await db.query(`select * from otp_table where otp = ? `, otp)

    while (result) {
        otp = otpGenerator.generate(6, {
            lowerCaseAlphabets: false,
            upperCaseAlphabets: false,
            specialChars: false
        });

        result = await db.query(`select * from otp_table where otp = ? `, otp)
    }

    db.query(`insert into otp_table set ?`, { email: email, otp: otp }, async (err, response) => {

        if (response) {
            console.log("Res: ", response);

            await mail(response[0].email, "otp for signup", `<h1>otp ${response[0].email}</h1>`)

            console.log(`email sent succesfully at ${this.email}`)

        }
        else {
            return res.status(203).json({
                success: false,
                message: "error in sending otp",
                data: err
            })
        }
    })

}

exports.teacherSignUp = async (req, res) => {
    console.log('inside controller - signup');

    const { email, password, confirmPassword, otp } = req.body

    if (!email || !password || !confirmPassword || !otp) {
        return res.status(400).json({
            success: false,
            message: "All fields are required"
        })
    }

    if (password !== confirmPassword) {
        return res.status(400).json({
            success: false,
            message: "Password and confirm password should be same"
        })
    }

    let data;

    db.query(`select * from teacher where email= ? `, email, async (err, res) => {
        if (res) {
            [data] = res
        }
        else {
            return res.status(203).json({
                success: false,
                message: "you are not register in college database"
            })
        }
    })

    db.query(`SELECT * FROM teacherPassword where teacher_id = ?`, data.id, async (err, response) => {

        if (response.length > 0) {
            return res.status(203).json({
                success: false,
                message: "User is already registered."
            })
        }
        else {

            const [validOtps] = await db.execute(
                `SELECT * FROM otp_codes 
                WHERE email = ? AND otp_code = ?  AND expires_at > NOW()
                ORDER BY created_at DESC LIMIT 1`,
                [email, otp]
            );

            if (!validOtps) {
                return res.status(401).json({ message: 'Invalid or expired OTP.' });
            }

            const hashedPwd = await bcrypt.hash(password, 10);

            db.query(`INSERT INTO teacherPassword SET ?`, { teacher_id: data.id, password: hashedPwd }, async (err, response) => {

                if (response) {
                    console.log("Res: ", response);

                    const payload = {
                        email: data.email,
                        id: data.id,
                        accountType: teacher
                    }

                    const token = jwt.sign(payload, process.env.JWT_SECRET_KEY, { expiresIn: '5h' })

                    data.token = token

                    const option = {
                        expires: new Date(Date.now() + 3 * 24 * 60 * 60 * 1000),
                        httponly: true
                    }

                    res.cookie("token", token, option).status(200).json({
                        success: true,
                        data: data,
                        message: "Student Signup succesfully"
                    })


                }
                else {
                    return res.status(203).json({
                        success: false,
                        message: "error in signup",
                        data: err
                    })
                }



            });

        }
    })
}


exports.teacherSignIn = async (req, res) => {

    console.log("Inside Controller - login")

    const { email, password } = req.body;

    db.query('SELECT * FROM teacher WHERE email = ? AND teacher.id = teacherPassword.id', email, async (err, response) => {

        console.log("Response : ", response);

        if (response.length > 0) {

            const pwdCheck = await bcrypt.compare(password, response[0].password)

            if (pwdCheck) {

                const payload = {
                    email: response[0].email,
                    id: response[0].id,
                    accountType: teacher
                }

                const token = jwt.sign(payload, process.env.JWT_SECRET_KEY, { expiresIn: '5h' })

                response[0].token = token

                const option = {
                    expires: new Date(Date.now() + 3 * 24 * 60 * 60 * 1000),
                    httponly: true
                }

                res.cookie("token", token, option).status(200).json({
                    success: true,
                    data: response[0],
                    message: "teacher Signin succesfully"
                })
            }
            else {
                return res.status(400).json({
                    success: false,
                    message: " password does not match "
                })
            }
        }
        else {
            return res.status(400).json({
                success: false,
                message: "err in signin"
            })
        }
    })
}

exports.getSubjByCourse = async (req, res) => {

    console.log("Inside Controller - subject ")

    const { teacher_id } = req.body;

    const quer = `SELECT * FROM subjects WHERE  teacher_id= ? `;


    db.query(quer, teacher_id, async (err, response) => {

        if (response) {
            return res.status(200).json({
                success: true,
                message: "subject fetched successfully",
                data: response
            })
        }
        else {
            return res.status(203).json({
                success: false,
                message: "subject not fetched",
                data: err
            })
        }
    })
}

exports.getStudentsBySubject = async (req, res) => {

    console.log("Inside Controller - get students by subject")

    const { course_id } = req.body;

    const quer = `SELECT * FROM student WHERE  course_id = ? ORDER BY roll ASC`;

    db.query(quer, course_id, async (err, response) => {

        console.log("Response : ", response);
        if (response) {
            return res.status(200).json({
                success: true,
                message: "student fetched successfully",
                data: response
            })
        }
        else {
            return res.status(203).json({
                success: false,
                message: "student not fetched",
                data: err
            })
        }
    })
}


exports.getAttendance = async (req, res) => {

    console.log("Inside Controller - get attendance by subject")

    const { student_id } = req.body;

    const quer = `SELECT roll , name , id , date , status  FROM student , attendance WHERE subject_id = ? AND student.roll = attendance.roll ORDER BY date DESC`;

    db.query(quer, student_id, async (err, response) => {

        console.log("Response : ", response);

        if (response) {
            return res.status(200).json({
                success: true,
                message: "attendance fetched successfully",
                data: response
            })
        }
        else {
            return res.status(203).json({
                success: false,
                message: "attendance not fetched",
                data: err
            })
        }
    })
}


exports.takeAttendance = async (req, res) => {

    console.log("Inside Controller - take attendance by subject")

    const { attendance, subject_id, teacher_id, date } = req.body;

    const quer = `SELECT * FROM attendance WHERE subject_id = ? AND roll = ? AND date = ? `;

    db.query(quer, [subject_id, attendance[0].roll, date], async (err, response) => {

        console.log("Response : ", response);

        if (response) {
            return res.status(200).json({
                success: true,
                message: "attendance already take for this date ",
                data: response
            })
        }
        else {

            const quer = `INSERT INTO attendance (roll , subject_id , teacher_id , date , status) VALUES ?`;

            const values = attendance.map((item) => [item.roll, subject_id, teacher_id, date, item.status]);

            db.query(quer, [values], async (err, response) => {
                if (response) {
                    return res.status(200).json({
                        success: true,
                        message: "attendance taken successfully",
                        data: response
                    })
                }
                else {
                    return res.status(203).json({
                        success: false,
                        message: "attendance not taken",
                        data: err
                    })
                }
            })


        }
    })
}


exports.updateAttendance = async (req, res) => {

    console.log("Inside Controller - update attendance")

    const { id, status } = req.body;


    var quer = `UPDATE attendance SET status=? WHERE id= ?`;

    db.query(quer, [status, id], async (err, response) => {

        console.log("Response : ", response);

        if (response) {
            return res.status(200).json({
                success: true,
                message: "attendance taken successfully",
                data: response
            })
        }
        else {
            return res.status(203).json({
                success: false,
                message: "attendance not taken",
                data: err
            })
        }
    })
}


