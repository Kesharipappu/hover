import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 200
    title: "Pentagonal Button Example"

    Item {
        anchors.fill: parent

        Item {
            id: customButton
            width: 140
            height: 80
            anchors.centerIn: parent

            Rectangle {
                width: customButton.width
                height: customButton.height

                // Apply a gradient to the button
                gradient: Gradient {
                    GradientStop { position: 0.7; color: "lightgreen" }
                    GradientStop { position: 1.1; color: "lightblue" }
                    GradientStop { position: 0.2; color: "red" }
                    GradientStop { position: 0.5; color: "blue" }


                }

                radius: 8

                MouseArea {
                    anchors.fill: parent

                    onEntered: {
                        customButton.color = "lightyellow";
                    }

                    onExited: {
                        customButton.color = "";
                    }

                    onClicked: {
                        customButton.color = "red";
                    }
                }
            }

            // Use ShaderEffectSource for the cut corner
            ShaderEffectSource {
                id: cutCornerSource
                sourceItem: Rectangle {
                    width: customButton.width / 2
                    height: customButton.height / 2
                    color: "transparent"
                }
                width: customButton.width / 2
                height: customButton.height / 2
            }

            ShaderEffect {
                id: cutCornerEffect
                width: customButton.width / 2
                height: customButton.height / 2
                fragmentShader: "
                    uniform lowp float qt_Opacity;
                    varying highp vec2 qt_TexCoord0;
                    void main() {
                        lowp vec4 color = texture2D(source, qt_TexCoord0);
                        if (qt_TexCoord0.x > 0.5 && qt_TexCoord0.y < 0.5) {
                            color.a = 0.0;
                        }
                        gl_FragColor = color * qt_Opacity;
                    }"
                onEnabledChanged: {
                    if (enabled) {
                        cutCornerSource.enabled = true;
                    } else {
                        cutCornerSource.enabled = false;
                    }
                }
            }
        }
    }
}
