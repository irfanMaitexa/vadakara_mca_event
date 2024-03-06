const express = require("express");
const UserRegistration = require("../model/userRegistrationModel");
const authRoute = express.Router();
const bcryptjs = require("bcryptjs");
const LoginModel = require("../model/loginModel");
const StaffRegistration = require("../model/staffRegistration");
const numSaltRounds = 8;

authRoute.get("/", (req, res) => {
  res.status(200).json({
    name: "irfan",
  });
});

//user registration
authRoute.post("/user/signup", async (req, res) => {
  try {
    const { name, phone, email, password } = req.body;
    const hashedPassword = await bcryptjs.hash(password, numSaltRounds);

    const existingUser = await UserRegistration.findOne({ phone });
    if (existingUser) {
      return res
        .status(400)
        .json({ message: "Phone number already registered" });
    }

    const existingUserEmail = await UserRegistration.findOne({ email });
    if (existingUserEmail) {
      return res.status(400).json({ message: "Email already registered" });
    }
    const logintb = await LoginModel({
      role: "user",
      email: email,
      password: hashedPassword,
      status: 0,
    }).save();

    //register user
    const user = UserRegistration({
      loginId: logintb._id,
      name: name,
      phone: phone,
      email: email,
      password: hashedPassword,
    });

    await user.save();
    res.status(201).json({ message: "User registered successfully" });
  } catch (error) {
    console.error("Error registering user:", error);
    res
      .status(500)
      .json({ message: "An error occurred while registering user" });
  }
});

//user login
authRoute.post("/login", async (req, res) => {
  const { email, password } = req.body;

  console.log(req.body);

  try {
    const user = await LoginModel.findOne({ email });
    if (!user) {
      return res.status(400).json({ message: "User not found" });
    }

    const isPassword = await bcryptjs.compare(password, user.password);

    if (isPassword) {
      return res.status(200).json({
        message: "Success",
        data: user,
      });
    } else {
      return res.status(400).json({
        message: "User not found",
      });
    }
  } catch {
    res.status(500).json({ message: "Somthing went wrong" });
  }
});



//staff registration
authRoute.post("/staff/signup", async (req, res) => {
  try {
    const { name, phone, email, password } = req.body;

    const hashedPassword = await bcryptjs.hash(password, numSaltRounds);

    const existingUser = await StaffRegistration.findOne({ phone });
    if (existingUser) {
      return res
        .status(400)
        .json({ message: "Phone number already registered" });
    }

    const existingUserEmail = await StaffRegistration.findOne({ email });
    if (existingUserEmail) {
      return res.status(400).json({ message: "Email already registered" });
    }
    const logintb = await LoginModel({
      role: "staff",
      email: email,
      password: hashedPassword,
      status: 0,
    }).save();

    //register staff
    const staff = StaffRegistration({
      loginId: logintb._id,
      name: name,
      phone: phone,
      email: email,
      password: hashedPassword,
    });

    await staff.save();
    res.status(201).json({ message: "User registered successfully" });
  } catch (error) {
    console.error("Error registering user:", error);
    res
      .status(500)
      .json({ message: "An error occurred while registering user" });
  }
});



module.exports = authRoute;
