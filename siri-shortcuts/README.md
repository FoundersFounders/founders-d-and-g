# Founders D&G

### Siri Shortcuts

iOS 12 introduced [Siri Shortcuts](https://support.apple.com/en-ca/guide/shortcuts/welcome/ios) that allows you to empower Siri with custom actions. Now, you can use voice commands to open Founders Founders doors!

## Features

### Location

There are a total of 4 different shortcuts that can be divided in 2 groups:

- The ones that have location awareness to prevent you from opening the doors while you are far from the building.
- The ones that do not have location awareness and open the door whenever you trigger them.

### Siri

The shortcuts simply send a message to Slack to open the respective door. You can add Siri triggers to the shortcuts so when you whenever say "Open Founders front door", the shortcut is executed.

## Installation

In this folder you can find 4 shortcuts:

- Open Founders front door (location enabled) ([link](Open%20Founders%20Front%20Door.shortcut))
- Open Founders garage door (location enabled) ([link](Open%20Founders%20Garage%20Door.shortcut))
- Open Founders front door (location disabled) ([link]((Without%20Location)%20Open%20Founders%20Front%20Door.shortcut))
- Open Founders garage door (location disabled) ([link]((Without%20Location)%20Open%20Founders%20Garage%20Door.shortcut))

Just open them on your iPhone or iPad and set up the access token.

You can copy the access token on the [app](../app/README.MD#the-app-itself) or copy it from [Founders Founders Door Services](http://www.founders-founders.com/doorservices/). Just place the access token on the text field of the shortcut that sets the variable `Token`.