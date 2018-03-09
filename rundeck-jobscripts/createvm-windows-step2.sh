#!/bin/bash
powerOnTimeout='75'
vmtemplateWin=$2
machineName=$1
vcenter_hostname=$3
baseDir='/home/ubadmin/ansible-windows-provisioning' 

if [[ $vcenter_hostname == 'vsphere01.contoso.local' ]]
 then
  cluster_name=QA_DEV
  datacenter_name=NA
  esx_hostname=NA
  vsphere_vars_file=group_vars/vsphere.yml
  vcenter_hostname=vsphere01.contoso.local
  newMask=24
  newGateway=11.119.6.1
  newDNS1=11.119.6.10
  newDNS2=11.119.188.12
  subnet=11.119.6.0
elif [[ $vcenter_hostname == 'vcsa1.fd.local' ]]
 then
  vsphere_vars_file=group_vars/dc1.yml
  cluster_name=HomeCluster
  datacenter_name=HomeDatacenter
  esx_hostname=192.168.1.20
  vcenter_hostname=vcsa1.fd.local
  newMask=24
  newGateway=192.168.1.1
  newDNS1=192.168.1.1
  subnet=192.168.1.0
else
  echo "Must provide vcenter hostname. Exiting."
  exit 1
fi


declare -a commands=( "ansible-playbook \
                           -e machineName=$machineName \
 			   -e vsphere_vars_file=$vsphere_vars_file \
		           -i $baseDir/hosts \
                           $baseDir/windowsProvision.yml \
                           "
                    )

for command in "${commands[@]}"
  do
    echo helo
   $command
        if [ "$?" -ne "0" ]
        then
                echo "error running playbook"
                exit -1
        fi

done

