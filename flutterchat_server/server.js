const express = require('express')
const { listen } = require('socket.io')
const app = express()
const PORT = process.env.PORT || 3000

const server = app.listen(PORT, () => {
    console.log('Server is listening.')
})

const serverIO = require('socket.io')(server)

const users = {}
const rooms = {}
