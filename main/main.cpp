#include <esp_log.h>

extern "C" void app_main() {
    for (;;) {
        ESP_LOGI("app_main", "Hello World");
    }
}
