#Shell Script that will read a CSV file that contains 20 new Linux users.

userfile=$(cat names.csv)
PASSWORD=password

	if [ $(id -u) -eq 0 ]; then
	
#Reading the CSV file

	for user in $userfile;
	do
		echo $user
	if id "$user" &>/dev/null
	then
		echo "User Exist"
	else
	
# This will create a new user
	useradd -m -d /home/$user -s /bin/bash -g developers $user
	echo "New User Created"
	echo

# This will create an ssh folder in the user home foolder
    su - -c "mkdir ~/.ssh" $user
    echo ".ssh directory created for new user"
    echo

# We need to set the user permission for the ssh dir
    su - -c "chmod 700 ~/.ssh" $user
    echo "user permission for .ssh directory set"
    echo

# We need to set permission for the key file
	su - -c "chmod 600 ~/.ssh/authorized_keys" $user
    echo "user permission for the Authorized Key File set"
    echo

# We need to create and set public key for users in the server
    cp -R "/root/onboard/id_rsa.pub" "/home/$user/.ssh/authorized_keys"
    echo "Copied the Public Key to New User Account on the server"
    echo
    echo

    echo "USER CREATED"

# Generate a password
sudo echo -e "$PASSWORD\n$PASSWORD" | sudo passwd "$user"
sudo passwd -x 5 $user
            fi
        done
    else
    echo "Only Admin can onboard a user"
    fi
		
	
	

