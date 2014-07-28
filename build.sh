
function check_success() {
	if [ ! $? == 0 ]; then
		echo "Building image '$1' failed."
		echo ""
		exit 1
	fi
}


docker build -t frosenberg/elasticsearch elasticsearch/
check_success "elasticsearch"

docker build -t frosenberg/kibana kibana/
check_success "kibana"

docker build -t frosenberg/fluentd fluentd/
check_success "fluentd"

docker build -t frosenberg/apache2 apache2/
check_success "apache2"
