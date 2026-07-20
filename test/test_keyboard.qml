import QtQuick
import Niri
import QtQuick.Controls
import QtQuick.Layouts

// Item {
//   id: root
//
//   Niri {
//     id: niri
//
//     Component.onCompleted: connect()
//
//     // onConnected: console.log("succefully connected to niri")
//     onErrorOccurred: function(error) {
//       console.log("error: ", error)
//     }
//     onDisconnected: console.warn("disconnected from socket")
//   }
//
//   property var xkb: niri.keyboardLayouts
//
//   Connections {
//     target: niri.keyboardLayouts
//
//     function onNamesChanged() {
//       console.log("names:", JSON.stringify(niri.keyboardLayouts.names));
//     }
//
//     function onCurrentIndexChanged() {
//       console.log("idx changed:", niri.keyboardLayouts.currentIndex, "(", niri.keyboardLayouts.currentName, ")");
//     }
//   }
//
//   Timer {
//     interval: 2000
//     running: true
//     onTriggered: {
//       const result = niri.switchLayoutNext();
//       if (!result.ok)
//         console.log("switchLayoutNext failed: ", result.error)
//     }
//   }
// }

ApplicationWindow {
  visible: true
  title: "Niri xkb test"

  property var lastActionResult: null
  
  Niri {
    id: niri
    Component.onCompleted: connect();

    onConnected: {
      status.text = "Connected";
      status.color = "green";
      console.log("succefully connected to niri");
    }
    onErrorOccurred: function(error) {
      status.text = "Error";
      status.color = "red";
      console.error("error occurred!", error);
    }
    onDisconnected: {
      status.text = "Disconnected";
      status.color = "red";
      console.warn("disconnected from niri");
    }
  }

  ColumnLayout {
    anchors.fill: parent
    anchors.margins: 10
    spacing: 10

    RowLayout {
      Layout.fillWidth: true

      Text {
        id: status
        text: "Connecting..."
        font.bold: true
      }

      Rectangle {
        Layout.preferredHeight: 20
        Layout.preferredWidth: actionResult.implicitWidth + 10
        radius: 3
        color: lastActionResult === "" ? "#E8F5E9" : "#FFEBEE"
        visible: lastActionResult !== null

        Text {
          id: actionResult
          anchors.centerIn: parent
          font.pixelSize: 11
          text: lastActionResult === "" ? "✓ Action OK"
                                                  : "✗ " + lastActionResult
          color: lastActionResult === "" ? "#2E7D32" : "#C62828"
        }
      }

      Item { Layout.fillWidth: true }

      Text {
        text: "Current layout: " + niri.keyboardLayouts.currentName
        font.pixelSize: 12
      }
    }

    RowLayout {
      Layout.fillWidth: true
      
      Text {
        text: "An placeholder for any text"
      }

      Item { Layout.fillWidth: true }

      RowLayout {
        spacing: 10
        layoutDirection: Qt.RightToLeft
        anchors {
          right: parent.right
          verticalCenter: parent.verticalCenter
        }

        Button {
          text: "Switch next"
          onClicked: {
            const r = niri.switchLayoutNext();
            lastActionResult = r.ok ? "" : r.error;
          }
        }

        Button {
          text: "Switch prev"
          onClicked: {
            const r = niri.switchLayoutPrev();
            lastActionResult = r.ok ? "" : r.error;
          }
        }
      }
    }

    TextInput {
      Layout.fillWidth: true
      Layout.fillHeight: true
    }
  }
}
