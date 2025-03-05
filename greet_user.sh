#!/bin/bash
# Greeting the user at login

#Checking if figlet is installed
if ! command -v figlet &> /dev/null; then
    echo "The figlet was not found. Install figlet to run this script.."
    exit 1
fi

#Checking if sl is installed
if ! command -v sl &> /dev/null; then
    echo "The sl was not found. Install sl to run this script.."
    exit 1
fi

# Launching the train
# sl

# Getting the user's name
USERNAME=$(whoami)

# We display a greeting
figlet "Hello, dear $USERNAME!"

# Additional message
figlet "Welcome to your Linux domain!"
