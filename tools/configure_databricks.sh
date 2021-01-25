cluster_exists () {
    declare cluster_name="$1"
    declare cluster=$(databricks clusters list | tr -s " " | cut -d" " -f2 | grep ^${cluster_name}$)
    if [[ -n $cluster ]]; then
        return 0; # cluster exists
    else
        return 1; # cluster does not exists
    fi
}

# Create initial cluster, if not yet exists
cluster_config="./databricks/config/cluster.config.json"
cluster_name=$(cat $cluster_config | jq -r ".cluster_name")
if cluster_exists $cluster_name; then 
    echo "Cluster ${cluster_name} already exists!"
else
    echo "Creating cluster ${cluster_name}..."
    databricks clusters create --json-file $cluster_config
fi

echo "Completed configuring databricks."

