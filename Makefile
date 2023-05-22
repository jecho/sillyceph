
cleanup-bootstrapper:
	cephadm rm-cluster --fsid f3237e67-4dec-4396-95ed-a32159026bae --force

cleanup-hosts:
	cephadm rm-cluster --fsid f3237e67-4dec-4396-95ed-a32159026bae --force
	dd if=/dev/zero bs=1024 count=1024 of=/dev/sdc
	dd if=/dev/zero bs=1024 count=1024 of=/dev/sdd
	dd if=/dev/zero bs=1024 count=1024 of=/dev/sde
	sudo dmsetup remove_all

cleanup-pools:
	ceph orch rm rgw.cnct
	ceph orch rm ingress.rgw.cnct
	cephadm shell --fsid f3237e67-4dec-4396-95ed-a32159026bae -- ceph tell mon.\* injectargs '--mon-allow-pool-delete=true'
	ceph osd pool delete .rgw.root .rgw.root --yes-i-really-really-mean-it
	ceph osd pool delete us-west-1.rgw.control us-west-1.rgw.control --yes-i-really-really-mean-it
	ceph osd pool delete us-west-1.rgw.meta us-west-1.rgw.meta --yes-i-really-really-mean-it
	ceph osd pool delete us-west-1.rgw.gc us-west-1.rgw.gc --yes-i-really-really-mean-it
	ceph osd pool delete us-west-1.rgw.log us-west-1.rgw.log --yes-i-really-really-mean-it
	ceph osd pool delete us-west-1.rgw.intent-log us-west-1.rgw.intent-log --yes-i-really-really-mean-it
	ceph osd pool delete us-west-1.rgw.buckets.index us-west-1.rgw.buckets.index --yes-i-really-really-mean-it
	ceph osd pool delete us-west-1.rgw.buckets.data us-west-1.rgw.buckets.data --yes-i-really-really-mean-it
	ceph osd pool delete us-west-1.rgw.buckets.non-ec us-west-1.rgw.buckets.non-ec --yes-i-really-really-mean-it
	ceph osd pool delete us-west-1.rgw.cnct-placement-b.buckets.index us-west-1.rgw.cnct-placement-b.buckets.index  --yes-i-really-really-mean-it
	ceph osd pool delete us-west-1.rgw.cnct-placement-b.buckets.data us-west-1.rgw.cnct-placement-b.buckets.data  --yes-i-really-really-mean-it
	ceph osd pool delete us-west-1.rgw.cnct-placement-b.buckets.non-ec us-west-1.rgw.cnct-placement-b.buckets.non-ec  --yes-i-really-really-mean-it
	ceph osd pool delete default.rgw.meta default.rgw.meta --yes-i-really-really-mean-it
	ceph osd pool delete default.rgw.control default.rgw.control --yes-i-really-really-mean-it
	ceph osd pool delete default.rgw.log default.rgw.log --yes-i-really-really-mean-it
	ceph osd pool delete default.rgw.meta default.rgw.meta --yes-i-really-really-mean-it
	ceph osd pool delete default.rgw.buckets.index  default.rgw.buckets.index --yes-i-really-really-mean-it
	ceph osd pool delete default.rgw.buckets.data  default.rgw.buckets.data --yes-i-really-really-mean-it
	ceph osd pool delete default.rgw.buckets.non-ec  default.rgw.buckets.non-ec --yes-i-really-really-mean-it
	ceph osd pool delete us-west-1.rgw.swagger.data us-west-1.rgw.swagger.data --yes-i-really-really-mean-it
	ceph osd pool delete us-west-1.rgw.swagger.index  us-west-1.rgw.swagger.index --yes-i-really-really-mean-it
	ceph osd pool delete us-west-1.rgw.swagger.non-ec us-west-1.rgw.swagger.non-ec --yes-i-really-really-mean-it
	ceph osd pool delete default.rgw.swagger.data default.rgw.swagger.data --yes-i-really-really-mean-it
	ceph osd pool delete default.rgw.swagger.non-ec default.rgw.swagger.non-ec --yes-i-really-really-mean-it
	ceph osd pool delete default.rgw.swagger.index default.rgw.swagger.index --yes-i-really-really-mean-it

cleanup-zones:
	radosgw-admin realm rm --rgw-realm=us-west-1a
	radosgw-admin zone delete --rgw-zone=us-west-1 --master

events:
	ceph orch ls --service_name=$(SERVICE_NAME) --format yaml

podman:
	apt-get purge docker-ce -y
	echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
	curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key | sudo apt-key add -
	apt-get update
	apt-get -y upgrade
	apt-get -y install podman
