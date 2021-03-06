import QtQuick 2.0
import HelperWidgets 2.0
import QtQuick.Layouts 1.0

Column {
	anchors.left: parent.left
	anchors.right: parent.right

	Section {
		anchors.left: parent.left
		anchors.right: parent.right
		caption: "Modbus"

		SectionLayout {
			rows: 2

			Label {
				text: qsTr("Device")
			}
			SecondColumnLayout {
				LineEdit {
					backendValue: backendValues.device
					placeholderText: backendValue.expression
					Layout.fillWidth: true
					showExtendedFunctionButton: true
					showTranslateCheckBox: false
					readOnly: true
				}
			}

			Label {
				text: qsTr("Address")
			}
			SecondColumnLayout {
				SpinBox {
					backendValue: backendValues.address
					minimumValue: 0
					maximumValue: 65535
					Layout.preferredWidth: 80
				}
				Label {
					text: "/"
					tooltip: "Entity address / Entity number"
					width: 20
					horizontalAlignment: Text.AlignHCenter
				}
				SpinBox {
					value:  backendValues.address.value + 300001
					minimumValue: 300001
					maximumValue: 365536
					Layout.preferredWidth: 80
					Layout.alignment: Qt.AlignRight

					onValueChanged: {
						if (backendValues.address.value !== value - 300001)
							backendValues.address.value = value - 300001
					}
				}
			}

			Label {
				text: qsTr("Encoding")
			}
			SecondColumnLayout {
				ComboBox {
					model: ["INT16"]
					backendValue: backendValues.encoding
					Layout.fillWidth: true
					scope: "ModbusInputRegister"
				}
			}

			Label {
				text: qsTr("Value scale")
			}
			SecondColumnLayout {
				SpinBox {
					backendValue: backendValues.valueScale
					minimumValue: -1000000000
					maximumValue: 1000000000
					decimals: 4
					Layout.fillWidth: true
				}
			}

			Label {
				text: qsTr("Delegate")
			}
			SecondColumnLayout {
				LineEdit {
					backendValue: backendValues.delegate
					placeholderText: backendValue.expression
					Layout.fillWidth: true
					showExtendedFunctionButton: true
					showTranslateCheckBox: false
					readOnly: true
				}
			}

			Label {
				text: qsTr("Delegate property")
			}
			SecondColumnLayout {
				LineEdit {
					backendValue: backendValues.delegateProperty
					Layout.fillWidth: true
					showExtendedFunctionButton: true
					showTranslateCheckBox: false
				}
			}
		}
	}
}

//(c)MP: Copyright © 2018, Michal Policht. All rights reserved.
//(c)MP: This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
