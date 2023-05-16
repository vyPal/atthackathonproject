#include <SPI.h>
#include <MFRC522.h>
 
#define SS_PIN 5
#define RST_PIN 27
MFRC522 mfrc522(SS_PIN, RST_PIN);

void setup() {
  Serial.begin(9600);
  SPI.begin();
  mfrc522.PCD_Init();
  // pinMode(, OUTPUT);
  // pinMode(, OUTPUT);
  // pinMode(, OUTPUT);
  Serial.println("reading...");  // sviceni zlute LEDky misto print
  // digitalWrite(, HIGH)  // set 
  Serial.println();
}

void loop() {
  if ( ! mfrc522.PICC_IsNewCardPresent()) {
    return;
  }
  if ( ! mfrc522.PICC_ReadCardSerial()) {
    return;
  }

  String content = "";  // get UID
  byte letter;
  for (byte i = 0; i < mfrc522.uid.size; i++) {
     Serial.print(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " ");
     Serial.print(mfrc522.uid.uidByte[i], HEX);
     content.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " "));
     content.concat(String(mfrc522.uid.uidByte[i], HEX));
  }
  content.toUpperCase();
  
  Serial.println();
  Serial.println("Rozsvitit zelenou LEDku");  // rozsviceni zelene LEDky misto print
  Serial.println("poslat UID do raspberry");
  delay(3000);
  /*
  digitalWrite(, LOW);  // set yellow to LOW
  digitalWrite(, HIGH);  // set green to HIGH
  Serial.println("poslat UID do raspberry");
  delay(3000);
  // pokud prijde signal z raspberry, ze UID neni v databazi -> rozsvitit cervenou LEDku
  */
} 