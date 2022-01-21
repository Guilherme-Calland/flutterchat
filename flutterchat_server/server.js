const express = require('express')
const { listen } = require('socket.io')
const app = express()
const PORT = process.env.PORT || 4000

const s = app.listen(PORT, () => {
    console.log('Server is listening.')
})

const io = require('socket.io')(server)

const users = {}
const rooms = {}

io.on("connection", (socket) => {
    console.log("Server has connected to a new socket.")
    socket.emit('connection', "Socket has connected to a server.")
    socket.on('disconnect', () => {
        console.log('A socket has disconnected from the server.')
    })
})

io.on("validate", (inData, inCallback) => {
    const user = users[inData.userName]
    if(user) {
        if(user.password == inData.password){
            inCallback({ status : "ok" })
        } else {
            inCallback({ status : "fail" })
        }
    } else {
        users[inData.userName] = inData;
        io.broadcast.emit("newUser", users)
        inCallback({ status: "created" })
    }
})

io.on("create", (inData, inCallback) =>{
    if(rooms[inData.roomName]) {
        inCallback({status: "exists"})
    } else {
        inData.users = {}
        rooms[inData.roomName] = inData
        io.broadcast.emit("created", rooms)
        inCallback({ status : "created", "rooms" : rooms})
    }
})

io.on("listRooms", (inData, inCallback) => {
    inCallback(rooms)
})

io.on("listUsers", (inData, inCallback) => {
    inCallback(users)
})

io.on("join", (inData, inCallback) => {
    const room = rooms[inData.roomName]
    if(Object.keys(room.users).length == rooms.maxPeople){
        inCallback({ status: "full" })
    } else {
        rooms.users[inData.userName] = users[inData.userName]
        io.broadcast.emit("joined", room)
        inCallback({statud : "joined", room : room})
    }
})

io.on("post", (inData, Callback) => {
    io.broadcast.emit("posted", inData)
    inCallback({status : "ok"})
})

io.on("invited", (inData, inCallback) => {
    io.broadcast.emit("invited", inData)
    inCallback({status : "ok"})
})

io.on("leave", (inData, inCallback) => {
    const room = rooms[inData.roomName]
    delete room.users[inData.userName]
    io.broadcast.emit("left", room)
    inCallback({ status: "ok" })
})

io.on("close", (inData, inCallback) => {
    delete rooms[inData.roomName]
    io.broadcast.emit("closed", { roomName : inData.roomName , rooms : rooms})
    inCallback(rooms)
})

io.on("kick", (inData, inCallback) => {
    const room = rooms[inData.roomName]
    const users = room.users
    delete users[inData.userName]
    io.broadcast.emit("kicked", room)
    inCallback({ status = "ok" })
})
