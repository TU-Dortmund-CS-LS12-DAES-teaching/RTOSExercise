#include <Arduino.h>
#include <Arduino_JSON.h>
#include <Fonts/FreeMonoBold12pt7b.h>
#include <Fonts/FreeMonoBold18pt7b.h>
#include <Fonts/FreeMonoBold24pt7b.h>
#include <Fonts/FreeMonoBold9pt7b.h>
#include <GxEPD2_BW.h>

#include "Display.h"

#define BOTTOM_LEFT 26
#define TOP_LEFT 25
#define BOTTOM_RIGHT 4
#define TOP_RIGHT 35
#define DISPLAY_CS 5
#define DISPLAY_RES 9
#define DISPLAY_DC 10
#define DISPLAY_BUSY 19

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

GxEPD2_BW<WatchyDisplay, WatchyDisplay::HEIGHT> display(WatchyDisplay(DISPLAY_CS, DISPLAY_DC, DISPLAY_RES, DISPLAY_BUSY));

void buttonWatch(void *pvParameters) {
    printf("run");
    for (;;) {
        if (digitalRead(BOTTOM_LEFT) == HIGH) {
            printf("Bottom Left pressed!");
            display.fillRoundRect(0, 150, 50, 50, 20, GxEPD_BLACK);
            display.display(true);
            vTaskDelay(500);
            display.fillRoundRect(0, 150, 50, 50, 20, GxEPD_WHITE);
            display.display(true);
        } else if (digitalRead(BOTTOM_RIGHT) == HIGH) {
            printf("Bottom Right pressed!");
            display.fillRoundRect(150, 150, 50, 50, 20, GxEPD_BLACK);
            display.display(true);
            vTaskDelay(500);
            display.fillRoundRect(150, 150, 50, 50, 20, GxEPD_WHITE);
            display.display(true);
        } else if (digitalRead(TOP_LEFT) == HIGH) {
            printf("Top Left pressed!");
            display.fillRoundRect(0, 0, 50, 50, 20, GxEPD_BLACK);
            display.display(true);
            vTaskDelay(500);
            display.fillRoundRect(0, 0, 50, 50, 20, GxEPD_WHITE);
            display.display(true);
        } else if (digitalRead(TOP_RIGHT) == HIGH) {
            printf("Top Right pressed!");
            display.fillRoundRect(150, 0, 50, 50, 20, GxEPD_BLACK);
            display.display(true);
            vTaskDelay(500);
            display.fillRoundRect(150, 0, 50, 50, 20, GxEPD_WHITE);
            display.display(true);
        }
    }
}

void setup() {
    /* Setting button pins to be inputs, always necessary at the start. */
    pinMode(BOTTOM_LEFT, INPUT);
    pinMode(BOTTOM_RIGHT, INPUT);
    pinMode(TOP_LEFT, INPUT);
    pinMode(TOP_RIGHT, INPUT);

    /* Init the display. */
    display.epd2.selectSPI(SPI, SPISettings(20000000, MSBFIRST, SPI_MODE0));
    display.init(0, true, 10, true);
    display.setFullWindow();
    display.fillScreen(GxEPD_WHITE);
    display.setTextColor(GxEPD_BLACK);
    display.setFont(&FreeMonoBold24pt7b);
    display.setCursor(0, 90);
    display.print("Hello\nWorld!");
    display.display(false);

    /* Only priorities from 1-25 possible. */
    xTaskCreate(buttonWatch, "watch", 4096, NULL, 1, NULL);

    /* Start the scheduler to start the tasks executing. */
    vTaskStartScheduler();

    /* The following line should never be reached because vTaskStartScheduler()
    will only return if there was not enough FreeRTOS heap memory available to
    create the Idle and (if configured) Timer tasks.  Heap management, and
    techniques for trapping heap exhaustion, are described in the book text. */
    for (;;)
        ;
    return;
}

void loop() {
}
