const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const { json } = require("body-parser");
const authRoute = require("./src/routes/authRouter");
const userRoute = require("./src/routes/userRoutes");

const app = express();
const port = 3000;

//use pakges
app.use(express.json());
app.use(cors());

//app routes
app.use("/auth", authRoute);
app.use("/user",userRoute);

//connect with mongodb
mongoose
  .connect(
    "mongodb+srv://irfanmaitexa:irfanmaitexa@cluster0.nxwbsih.mongodb.net/event_db?retryWrites=true&w=majority&appName=Cluster0",
    {}
  )
  .then(() => {
    console.log("Connected to MongoDB");
  })
  .catch((error) => {
    console.error("Error connecting to MongoDB:", error);
  });

//create server
app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
