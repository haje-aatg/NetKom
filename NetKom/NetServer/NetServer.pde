// Based on https://processing.org/reference/libraries/net/Server.html
// https://processing.org/reference/libraries/net/Server_write_.html
// https://processing.org/reference/libraries/net/serverEvent_.html
// https://processing.org/reference/libraries/net/disconnectEvent_.html
// https://processing.org/reference/libraries/net/Server_stop_.html

import processing.net.*;

Server myServer;
boolean myServerRunning = false;
int val = 0;
int port = 5204;//10002

void setup() {
  size(350, 200);
  myServer = new Server(this, port);  // Starts a myServer on port
  myServerRunning = true;
  //println("Server Running:" + "\t" + myServerRunning + " @ " + Server.ip());
  textSize(20);
}

void draw() {
  if (myServerRunning) {
    val = (val + 1) % 255;
    myServer.write(val);
  }
  background(val);
  fill(255-val);
  text("Server Running:", 10, 30);
  text(str(myServerRunning), 190, 30);
  text("IP:", 10, 50);
  text(Server.ip(), 190, 50);
}
// ServerEvent message is generated when a new client connects to an existing server.
void serverEvent(Server someServer, Client someClient) {
  println("We have a new client: " + someClient.ip());
  //text("We have a new client: " + someClient.ip(),10,80);
}

// ClientEvent message is generated when a client disconnects.
void disconnectEvent(Client someClient) {
  println("Client " + someClient.ip() + " Disconnected !");
}

void mousePressed() {  // Start / Stop Server
  if (myServerRunning) {
    myServerRunning = false;
    myServer.stop();
    myServer = null;
  } else {
    myServer = new Server(this, port); // Starts a server on port
    myServerRunning = true;
    //println(Server.ip());
  }
  //println("Server Status:" + "\t" + myServerRunning);
  //println("Server Running:" + "\t" + myServerRunning + " @ " + Server.ip());
}
