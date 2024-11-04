require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- set the default shell as powershell for windows
local uname = vim.loop.os_uname()

-- Check if the OS is Windows and set the shell accordingly
if uname.sysname == "Windows_NT" then
  o.shell = "pwsh"  -- Use PowerShell (pwsh) on Windows
else
  o.shell = "/bin/bash"  -- Use Bash or any preferred shell on non-Windows systems
end

-- scrolloff: This option determines how many lines to keep above and below the cursor. Setting it to a high value (like 999) effectively keeps the cursor centered when scrolling.

o.scrolloff = 999

-- relative line number
o.relativenumber = true

-- disable system clipboard
o.clipboard = ""
