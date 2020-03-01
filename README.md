# Dreamcatcher chat

Dreamcatcher chat is a program that allows you to communicate between two or
more [Othernet Dreamcatcher
devices](https://othernet.is/products/dreamcatcher-v3-05) using text messages.
The program takes advantage of the Dreamcatcher's built-in radio to establish
the connection.

<!-- vim-markdown-toc GFM -->

* [Note: Work in progress](#note-work-in-progress)
* [Installation](#installation)
  * [1. Log into the Dreamcatcher device using serial](#1-log-into-the-dreamcatcher-device-using-serial)
    * [Windows](#windows)
    * [Mac](#mac)
  * [2. Log in and connect to Internet](#2-log-in-and-connect-to-internet)
  * [3. Download and run the installer](#3-download-and-run-the-installer)
* [Starting the chat server manually](#starting-the-chat-server-manually)
* [Using the chat app](#using-the-chat-app)
* [Start the chat server automatically](#start-the-chat-server-automatically)

<!-- vim-markdown-toc -->

## Note: Work in progress

This project is a work in progress and may not work correctly (if at all). It
is made available for those who would like to try it anwyay and/or help with
the development. Please report any issues in the [issue
tracker](https://github.com/Othernet-Project/dreamcatcher-chat/issues).

## Installation

To install the chat app, you will follow the following steps:

### 1. Log into the Dreamcatcher device using serial

Dreamcatcher devices will allow a serial connection when plugged into a
computer using the micro USB port. You will need a micro USB cable for this. 
You will also need a serial terminal program such as [PuTTY](https://putty.org)
or [GNU screen](https://www.gnu.org/software/screen/).

#### Windows

On Windows computers, open the Device Manager. 

Plug in your Dreamcatcher using a micro USB port and wait for about a minute
for it to boot.

Look under "Ports (COM & LPT)". If the Dreamcatcher has successfully booted,
you should see a new COM port labelled "PI USB to Serial (COMx)" where "x" is
some number. Remember this number.

Open PuTTY. Under "Connection Type" select "Serial", and input "COMx" (again,
"x" is the number you saw in the Device Manager) in the "Serial line" box.
Check that "Speed" says 9600.

Click "Open" to start the connection.

#### Mac

On your Mac computer, run the following command in the terminal before
connecting the Dreamcatcher:

```
watch "ls /dev/tty.usbmodem*"
```

You may need to wait for a minute or so to see any changes.

Plug in the Dreamcatcher and wait for the output to show something like
"/dev/tty.usbmodemNNNNN". Copy that text and quit with Control+C.

In the terminal type `screen`, then paste the copied text, then `9600`. 
Suppose you got `/dev/tty.usbmodem141301`. Then your command would look like
this:

```
screen /dev/tty.usbmodem14301 9600
```

### 2. Log in and connect to Internet

If this is your first time logging into the Dreamcatcher, you will use "root"
as your username and "1234" as your password. You will be prompted to set the
new root password. Retype the default password, then type in your new password,
and confirm it once more.

After you set the root password, you will be prompted to create a new non-root
user. Follow the on-screen instructions to complete this step.

To connect the Dreamcatcher to Internet, you will use the following command:

```
nmtui
```

This will bring up a graphical interface that allows you to set up your
wireless connection. 

- Using the arrow keys, select the "Activate connection" menu item. 
- From the list, select your desired network and press Enter. 
- Enter the password and press Enter again. 
- Press Tab until <Back> is highlighted and press Enter to confirm.
- Navigate to Quit menu item and press Enter to end the program.

### 3. Download and run the installer

Type the following command to download and run the installer:

```
wget -qO- https://raw.githubusercontent.com/Othernet-Project/dreamcatcher-chat/master/install.sh | bash
```

(That's a letter O after q, not 0 in the above command.)

## Starting the chat server manually

You can start the chat server manually by typing:

```
start-chat
```

You will see a message that says "IP address NNN.NNN.NNN.NNN". This is the IP
address of your Dreamcatcher device on the wireless network to which it is
connected. On your computer, you will be able to access the chat app using a
Web browser by typing in that address followed by ":8080". For instance, if
your IP address is 192.168.0.4, then you would type this in the address bar:
192.168.0.4:8080.

## Using the chat app

When you open the chat app for the first time, you will see a form with some
settings. These are the radio settings. All Dreamcatcher devices that are
participating in the chat should use the same settings.

When you click "Connect", you will see the chat window. The line with the ":"
is where you type in your message. You messages will appear with "<" in front
of them, while incoming messages will appear with a ">".

**NOTE:** Currently, receiving messages may not work. We are working on fixing
this issue.

You can click "Disconnect" in the top-left corner to close the chat and go back
to the settings screen.

While the chat up is running normally, you will see the "PCKT" LED blink
continuously. This LED is located next to the LNB connector on the board, near
one of the heat sinks.

## Start the chat server automatically

If you wish to start the chat server automatically when Dreamcatcher boots,
type the following command:

```
systemctl enable chat
```

The chat app will start automatically when you turn on the Dreamcatcher next
time. This has the benefit of not having to log in in order to start it.

