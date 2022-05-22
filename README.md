# student-blockchain

# Student-Network

	To run the hyperledger fabric and deploy chaincode to channel we need to install some prerequisites as follows:=

	a).
	==========> Install Curl ==============================
	sudo apt update
	sudo apt install curl
	
	Once the installation is complete, verify it by typing curl in your terminal:

	curl

	  
	b).
	==========> Install docker ===================

	Update the apt package index and install packages to allow apt to use a repository over HTTPS:

	https://docs.docker.com/engine/install/ubuntu/

	
	sudo apt-get update

	sudo apt-get install ca-certificates -y

	sudo apt-get install curl 

	sudo apt-get install gnupg 

	sudo apt-get install lsb-release

	
	========> Add Docker’s official GPG key:

	  
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

	  
	==========> Install Docker Engine


	echo \

	"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \

	$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


	Update the apt package index, and install the latest version of Docker Engine and containerd, or go to the next step to install a specific version:

	 
	sudo apt-get update


	sudo apt-get install docker-ce docker-ce-cli containerd.io


	Verify that Docker Engine is installed correctly

	  

	sudo docker run hello-world


	c).==============================
	==========> Install jq
	sudo apt-get install jq
	
	
	.==============================
	Install GIT in system

	sudo apt-get install git



	d).====================================================
	==============> Linux Post install steps

	https://docs.docker.com/engine/install/linux-postinstall/

	  

	sudo groupadd docker

	sudo usermod -aG docker $USER

	newgrp docker

	  

	==========> Installing Docker Compose 

	sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose


	Next, set the correct permissions so that the docker-compose command is executable:

	  

	sudo chmod +x /usr/local/bin/docker-compose


	To verify that the installation was successful run:


	docker-compose --version


	e).===============================================================================================
	=============> Install Go language:


	curl -OL https://golang.org/dl/go1.16.7.linux-amd64.tar.gz


	To verify the integrity of the file you downloaded, run the sha256sum command and pass it to the filename as an argument:

	  
	**sha256sum go1.16.7.linux-amd64.tar.gz**

	Then unzip the files

	  

	sudo tar -C /usr/local -xvf go1.16.7.linux-amd64.tar.gz
	  
	f). =========================================================
	==============> Setting Go Paths

	 
	In this step, you will set paths in your environment

	sudo apt-get install nano

	sudo nano $HOME/.profile

	  
	Then, add the following information to the end of your file:

	  
	export PATH=$PATH:/usr/local/go/bin



	then hit **ctrl+x** then y and then enter key

	  

	Next, refresh your profile by running the following command:

	  

	source $HOME/.profile
	g).
	  
	check go version

	`go version`

	
	
	=======> Hyperledger Fabric Installation

	  
	For reference link is 
	https://hyperledger-fabric.readthedocs.io/en/release-2.2/install.html

	  
	Open terminal
	path should be 
	cd /home/${user}

	  
	if system user name is abc 
	for eg. cd /home/abc

	 
	Install Fabric binaries

	curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.2.0

	 
	This will clone the fabric-samples repository

	  

	================> Clone the repository

	=====> clone the repo in home directory at the same level where fabric-samples is cloned at $HOME DIRECOTORY <=====


	https://github.com/harjot-debut/student-blockchain.git
	
	
	
	Steps to start the student network

	1).	Open the student-blockchain folder in terminal 

	       go to network folder inside network folder using command:=
		cd network 
	       
	       
	       
	2). Run following commands
		
		chmod +x network.sh

		chmod +x deploy-chaincode.sh

        chmod +x chaincode-query.sh
		
		
		
	3).	Run the following command to down any network if running already
		./network.sh down	
		
	4).	To start the network and create hannel run the following command :
		./network.sh up createChannel
		
		The createChannel command creates a channel named mychannel with two channel members, Org1 and Org2. The command also joins a peer that belongs to each organization to the channel. 
		
		===================> set DNS enteries in /etc/hosts file
		sudo nano /etc/hosts 

		127.0.0.1  peer0.org1.example.com
		127.0.0.1  peer0.org2.example.com
		127.0.0.1  peer1.org1.example.com
		127.0.0.1  peer1.org2.example.com
		127.0.0.1  orderer.example.com

		
	5). 	Go to chaincode directory that is by hitting command:
		cd ../chaincode/student-record-system

	6).	run the following commmand inside this folder to insatll go packages into vendor folder :=
		GO111MODULE=on go mod vendor
		
	7).	 Again go to network folder using command :=
		cd ../../network
		
	8).	To deploy chaincode to channel run the following command inside network folder:=
		./deploy-chaincode.sh

    9). To invoke and query chaincode to channel run the following command inside network folder:=
		./chaincode-query.sh    


    10).
	Open browser http://localhost:5984/_utils/#database

    This link is used to open couchdb world state
	Login Credentials 
	Username: admin
	Password: adminpw


	 

