
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

cleanup-zones:
	radosgw-admin realm rm --rgw-realm=us-west-1a
	radosgw-admin zone delete --rgw-zone=us-west-1 --master
