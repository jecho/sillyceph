
cleanup-bootstrapper:
	cephadm rm-cluster --fsid f3237e67-4dec-4396-95ed-a32159026bae --force

cleanup-hosts:
	cephadm rm-cluster --fsid f3237e67-4dec-4396-95ed-a32159026bae --force
	dd if=/dev/zero bs=1024 count=1024 of=/dev/sdb
	dd if=/dev/zero bs=1024 count=1024 of=/dev/sdc
	dd if=/dev/zero bs=1024 count=1024 of=/dev/sdd
	dd if=/dev/zero bs=1024 count=1024 of=/dev/sde
	sudo dmsetup remove_all

cleanup-pools:
	cephadm shell --fsid f3237e67-4dec-4396-95ed-a32159026bae -- ceph tell mon.\* injectargs '--mon-allow-pool-delete=true'
	ceph osd pool delete .rgw.root .rgw.root --yes-i-really-really-mean-it
	ceph osd pool delete cnct-zone.rgw.control cnct-zone.rgw.control --yes-i-really-really-mean-it
	ceph osd pool delete cnct-zone.rgw.gc cnct-zone.rgw.gc --yes-i-really-really-mean-it
	ceph osd pool delete cnct-zone.rgw.log cnct-zone.rgw.log --yes-i-really-really-mean-it
	ceph osd pool delete cnct-zone.rgw.intentlog cnct-zone.rgw.intentlog --yes-i-really-really-mean-it
	ceph osd pool delete cnct-zone.rgw.buckets.index cnct-zone.rgw.buckets.index --yes-i-really-really-mean-it
	ceph osd pool delete cnct-zone.rgw.buckets.data cnct-zone.rgw.buckets.data --yes-i-really-really-mean-it
	ceph osd pool delete cnct-zone.rgw.cnct-placement-b.buckets.index cnct-zone.rgw.cnct-placement-b.buckets.index  --yes-i-really-really-mean-it
	ceph osd pool delete cnct-zone.rgw.cnct-placement-b.buckets.data cnct-zone.rgw.cnct-placement-b.buckets.data  --yes-i-really-really-mean-it
	ceph osd pool delete cnct-zone.rgw.cnct-placement-b.buckets.non-ec cnct-zone.rgw.cnct-placement-b.buckets.non-ec  --yes-i-really-really-mean-it