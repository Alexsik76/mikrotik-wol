# Script to wake on lan server
:log info "Script WOL-service started."; 
:delay 15;
:global targetHostName debianserver
:do {
    :local targetLeaser [/ip/dhcp-server/lease/ get [find host-name=$targetHostName]];
    :local leaserStatus ($targetLeaser->"status");
    :local leaserMac ($targetLeaser->"mac-address");
    :put "Try to wake on $targetHostName by $leaserMac";
    :tool wol interface=bridge mac=$leaserMac;
    :log info "First try to wake on $targetHostName"; 
    :delay 120;
    :if ($leaserStatus!="bound") \
        do={
        :put "Try to wake on $targetHostName by $leaserMac";
        :tool wol interface=bridge mac=$leaserMac;
        :log info "Retry to wake on $targetHostName"; 
        };
} on-error={ 
    :log error "Failed to complete WOL on $targetHostName";
    :put "WOL error"; 
    };
:log info "Successfully completed WOL on $targetHostName";
