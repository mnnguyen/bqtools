foreach d ( /opt/software/bqtools/bin )
	if ( -d "${d}" ) then
		setenv PATH ${d}:${PATH}
	fi
end
