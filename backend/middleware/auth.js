const jwt = require("jsonwebtoken")
require("dotenv").config()


exports.isAuth = async (req, res, next) => {
	try {
		const token =
			req.cookies.token ||
			req.body.token ||
			req.header("Authorization").replace("Bearer ", "");

		if (!token) {
			return res.status(401).json({ success: false, message: `Token Missing` });
		}

		console.log(token)

		try {
			const decode =  jwt.verify(`${token}`, process.env.JWT_SECRET_KEY);
			console.log(decode);
			req.user = decode;
		} catch (error) {
			console.log(error);
			// If JWT verification fails, return 401 Unauthorized response
			return res
				.status(401)
				.json({ success: false, message: "token is invalid" });
		}

		next();

	} catch (error) {
		// If there is an error during the authentication process, return 401 Unauthorized response
		return res.status(401).json({
			success: false,
			message: `Something Went Wrong While Validating the Token`,
		});
	}
};

