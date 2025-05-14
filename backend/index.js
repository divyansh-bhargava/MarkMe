const express = require("express")
const app = express()

require("dotenv").config()

const student = require("./routes/student")
const teacher = require("./routes/teacher")
const admin = require("./routes/admin")


const port = process.env.PORT || 3000

app.use(express.json())

app.use("/api/v1/student", student);
app.use("/api/v1/teacher",  teacher);
app.use("/api/v1/admin",  admin);

app.listen(port ,()=>{
    console.log(`server start at port no ${port}`);  
})

app.get("/", (req, res) => {
	return res.json({
		success:true,
		message:'Your server is up and running....'
	});
});