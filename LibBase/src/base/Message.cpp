#include "../../include/base/Message.hpp"

namespace cutehmi {
namespace base {

Message::Message(type_t type, const QString & text, Message::button_t buttons, QObject * parent):
	QObject(parent),
	m(new Members{type, text, buttons})
{
}

Message::button_t Message::Note(const QString & text, button_t buttons)
{
	CUTEHMI_BASE_QINFO(text);		//temp
	return NO_BUTTON;
}

Message::button_t Message::Warning(const QString & text, button_t buttons)
{
	CUTEHMI_BASE_QWARNING(text);	//temp
	return NO_BUTTON;
}

Message::button_t Message::Error(const QString & text, button_t buttons)
{
	CUTEHMI_BASE_QCRITICAL(text);	//temp
	return NO_BUTTON;
}

Message::type_t Message::type() const
{
	return m->type;
}

void Message::setType(type_t type)
{
	m->type = type;
}

QString Message::text() const
{
	return m->text;
}

void Message::setText(const QString & text)
{
	m->text = text;
}

Message::button_t Message::buttons() const
{
	return m->buttons;
}

void Message::setButtons(button_t buttons)
{
	m->buttons = buttons;
}

}
}
