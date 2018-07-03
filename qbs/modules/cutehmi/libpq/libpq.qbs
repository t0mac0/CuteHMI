import qbs 1.0
import qbs.Probes
import qbs.FileInfo

Module {
	cpp.libraryPaths: FileInfo.cleanPath(libpqProbe.path)

	cpp.includePaths: FileInfo.cleanPath(libpq_feHeaderProbe.path)

	Properties {
		condition: qbs.targetOS.contains("windows")
		cpp.dynamicLibraries: ["libpq"]
	}

	Properties {
		condition: qbs.targetOS.contains("linux")
		cpp.dynamicLibraries: ["pq"]
	}

	property bool found: libpqProbe.found && libpq_feHeaderProbe.found

    property bool available: found && (qbs.targetOS.contains("windows") ? cutehmi.libintl.available : true)

	property string libpqPath: libpqProbe.filePath

	property string includePath: libpq_feHeaderProbe.path

	Probes.PathProbe {
		id: libpqProbe

        names: ["libpq"]
		nameSuffixes: qbs.targetOS.contains("windows") ? [".dll"] : [".so"]
		pathPrefixes: cpp.libraryPaths.concat(cpp.compilerLibraryPaths ? cpp.compilerLibraryPaths : [])
							.concat(cpp.systemRunPaths ? cpp.systemRunPaths : [])
							.concat(cpp.distributionLibraryPaths ? cpp.distributionLibraryPaths : [])
							.concat([cutehmi.dirs.externalLibDir + "/postgresql/lib"])
	}

	Probes.PathProbe {
		id: libpq_feHeaderProbe

		names: ["libpq-fe"]
		nameSuffixes: [".h"]
		pathPrefixes: cpp.includePaths.concat(cpp.compilerIncludePaths ? cpp.compilerIncludePaths : [])
							.concat(cpp.systemIncludePaths ? cpp.systemIncludePaths : [])
							.concat(cpp.distributionIncludePaths ? cpp.distributionIncludePaths : [])
							.concat([cutehmi.dirs.externalLibDir + "/postgresql/include"])
        pathSuffixes: ["postgresql"]
	}

	Group {
		name: "PostgreSQL client library"
		files: cutehmi.libpq.libpqPath
		condition: cutehmi.libpq.libpqPath
		qbs.install: true
		qbs.installDir: cutehmi.dirs.moduleInstallDir
	}

	Depends { name: "cpp" }

	Depends { name: "cutehmi.dirs" }

	Depends { name: "cutehmi.libintl" }
}