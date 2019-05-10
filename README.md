# vpnkiller
I. Purpose: To locate specific vpn, stop any processes running, remove the app and report to management software.

II. Method: Locate specific vpn, their processes and convert to process identification, end these processes, delete the specific app if found and update the management software.

A. Variables: PROCESS (array), APP, NOW, LOGFILE

B. Used: Function (loop) for x in y; do z done

III. Script Outline: Set Process array variables, set app name, set function loop, if/then to detect process. Set PID as variables, kill PID(s), remove app with recursive force, update

IV. Take Aways: Note taking format developed, PID conversion, process killing

V. Questions: How can I improve error reporting?
