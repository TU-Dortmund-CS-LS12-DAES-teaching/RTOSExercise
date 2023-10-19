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

#include "driver/uart.h"

GxEPD2_BW<WatchyDisplay, WatchyDisplay::HEIGHT> display(WatchyDisplay(DISPLAY_CS, DISPLAY_DC, DISPLAY_RES, DISPLAY_BUSY));

#define STOPWATCH_RUNNING 1
#define STOPWATCH_STOPPED 2
BaseType_t stopwatch_state=STOPWATCH_STOPPED;
BaseType_t stopwatch_counter=0;

void vStopwatchDisplay(void *pvParameters) {
    while(1){
        display.fillScreen(GxEPD_WHITE);
        display.setCursor(0, 90);
        display.println(stopwatch_counter);
        display.display(true);
    }
}

void vStopwatchInput(void *pvParameters) {
    while(1){
        if (digitalRead(TOP_LEFT) == HIGH) {
            //TODO Start/Stop the stopwatch
            vTaskDelay(1000);
        }
        if (digitalRead(TOP_RIGHT) == HIGH) {
            //TODO Reset the stopwatch
            vTaskDelay(1000);
        }
        vTaskDelay(100);
    }
}

void vStopwatchTimer(void *pvParameters) {
    //TODO Handle the stopwatch timer ticks
}

void UARTTask(void *pvParameters) {
    while(1){
        //TODO
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

    /* Only priorities from 1-25 possible. Tasks must be created in desending priority order*/
    xTaskCreate(UARTTask, "uart", 4096, NULL, 1, NULL);

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
