const db = require("../config/database.js")
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')

require('dotenv').config()

exports.studentSignUp = async (req, res) => {
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

    db.query(`select * from student where email= ? `, email, async (err, res) => {
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

    db.query(`SELECT * FROM studentPassword where roll = ?`, data.roll, async (err, response) => {

        if (response.length > 0) {
            return res.status(203).json({
                success: false,
                message: "User is already registered."
            })
        }
        else {

            const hashedPwd = await bcrypt.hash(password, 10);

            db.query(`INSERT INTO studentPassword SET ?`, { roll: data.roll, password: hashedPwd }, async (err, response) => {

                if (response) {
                    console.log("Res: ", response);

                    const payload = {
                        email: data.email,
                        roll: data.roll,
                        accountType: student
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


exports.studentSignIn = async (req, res) => {

    console.log("Inside Controller - login")

    const { email, password } = req.body;

    db.query('SELECT * FROM student WHERE email = ? AND student.roll = studentPassword.roll', email, async (err, response) => {
        
        console.log("Response : ", response);

        if (response.length > 0) {

            const pwdCheck = await bcrypt.compare(password, response[0].password)

            if (pwdCheck) {

                const payload = {
                        email: response[0].email,
                        roll: response[0].roll,
                        accountType: student
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
                        message: "Student Signin succesfully"
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



exports.getSubjects = async (req, res) => {

    console.log("Inside Controller - get subjects")

    const { course_id } = req.body

    const quer = `SELECT * FROM subjects WHERE  course_id = ?`;

    db.query(quer, course_id, async (err, response) => {

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


exports.getattendance = async (req, res) => {

    console.log("Inside Controller - get attendance")

    const { roll, subject } = req.body

    const quer = `SELECT * FROM attendance WHERE roll= ? AND  subject_id = ? ORDER BY date DESC `;

    db.query(quer, [roll, subject], async (err, response) => {

        console.log("Response : ", response)

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