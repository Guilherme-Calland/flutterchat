const express = require('express')
const { listen } = require('socket.io')
const app = express()
const PORT = process.env.PORT || 4000

const s = app.listen(PORT, () => {
    console.log('Server is listening.')
})

const server = require('socket.io')(s)

const users = {}
const rooms = {}

server.on("connection", (socket) => {
    console.log("Server has connected to a new socket.")
    socket.emit('connection', "Socket has connected to a server.")
    socket.on('disconnect', () => {
        console.log('A socket has disconnected from the server.')
    })
})

server.on("validate", (inData, inCallback) => {
    const user = users[inData.userName]
    if(user) {
        if(user.password == inData.password){
            inCallback({ status : "ok" })
        } else {
            inCallback({ status : "fail" })
        }
    } else {
        users[inData.userName] = inData;
        server.broadcast.emit("newUser", users)
        inCallback({ status: "created" })
    }
})
