# Eve Home Alarm Manager

**Course:** PROG 49332 - Ubiquitous Computing (Winter 2019)  
**Authors:** Kevin Wei  
**Partner:** Da Xu  

## Background

This project was created as a component of an home alarm system with access control using commerical IoT devices. This system attempts to leverage the increasing popular hardware biometric authetnication in both Apple and Android devices (ie. fingerprint and facial recognition) as a means to authenticate users.

### Technology

This repository contains the management app written in Swift for adding in HomeKit enabled accessories. The code is based on the sample code provided by [Apple](https://developer.apple.com/documentation/homekit/configuring_a_home_automation_device).

#### Management Application
* Registering HomeKit enabled sensors
* Maintain user access list
* Create rooms
* Register users to Firebase
* Trigger notification in Firebase

#### [User Application](https://github.com/weiyih/eve-home-alarm-app)
* Receive notifications from Firebase  
* User biometric authentication  

### Hardware
* Apple iPhone
* [Elgato Eve Door & Window Contact Sensors](https://www.evehome.com/en/eve-door-window)

## Useful links  
* https://developer.apple.com/documentation/homekit/enabling_homekit_in_your_app
* https://developer.apple.com/documentation/homekit/configuring_a_home_automation_device  
