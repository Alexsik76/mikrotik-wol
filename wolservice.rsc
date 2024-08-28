# Script to wake on lan server
:delay 15;
:global targetHostName debianserver
:do {
    :local targetLeaser [/ip/dhcp-server/lease/ get [find host-name=$targetHostName]];
    :local leaserStatus ($targetLeaser->"status");
    :local leaserMac ($targetLeaser->"mac-address");
    if ($leaserStatus="bound") \
        do={ 
            :put "$targetHostName alredy bound" 
            } else={
            :put "Try to wake on $targetHostName";
            :tool wol interface=bridge mac=$leaserMac;
            }; 
} on-error={ 
    :log error "Failed to complete WOL on $targetHostName";
    :put "WOL error"; 
    };
:log info "Successfully completed WOL on $targetHostName"; 
:put "WOL successfully completed"; 