const expres = require('express')

const app = expres()



app.get('/users', (req, res) => {

    res.json({
        "message": "Users fatch",
        success: true,
        users: [
            {
                "name": "Jahan",
                "age": 32,
            },

            {
                "name": "Arif Gul",
                "age": 12,
            },
        ]
    })

});



app.listen(4010, () => console.log('Running on 4010'))