import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    property alias color: background.color

    background: Rectangle {
        color: parent.color
        radius: 25 // Adjust this value to control the button's curvature
    }

    contentItem: Text {
        text: parent.text
        anchors.centerIn: parent
    }

    onClicked: {
        // Handle button click here
    }
}
