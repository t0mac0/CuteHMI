#ifndef H_MODULES_CUTEHMI__MODBUS__1_INCLUDE_CUTEHMI_MODBUS_HOLDINGREGISTER_HPP
#define H_MODULES_CUTEHMI__MODBUS__1_INCLUDE_CUTEHMI_MODBUS_HOLDINGREGISTER_HPP

#include "internal/common.hpp"

#include <QObject>
#include <QMutex>
#include <QReadWriteLock>
#include <QVariant>
#include <QAtomicInt>

namespace cutehmi {
namespace modbus {

/**
 * Modbus holding register. This class represents Modbus holding registers.
 * According to Modbus specification each holding register holds 16 bit data.
 * Objects of this class act as a convenient proxy between instances of QML HoldingRegisterItem and Client.
 * Methods of this class are thread-safe.
 *
 * @note to make this class accessible from QML it must inherit after QObject,
 * thus keep in mind that this class is relatively heavy.
 */
class CUTEHMI_MODBUS_API HoldingRegister:
	public QObject
{
	Q_OBJECT

	public:
		enum Encoding {
			INT16
		};
		Q_ENUM(Encoding)

		/**
		 * Constructor.
		 * @param value initial value.
		 * @param parent parent object.
		 */
		explicit HoldingRegister(uint16_t value = 0, QObject * parent = 0);

		Q_INVOKABLE QVariant value(Encoding encoding = INT16) const noexcept(false);

		Q_INVOKABLE uint16_t requestedValue() const noexcept(false);

		Q_INVOKABLE void rest();

		Q_INVOKABLE void awake();

		Q_INVOKABLE bool wakeful() const;

		Q_INVOKABLE int pendingRequests() const;

	public slots:
		void requestValue(QVariant value, Encoding encoding = INT16);

		/**
		 * Update value.
		 * @param value new value.
		 *
		 * @note this function is thread-safe.
		 */
		void updateValue(uint16_t value);

	signals:
		void valueRequested();

		void valueUpdated();

		/**
		 * Value written. This signal is emitted when requested value has been written to the client device.
		 */
		void valueWritten();

		/**
		 * Value rejected. This signal is emitted when writing requested value has failed.
		 */
		void valueRejected();

	private slots:
		void onValueWritten();

		void onValueRejected();

	private:
		struct Members
		{
			uint16_t value;
			mutable QReadWriteLock valueLock;
			uint16_t reqValue;
			mutable QMutex reqValueMutex;
			QAtomicInt awaken;
			int writeCtr;
			mutable QReadWriteLock writeCtrLock;

			Members(uint16_t p_value):
				value(p_value),
				reqValue(p_value),
				awaken(0),
				writeCtr(0)
			{
			}
		};

		MPtr<Members> m;
};

}
}

#endif

//(c)MP: Copyright © 2018, Michal Policht. All rights reserved.
//(c)MP: This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
