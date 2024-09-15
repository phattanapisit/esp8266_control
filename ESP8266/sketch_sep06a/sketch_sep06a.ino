#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>

const char* ssid = "";
const char* password = "";

ESP8266WebServer server(80);

const int ledPin = 2; // LED on GPIO2 (D4 on NodeMCU)

void setup() {
  Serial.println("Setup started");
  Serial.begin(115200);
  WiFi.begin(ssid, password);
  pinMode(ledPin, OUTPUT);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  
  Serial.println("");
  Serial.println("WiFi connected");

  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  
  server.on("/", handleRoot);
  server.on("/on", handleOn);
  server.on("/off", handleOff);
  server.begin();
  Serial.println("HTTP server started");
}

void loop() {
  server.handleClient();
}

void handleRoot() {
  server.send(200, "text/plain", "Welcome to ESP8266 Web Server!");
}

void handleOn() {
  digitalWrite(ledPin, LOW); // Turn the LED on
  server.send(200, "text/plain", "LED is ON");
}

void handleOff() {
  digitalWrite(ledPin, HIGH); // Turn the LED off
  server.send(200, "text/plain", "LED is OFF");
}
