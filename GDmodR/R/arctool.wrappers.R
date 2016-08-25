arc.unpack = function( arc.path, archiveTool.path = NULL )
{
	archiveTool.exe = "archivetool.exe";

	if( file.exists( arc.path ) ) {
		arc.files = c( arc.path );
	} else if( dir.exist( arc.path ) ) {
		arc.files = list.files( arc.path, "*.arc", recursive = TRUE );
	} else {
		error( "arc.unpack():",
		 " failed to locate input arc(s): ", arc.path );
	}
	# archiveTool is either the path to the exe or
	# NULL if archivetool.exe exists in the present working directory
	#
	if( is.null( archiveTool.path ) ) {
		if( file.exists( archiveTool.exe ) ) {
			archiveTool.path = archiveTool.exe;
		} else {
			error( "arc.unpack() failed to locate ",
			 archiveTool.exe, " in pwd" );
		}
	}
	if( !file.exists( archiveTool.path ) ) {
		error( "arc.unpack() failed to locate ",
			 archiveTool.exe, " using ", archiveTool.path );
	}
	names( arc.files ) = sub( "[.].*", "", basename( arc.files ) );
	for( arc.name in names( arc.files ) ) {
		arc.input = sprintf( "%s/%s", arc.path, arc.name );
		params = c( arc.files[ arc.name ], "-extract", arc.path );
		system2( archiveTool.path, params );
	}
}
