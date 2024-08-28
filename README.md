# Short guide for RouterOS scripting

## Description

We have ```Mikrotik RB951G-2HnD``` with ```7.15.3``` firmware in home network.
In that network also there are few servers.
Sometimes the electricity goes out.
Some servers can boot automatically after power recovery.
But one server can't.
Luckily this server supports power on by command ```wol``` [Wiki](https://en.wikipedia.org/wiki/Wake-on-LAN).

So we want to power up the server after power is restored by sending it a ```magic packet``` from the router right after it boots.

## Scripting

RouterOS built-in scripting language has some nuances:

- "Valid characters in variable names are letters and digits. If variable name contains any other character, then variable name should be put in double quotes";
- "Every variable must be declared before usage by local or global keywords";
- "Whitespace characters are not allowed
    between ```<parameter>=``` ```from=``` ```to=``` ```step=``` ```in=``` ```do=``` ```else=```";
Script is a siple txt file, but for executing must have ```rsc``` extension.
VSCode has few extensions for RouterOS script language.

## Sending to the router

There are few methods to send script to your router:

1) in command ```/system/script/ add name=wol-service source="put your script here as text";```;
2) from menu System-> Scripts in Winbox;
3) with ssh by scp command;
4) also you can use ftp for copying or editing script in place;

[YouTube](https://www.youtube.com/watch?v=IQiN39NQWnA)

## Scheduling

If scrip saved in ```file``` section of router with ```.rsc``` extension, it can be executed by command ```/ import <scriptname.rsc>```.
But for the shedueling script execution we need to create new item in the ```/system/script``` section.

It can be done by command ```/system/script/ add name=wol-service source=[ /file get wolservice.rsc contents ];```

After that we can add schedule:
```/system/scheduler/ add name=wakeup-debian on-event=wol-service start-time=startup interval=0```

[forum](https://forum.mikrotik.com/viewtopic.php?t=45274)
