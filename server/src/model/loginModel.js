const mongoose = require('mongoose');

const loginSchema = new mongoose.Schema({
  role: {
    type: String,
    required: true
  },
  email:{
    type: String,
    required:true
  },
  password:{
    type: String,
    required:true
  },
  status:{
    type: Number,
    required:true
  }

});

const LoginModel = mongoose.model('Login', loginSchema);

module.exports = LoginModel;
