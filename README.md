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
* [Start the chat server automatically](#start-the-chat-server-automatically)
* [Using the chat app](#using-the-chat-app)
* [Updating the chat app](#updating-the-chat-app)

<!-- vim-markdown-toc -->

## Note: Work in progress

This project is a work in progress and may not work correctly (if at all). It
is made available for those who would like to try it anwyay and/or help with
the development. Please report any issues in the [issue
tracker](https://github.com/Othernet-Project/dreamcatcher-chat/issues).

## Burning the OS Image and Installation of the Chat App

First download Armbian 5.67: 

https://archive.othernet.is/Dreamcatcher3%20Armbian/

Be sure to select Armbian 5.67, which is the second image on the list. Refer to the ReadMe on that page for detailed information, otherwise just use Balena Etcher to write the image to a microSD card. 

You can find Balena Etcher here: https://www.balena.io/etcher/

Once the image is ready, insert the microSD into your Dreamcatcher and turn the device on by plugging in the microUSB cable or holding the PWR button for 5 seconds. 

Install the chat app with the following steps. 

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
Check that "Speed" says 115200.

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
as your username and "1234" as your password. 

Default Amrbian Username and Password

Username: root

Password: 1234

You will be prompted to set the
new root password. Retype the default password, then type in your new password,
and confirm it once more.

After you set the root password, you will be prompted to create a new non-root
user. Follow the on-screen instructions to complete this step.

To connect the Dreamcatcher to Internet, you will use the following command:

```
sudo nmtui
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
wget --no-check-certificate -qO- https://raw.githubusercontent.com/Othernet-Project/dreamcatcher-chat/master/install.sh | sudo bash
```

(That's a letter O after q, not 0 in the above command.)

## Starting the chat server manually

You can start the chat server manually by typing:

```
sudo start-chat
```

You will see a message that says "IP address NNN.NNN.NNN.NNN". This is the IP
address of your Dreamcatcher device on the wireless network to which it is
connected. On your computer, you will be able to access the chat app using a
Web browser by typing in that address followed by ":8080". For instance, if
your IP address is 192.168.0.4, then you would type this in the address bar:
192.168.0.4:8080.

## Start the chat server automatically

If you wish to start the chat server automatically when Dreamcatcher boots,
type the following command:

```
sudo systemctl enable chat
```

The chat app will start automatically when you turn on the Dreamcatcher next
time. This has the benefit of not having to log in in order to start it.

## Using the chat app

When you open the chat app for the first time, you will see a form with some
settings. These are the radio settings. All Dreamcatcher devices that are
participating in the chat should use the same settings.

The "Callsign" setting is your callsign or a nickname that will appear to other
users of the chat app. This setting is saved in your browser and recalled every
time you start the chat app.

When you click "Connect", you will see the chat window. The text box at the
bottom is used to type messages. Send by pressing Enter or the "Send" button in
the bottom right corner.

You can click "Disconnect" in the top-left corner to close the chat and go back
to the settings screen.

While the chat up is running normally, you will see the "PCKT" LED blink
continuously. This LED is located next to the LNB connector on the board, near
one of the heat sinks.

## Updating the chat app

To update the chat app, run the installer like the first time. It will
overwrite the chat app. If you've set it to start on boot, you will need to
reboot the system or restart the chat server:

```
sudo systemctl restart chat
```

