// Based on https://processing.org/reference/libraries/net/Client.html
// https://processing.org/reference/libraries/net/Server_active_.html
// https://processing.org/reference/libraries/net/Client_read_.html
// https://processing.org/reference/libraries/net/disconnectEvent_.html

import processing.net.*; 

Client myClient; 
int dataIn; 
boolean myServerRunning = false;
int port = 5204;//10002  //Fix port to mirror Server port

void setup() { 
  size(350, 250);
  //myClient = new Client(this, "127.0.0.1", port);    // Works on same machine
  myClient = new Client(this, "10.113.40.193", port);  // Fix IP to servers IP
  textSize(20);
} 

void draw() { 
  if (myClient.active() == true) {
    myServerRunning = true;
    if (myClient.available() > 0) { 
      dataIn = myClient.read();
      //println(myClient.ip());
    }
  } else {
    myServerRunning = false;
    //println("Client is not active.");
  }
  background(dataIn);
  fill(255-dataIn);
  text("Server Connected:", 10, 30);
  text(str(myServerRunning), 190, 30);
  text("IP:", 10, 50);
  text(Server.ip(), 190, 50);
}

// ClientEvent message is generated when a client disconnects.
void disconnectEvent(Client someClient) {
  println("Server " + someClient.ip() + " Disconnected !");
  //println("From " + someClient.ip());
}

void mousePressed() {  // Start / Stop Client 
  if (myServerRunning) {
    myClient.stop();
  } else {
    myClient = new Client(this, "10.113.40.193", port);  // Fix IP to servers IP
  }
}
