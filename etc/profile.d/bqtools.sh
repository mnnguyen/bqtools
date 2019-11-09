for d in /opt/software/bqtools/bin ; do
	if [[ -d "$d" ]]; then
		export PATH=$d:$PATH
	fi
done
