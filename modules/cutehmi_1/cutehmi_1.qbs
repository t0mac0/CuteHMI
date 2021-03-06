import qbs

import cutehmi

cutehmi.Module {
	name: "cutehmi_1"

	minor: 0

	micro: 0

	vendor: "CuteHMI"

	friendlyName: "Base"

	description: "Base module."

	author: "Michal Policht"

	copyright: "Michal Policht"

	license: "Mozilla Public License, v. 2.0"

	files: [
        "README.md",
        "include/cutehmi/CuteHMI.hpp",
        "include/cutehmi/DataBlock.hpp",
        "include/cutehmi/Error.hpp",
        "include/cutehmi/ErrorException.hpp",
        "include/cutehmi/ErrorInfo.hpp",
        "include/cutehmi/Exception.hpp",
        "include/cutehmi/ExceptionMixin.hpp",
        "include/cutehmi/IMetadataPlugin.hpp",
        "include/cutehmi/IProjectBackend.hpp",
        "include/cutehmi/IProjectPlugin.hpp",
        "include/cutehmi/MPtr.hpp",
        "include/cutehmi/NonCopyable.hpp",
        "include/cutehmi/NonMovable.hpp",
        "include/cutehmi/Notification.hpp",
        "include/cutehmi/NotificationListModel.hpp",
        "include/cutehmi/NotificationManager.hpp",
        "include/cutehmi/Plugin.hpp",
        "include/cutehmi/PopupBridge.hpp",
        "include/cutehmi/Project.hpp",
        "include/cutehmi/ProjectModel.hpp",
        "include/cutehmi/ProjectNode.hpp",
        "include/cutehmi/ProjectNodeData.hpp",
        "include/cutehmi/ProjectPluginLoader.hpp",
        "include/cutehmi/Prompt.hpp",
        "include/cutehmi/Singleton.hpp",
        "include/cutehmi/Worker.hpp",
        "include/cutehmi/internal/PluginLoader.hpp",
        "include/cutehmi/internal/PluginNodeData.hpp",
        "include/cutehmi/internal/common.hpp",
        "include/cutehmi/internal/platform.hpp",
        "include/cutehmi/logging.hpp",
        "include/cutehmi/loggingMacros.hpp",
        "include/cutehmi/metadata.hpp",
        "src/cutehmi/CuteHMI.cpp",
        "src/cutehmi/DataBlock.cpp",
        "src/cutehmi/Error.cpp",
        "src/cutehmi/ErrorException.cpp",
        "src/cutehmi/ErrorInfo.cpp",
        "src/cutehmi/Exception.cpp",
        "src/cutehmi/Notification.cpp",
        "src/cutehmi/NotificationListModel.cpp",
        "src/cutehmi/NotificationManager.cpp",
        "src/cutehmi/Plugin.cpp",
        "src/cutehmi/PopupBridge.cpp",
        "src/cutehmi/Project.cpp",
        "src/cutehmi/ProjectModel.cpp",
        "src/cutehmi/ProjectNode.cpp",
        "src/cutehmi/ProjectNodeData.cpp",
        "src/cutehmi/ProjectPluginLoader.cpp",
        "src/cutehmi/Prompt.cpp",
        "src/cutehmi/Worker.cpp",
        "src/cutehmi/internal/PluginLoader.cpp",
        "src/cutehmi/internal/PluginNodeData.cpp",
        "src/cutehmi/logging.cpp",
        "src/cutehmi/plugin/MetadataPlugin.hpp",
    ]

	Depends { name: "Qt.core" }
	Depends { name: "Qt.qml" }

	Depends { name: "cutehmi.doxygen" }

	Export {
		Depends { name: "Qt.core" }
		Depends { name: "Qt.qml" }
	}
}

//(c)MP: Copyright © 2018, Michal Policht. All rights reserved.
//(c)MP: This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
