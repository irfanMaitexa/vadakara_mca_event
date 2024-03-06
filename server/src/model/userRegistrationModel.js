const  mongoose = require('mongoose');

const userRegistrationSchema =  mongoose.Schema({
  loginId:{
    type: String,
    required: true,
  },
  name: {
    type: String,
    required: true
  },
  phone: {
    type: String,
    required: true
  },
  email: {
    type: String,
    required: true
  },
  password: {
    type: String,
    required: true
  }
});

const UserRegistration = mongoose.model('UserRegistration', userRegistrationSchema);

module.exports = UserRegistration;
