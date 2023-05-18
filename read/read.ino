#include <SPI.h>
#include <MFRC522.h>
#include "BluetoothSerial.h"
 
#define SS_PIN 5
#define RST_PIN 27
MFRC522 mfrc522(SS_PIN, RST_PIN);
BluetoothSerial SerialBT;

void setup() {
  Serial.begin(9600);
  SPI.begin();
  mfrc522.PCD_Init();
  Serial.println("reading...");
  Serial.println();
  SerialBT.begin("animal");
}

void loop() {  

  if ( ! mfrc522.PICC_IsNewCardPresent() || ! mfrc522.PICC_ReadCardSerial()) {  // check if chip is present
    return;
  }

  String id = "";  // get UID
  for (byte i = 0; i < mfrc522.uid.size; i++) {
     id.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " "));
     id.concat(String(mfrc522.uid.uidByte[i], HEX));
  }
  id.toUpperCase();

  SerialBT.println(id);  // send UID

  delay(2500);
}
