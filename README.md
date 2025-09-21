# 🌳 Enhanced `tree` Command for Windows (PowerShell/CMD) - `trees`

Tired of the basic `tree /f` command in Windows Command Prompt? Meet `trees`! This PowerShell-based utility not only displays your directory and file structure, but also dives into the content of specified file types, all while elegantly ignoring common development-related folders.

---

## ✨ Features

*   **File Content Display:** View the full content of `txt`, `py`, `cpp`, `h`, `js`, `json`, `xml`, `ps1`, `md`, `log`, `ini`, `conf`, `html`, `css` files directly in the output. No more guessing what's inside! 📄
*   **Intelligent Folder Exclusion:** Automatically ignores noisy development directories like `.venv`, `.env`, `.git`, `.vscode`, `node_modules`, and `target` to keep your output clean and focused. 🚫
*   **Customizable:** Easily extend the list of file extensions to display or add more folders to ignore. 🛠️
*   **Friendly Output:** Uses clear, tree-like ASCII characters for easy readability.
*   **UTF-8 Support:** Handles Unicode characters gracefully in file contents.

---

## 🚀 Installation

Follow these steps to get `trees` up and running on your Windows machine.

### 1. Download the Files 📦

You have two options to get the `trees.ps1` and `trees.bat` files:

*   **Clone the Repository (Recommended):**
    If you have Git installed, open your terminal (Command Prompt or PowerShell) and run:
    ```bash
    git clone https://github.com/satifiedx/New-tree-command-for-windows.git
    cd New-tree-command-for-windows
    ```
    This will create a new folder named `New-tree-command-for-windows` containing the necessary files.

*   **Download ZIP:**
    Go to the GitHub repository page, click the green "Code" button, and select "Download ZIP". Extract the contents of the ZIP file to a location of your choice, e.g., `C:\Users\YOUR_USERNAME\Scripts\` or `C:\tools\`.

Make sure you have both `trees.ps1` and `trees.bat` in the same directory. Let's assume for the next steps that you've placed them in `C:\Users\YOUR_USERNAME\Scripts\` (replace `YOUR_USERNAME` with your actual username).

### 2. Adjust PowerShell Execution Policy (One-Time Setup) 🔐

By default, PowerShell might block script execution for security reasons. You need to allow local scripts to run:

1.  Open **PowerShell as an Administrator** (search "PowerShell", right-click, "Run as administrator").
2.  Execute the following command:
    ```powershell
    Set-ExecutionPolicy RemoteSigned
    ```
3.  Type `A` and press Enter when prompted.

### 3. Add to System PATH (For Global Access) 🌐

To use `trees` from any directory in Command Prompt or PowerShell, add the folder containing `trees.bat` to your system's `PATH` environment variable:

1.  Press `Win + R`, type `sysdm.cpl`, and press Enter.
2.  Go to the "Advanced" tab.
3.  Click "Environment Variables...".
4.  In the "User variables for YOUR_USERNAME" section (or "System variables" if you want it for all users), find the `Path` variable, select it, and click "Edit...".
5.  Click "New" and add the full path to your script folder (e.g., `C:\Users\YOUR_USERNAME\Scripts\`).
6.  Click "OK" on all open windows.
7.  **Important:** Close and reopen any Command Prompt or PowerShell windows for the changes to take effect.

---


## 💡 Usage

Open a new Command Prompt (CMD) or PowerShell window and try these commands:

*   To display the current directory:
    ```cmd
    trees
    ```
  

*   To display a specific directory (e.g., `C:\MyProject`):
    ```cmd
    trees C:\MyProject
    ```
---

## ⚙️ Customization

You can easily tailor `trees.ps1` to your needs:

1.  **Open `trees.ps1`** in a text editor.
2.  Locate the `param` block at the beginning of the `Show-TreeWithContent` function:

    ```powershell
    function Show-TreeWithContent {
        param (
            # ...
            [string[]]$ExtensionsToDisplayContent = @(".txt", ".py", ".cpp", ".h", ".js", ".json", ".xml", ".ps1", ".md", ".log", ".ini", ".conf", ".html", ".css"),
            [string[]]$DirectoriesToIgnore = @(".venv", ".env", ".git", ".vscode", "node_modules", "target")
        )
    ```

3.  **To add/remove file extensions:** Modify the `ExtensionsToDisplayContent` array. E.g., to add `.jsonc`:
    ```powershell
    [string[]]$ExtensionsToDisplayContent = @(".txt", ..., ".css", ".jsonc"),
    ```

4.  **To add/remove ignored directories:** Modify the `DirectoriesToIgnore` array. E.g., to ignore `build`:
    ```powershell
    [string[]]$DirectoriesToIgnore = @(".venv", ..., "target", "build")
    ```

5.  **Save the `trees.ps1` file** again, ensuring it's still saved with **UTF-8 with BOM** encoding.

---

## 📜 Example Output

```
MyProject\
├───docs\
│   └───README.md
│       ----- FILE CONTENT: README.md -----
│       # My Awesome Project
│       This is a cool project that does cool things.
│       ----- END FILE CONTENT -----
├───src\
│   ├───main.py
│   │   ----- FILE CONTENT: main.py -----
│   │   def hello_world():
│   │       print("Hello, World!")
│   │
│   │   if __name__ == "__main__":
│   │       hello_world()
│   │   ----- END FILE CONTENT -----
│   └───style.css
│       ----- FILE CONTENT: style.css -----
│       body {
│           font-family: Arial, sans-serif;
│           margin: 20px;
│       }
│       ----- END FILE CONTENT -----
└───.gitignore
```

---

## ❤️ Contributing

Feel free to fork this repository, open issues, or submit pull requests with improvements or new features!

---