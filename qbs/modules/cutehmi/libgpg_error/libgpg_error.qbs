import qbs 1.0
import qbs.Probes
import qbs.FileInfo

Module {
	cpp.libraryPaths: FileInfo.cleanPath(libgpg_errorProbe.path)

	cpp.includePaths: FileInfo.cleanPath(gpg_errorHeaderProbe.path)

	Properties {
		condition: qbs.targetOS.contains("windows")
		cpp.dynamicLibraries: ["libgpg-error-0"]
	}

	Properties {
		condition: qbs.targetOS.contains("linux")
		cpp.dynamicLibraries: ["libgpg-error"]
	}

	property bool found: libgpg_errorProbe.found && gpg_errorHeaderProbe.found

	property bool available: found

	property string libgpg_errorPath: libgpg_errorProbe.filePath

	property string includePath: gpg_errorHeaderProbe.path

	Probes.PathProbe {
		id: libgpg_errorProbe

        names: qbs.targetOS.contains("windows") ? ["libgpg-error-0"] : ["libgpg-error"]
		nameSuffixes: qbs.targetOS.contains("windows") ? [".dll"] : [".so"]
		pathPrefixes: cpp.libraryPaths.concat(cpp.compilerLibraryPaths ? cpp.compilerLibraryPaths : [])
							.concat(cpp.systemRunPaths ? cpp.systemRunPaths : [])
							.concat(cpp.distributionLibraryPaths ? cpp.distributionLibraryPaths : [])
							.concat([cutehmi.dirs.externalLibDir + "/libgpg-error/lib"])
	}

	Probes.PathProbe {
		id: gpg_errorHeaderProbe

		names: ["gpg-error.h"]
		pathPrefixes: cpp.includePaths.concat(cpp.compilerIncludePaths ? cpp.compilerIncludePaths : [])
							.concat(cpp.systemIncludePaths ? cpp.systemIncludePaths : [])
							.concat(cpp.distributionIncludePaths ? cpp.distributionIncludePaths : [])
							.concat([cutehmi.dirs.externalLibDir + "/libgpg-error/include"])
	}

	Group {
		name: "Libgpg-error"
		files: cutehmi.libgpg_error.libgpg_errorPath
		condition: cutehmi.libgpg_error.libgpg_errorPath
		qbs.install: true
		qbs.installDir: cutehmi.dirs.moduleInstallDir
	}

	Depends { name: "cpp" }

	Depends { name: "cutehmi.dirs" }
}