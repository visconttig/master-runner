# 🧙‍♂️ master-runner.ahk — The Autohotkey Necromancer

> Automatically (and majestically) launches all your AHK scripts at system startup... like a boss.
> Runs them as admin. Kills old clones. Exiles legacy junk. Logs its conquests.
> It's basically the Gandalf of your automation kingdom.

---

## 🤔 What is this wizardry?

This script scans a chosen folder — and **all its subfolders** — looking for `.ahk` scripts.
Then, like a caffeinated butler, it launches each one for you on boot.

It also:

- 💥 **Terminates any old running instance** of each script (no duplicates, no popup nags).
- 🔎 **Skips "legacy", "reference", "testing", and "utilities" folders** (we don’t talk about them).
- 🪪 **Does NOT relaunch itself**, even if it lives in the target folder.
- 🪵 **Logs everything** to a file (so you can feel like a hacker reading it).
- 🛡️ Is designed to be run **as admin**, so all your scripts run with god-mode powers.

---

## 📁 Folder Setup

Put all your glorious `.ahk` scripts inside one root folder (e.g. `C:\MyScripts\`), like this:

```
C:\MyScripts\
├── launch-bar.ahk
├── vim-mouse-nav.ahk
├── legacy\       ← Skipped automatically
├── utilities\    ← Skipped automatically
├── master-runner.ahk  ← Can live here, no problem
```

You can change the root folder in the script by modifying this line:

```ahk
targetFolder := "C:\Users\visco\OneDrive\Desktop\html-projects"
```

---

## 🧙 How to Make It Run on Boot (as Admin!)

Windows won't let you run AHK scripts as admin just by putting them in the Startup folder.
So instead, we harness **Task Scheduler**, the most underrated dungeon in Windows.

Here’s how to summon your script at startup, with full admin rights:

### 📜 Step-by-step:

1. **Open Task Scheduler**
   Hit Start, type “Task Scheduler”, open it.

2. **Create a New Task**

   - Click **“Create Task”** (not _Basic Task_, we need advanced juju).
   - Name it something like: `AHK-Master-Runner`.

3. **General Tab**

   - ✔️ Check “Run with highest privileges”
   - 👤 Choose “Run only when user is logged on” (unless you’re a sysadmin robot)
   - 👔 Optional: Set user to SYSTEM if you want the scripts to run before your coffee brews.

4. **Triggers Tab**

   - Click **New\...**
   - Begin the task: “At log on”
   - ✔️ Specific user: _You_
   - ✔️ Enabled

5. **Actions Tab**

   - Click **New\...**
   - Action: “Start a program”
   - **Program/script**: Browse and select `AutoHotkey.exe`
   - **Add arguments**: `"C:\Path\To\master-runner.ahk"`

6. **Conditions / Settings Tab**

   - Uncheck anything you don't like. Especially “Start only if on AC power” (laptops be wildin’).

7. **Save it**, close Task Scheduler, and reboot. Voilà!

---

## 🛠️ How It Works (In Human Terms)

1. 🛌 Waits a few seconds for Windows to get its pants on.
2. 🔎 Walks through your script folder, peeking in every drawer (subfolder).
3. 🧹 Skips any folders with names like “legacy”, “testing”, etc. (even if they’re shouting in CAPS).
4. 🧼 If it finds a script that’s already running, it slaps it into oblivion.
5. 🚀 Then it launches the fresh version of the script.
6. 📓 Writes down what it did in a log file (like a responsible sorcerer).

---

## 📖 Sample Log Output

```
Terminated: C:\MyScripts\vim-mouse-nav.ahk
Launched:   C:\MyScripts\vim-mouse-nav.ahk
Launched:   C:\MyScripts\hyper-launcher.ahk
```

Logs are written to:

```
<wherever master-runner.ahk lives>\ahk-launch-log.txt
```

---

## 😱 Common Gotchas

- ❗ **Scripts that don’t have `#SingleInstance Force`** may throw a “Replace?” popup.
  Fix: Add `#SingleInstance Force` to the top of every script (your automation future self will thank you).

- 🧍 **Task Scheduler set to run only when plugged in** might silently skip your script on battery.

- 🐛 Accidentally putting multiple copies of `master-runner.ahk` inside the folder = ✨chaotic infinite loop✨.
  (You've been warned.)

---

## 💬 Why?

Because dragging scripts into the Startup folder is for peasants.
Because right-click → "Run as admin" is a click too far.
Because you’re building an _AHK-powered empire_, and every empire needs a launch commander.

---

## 🧪 Bonus Ideas

- 🔁 Add a timer to re-scan every X minutes and re-launch crashed scripts.
- 📦 Make a portable version for USB tools.
- 🧵 Multi-thread it? (Just kidding — it’s AHK v1, lol.)

---

## 🧼 Credits & License

Crafted by a sleep-deprived automation enthusiast.
MIT License — launch responsibly.
