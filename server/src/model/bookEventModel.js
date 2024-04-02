const mongoose = require('mongoose');

const bookEventSchema = new mongoose.Schema({

    loginId:{
        type: mongoose.Schema.ObjectId,
        ref:  'logins',
    },

    category: {
        type: String,
        required: true
    },
    date: {
        type: Date,
        required: true
    },
    address: {
        type: String,
        required: true
    },
    squarefeet: {
        type: String,
        required: true
    },
    budget: {
        type: String,
        required: true
    },
    peoplecount:{
        type: Number,
        required: true

    }
});

const BookEvent = mongoose.model('BookEvent', bookEventSchema);

module.exports = BookEvent;
