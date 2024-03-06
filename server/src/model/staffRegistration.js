const  mongoose = require('mongoose');

const staffRegistrationSchema =  mongoose.Schema({
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

const StaffRegistration = mongoose.model('StaffRegistration', staffRegistrationSchema);

module.exports = StaffRegistration;
