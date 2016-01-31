#ifndef CUTEHMI_LIBBASE_SRC_PLUGIN_IXMLBACKEND_HPP
#define CUTEHMI_LIBBASE_SRC_PLUGIN_IXMLBACKEND_HPP

#include "../platform.hpp"
#include "../base/Error.hpp"
#include "../base/ProjectModel.hpp"

#include <QtPlugin>
#include <QXmlStreamReader>
#include <QXmlStreamWriter>

namespace plugin {

class IXMLBackend
{
	public:
		virtual base::Error readXML(QXmlStreamReader & xmlReader, base::ProjectModel::Node & node) = 0;

		virtual base::Error writeXML(QXmlStreamWriter & xmlWriter) const = 0;

	protected:
		virtual ~IXMLBackend() = default;

		IXMLBackend() = default;
};

}

Q_DECLARE_INTERFACE(plugin::IXMLBackend, "CuteHMI.Plugin.IXMLBackend")

#endif