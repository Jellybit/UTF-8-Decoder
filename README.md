# UTF-8 Decoder
A PowerShell script with a GUI designed to decode text corrupted by encoding mismatches, converting it from ISO-8859-1 to UTF-8 for proper display of special and non-English characters.

I created this tool to solve a recurring issue where text, like city names or imported data, appears garbled (e.g., `Hà Nội` as `HÃ  Ná»i` or `Сочи` as `Ð¡Ð¾ÑÐ¸`) due to encoding errors. Websites and apps often misinterpret text saved in legacy encodings like ISO-8859-1 as UTF-8, scrambling characters from languages with unique scripts. This script provides an easy way to decode and correct that text.

<img width="750" height="688" alt="image" src="https://github.com/user-attachments/assets/3998f244-502f-4752-8185-eb4fadc8be18" />

## Features

* **Text Decoding:**
  - Converts text from ISO-8859-1 (Latin-1) encoding to UTF-8, restoring special characters in original languages like Vietnamese, Thai, and Russian.
  - Handles input like:
    - Before: `HÃ  Ná»i` → After: `Hà Nội`
    - Before: `à¸à¸£à¸¸à¸à¹à¸à¸à¸¡à¸«à¸²à¸à¸à¸£` → After: `กรุงเทพมหานคร`
    - Before: `Ð¡Ð¾ÑÐ¸` → After: `Сочи`
* **User-Friendly GUI:**
  - Input corrupted text in a text box with a "Paste text here..." placeholder that clears on focus.
  - Displays decoded text in a read-only output box.
  - Features a "Copy Text" button to copy the corrected result to the clipboard.

### Steps to Use:
- **Enter Corrupted Text:**
  - Click into the "Corrupted Text" input box (starting with "Paste text here..." in gray) and paste or type the garbled text.
  - The placeholder will vanish when you begin typing.
- **Decode Text:**
  - Click the "Decode Text" button to convert the input from ISO-8859-1 to UTF-8.
  - The corrected text will appear in the "Decoded Text" box below.
- **Copy Decoded Text:**
  - Click the "Copy Text" button to copy the decoded text to your clipboard.
  - You’ll see a confirmation message, or an error if the output is empty.
  - You may also highlight and copy any text you want using the OS copy shortcut.

## Important Notes

* **Encoding Focus:** This tool is tailored for ISO-8859-1 to UTF-8 conversion. It won’t correct text already in UTF-8 or other encodings.
* **Permissions:** Requires standard PowerShell execution rights. Run as Administrator if clipboard or GUI issues occur.
* **PowerShell Version:** Compatible with PowerShell 5.1 or later (included with Windows 10/11). Tested with PowerShell 7.

## Compile Standalone

To create a standalone executable without the console window, follow these steps in PowerShell:

```powershell
Install-Module ps2exe
Set-ExecutionPolicy RemoteSigned -Scope Process -Force
ps2exe "UTF8Decoder.ps1" "UTF8Decoder.exe" -noConsole
