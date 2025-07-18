# Linux User Setup Script

A Bash script to automate Linux user creation, group assignment, and logging for DevOps or IT environments.

## Features

- Adds a new system user
- Automatically adds to the `users` group or a group you specify
- Sets a default password for the new user
- Logs actions to a custom log file with timestamps
- Prevents duplicate users
- Checks for root/sudo privileges

## Requirements

- Must be run as root (use `sudo`)
- Bash shell
- Linux system with `useradd`, `usermod`, and `chpasswd` commands available

## Usage

You can run the script in two ways:

### 1. With Prompts (interactive)

If you run the script without arguments, it will prompt you for a username:

```bash
sudo ./user_setup.sh
```

### 2. With Arguments (non-interactive)

You can provide the username (and optionally, a group) as arguments:

```bash
sudo ./user_setup.sh username
```

or, to specify a group:

```bash
sudo ./user_setup.sh username groupname
```

**Example:**

```bash
sudo ./user_setup.sh alice
```

Creates user `alice`, adds to the `users` group, and sets the default password.

```bash
sudo ./user_setup.sh bob devops
```

Creates user `bob`, adds to the `devops` group, and sets the default password.

## Logging

- Actions are logged to `/var/log/user_setup.log` if possible.
- If not writable, logs are saved to `/tmp/user_setup.log`.

## Security Note

The default password is set in the script as `defaultpassword`.  
**It is strongly recommended to change the password after the first login.**

---
