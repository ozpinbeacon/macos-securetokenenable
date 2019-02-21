# macos-securetokenenable
Enables macOS secure token for previously assigned user

Using variables from Jamf and DEPNotify, assigns a secure token to the previously assigned user.

Ensure the Jamf variables $4 and $5 are set to a local administrator user name and password respectively.
Also ensure that DEPNotify is up to date as the .plist file locations have changed as of 1.1.2
