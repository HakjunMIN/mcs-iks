Forked from https://github.com/fauria/vsftpd

Environment variables
----

This image uses environment variables to allow the configuration of some parameteres at run time:

* Variable name: `FTP_USER`
* Default value: admin
* Accepted values: Any string. Avoid whitespaces and special chars.
* Description: Username for the default FTP account. If you don't specify it through the `FTP_USER` environment variable at run time, `admin` will be used by default.

----

* Variable name: `FTP_PASS`
* Default value: Random string.
* Accepted values: Any string.
* Description: If you don't specify a password for the default FTP account through `FTP_PASS`, a 16 characters random string will be automatically generated. You can obtain this value through the [container logs](https://docs.docker.com/reference/commandline/logs/).

----

* Variable name: `PASV_ADDRESS_ENABLE`
* Default value: NO
* Accepted values: <NO|YES>
* Description: Enables / Disables Passive Mode

----

* Variable name: `PASV_ADDRESS_RESOLVE`
* Default value: YES
* Accepted values: <NO|YES>
* Description: Set to YES if you want to use a hostname (as opposed to IP address) in the `PASV_ADDRESS` option.

----

* Variable name: `PASV_ADDRESS`
* Default value: Docker host IP / Hostname.
* Accepted values: Any IPv4 address or Hostname (see PASV_ADDRESS_RESOLVE).
* Description: If you don't specify an IP address to be used in passive mode, the routed IP address of the Docker host will be used. Bear in mind that this could be a local address.

----

* Variable name: `PASV_ADDR_RESOLVE`
* Default value: NO.
* Accepted values: YES or NO.
* Description: Set to YES if you want to use a hostname (as opposed to IP address) in the PASV_ADDRESS option.

----

* Variable name: `PASV_ENABLE`
* Default value: YES.
* Accepted values: YES or NO.
* Description: Set to NO if you want to disallow the PASV method of obtaining a data connection.

----

* Variable name: `PASV_MIN_PORT`
* Default value: 21100.
* Accepted values: Any valid port number.
* Description: This will be used as the lower bound of the passive mode port range. Remember to publish your ports with `docker -p` parameter.

----

* Variable name: `PASV_MAX_PORT`
* Default value: 21110.
* Accepted values: Any valid port number.
* Description: This will be used as the upper bound of the passive mode port range. It will take longer to start a container with a high number of published ports.

----

* Variable name: `XFERLOG_STD_FORMAT`
* Default value: NO.
* Accepted values: YES or NO.
* Description: Set to YES if you want the transfer log file to be written in standard xferlog format.

----

* Variable name: `LOG_STDOUT`
* Default value: Empty string.
* Accepted values: Any string to enable, empty string or not defined to disable.
* Description: Output vsftpd log through STDOUT, so that it can be accessed through the [container logs](https://docs.docker.com/reference/commandline/logs/).

----

* Variable name: `FILE_OPEN_MODE`
* Default value: 0666.
* Accepted values: File system permissions.
* Description: The permissions with which uploaded files are created. Umasks are applied on top of this value. You may wish to change to 0777 if you want uploaded files to be executable.

----

* Variable name: `LOCAL_UMASK`
* Default value: 077.
* Accepted values: File system permissions.
* Description: The value that the umask for file creation is set to for local users. NOTE! If you want to specify octal values, remember the "0" prefix otherwise the value will be treated as a base 10 integer!
