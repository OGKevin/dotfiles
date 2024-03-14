#!/bin/zsh

# set -o xtrace

project_id="mol-$1"

instances=$(
    gcloud compute instances list --project "$project_id" \
        --format 'table(name,zone,networkInterfaces[0].networkIP :label=Internal_IP,labels['vm_type'],metadata.db_node_type)' 2>&1
) || {
    echo "$instances"
    if [[ $(echo "$instances" | head -n 1) == "Reauthentication required." ]]; then
        gcloud auth login
        instances=$(gcloud compute instances list --project "$project_id" \
            --format 'table(name,zone,networkInterfaces[0].networkIP :label=Internal_IP,labels['vm_type'])') || {
            return 1
        }
    fi
}


selected_instance=$(echo "$instances" |  grep -Ei '^[A-Za-z]?db[A-Za-z]?-vm-' | fzf --height 30%)

if [ -n "$selected_instance" ]; then
    zone=$(echo "$selected_instance" | awk '{print $2}')
    name=$(echo "$selected_instance" | awk '{print $1}')

  gcloud compute ssh --zone "$zone" "kevin_hellemun_mollie_com@$name" --project "$project_id" --tunnel-through-iap --plain
fi
