import QtQuick
import Niri

Niri {
  id: niri

  Component.onCompleted: connect()

  onConnected: console.log("succefully connected to niri")
  onErrorOccured: function(error)
  {
    console.error("error: ", error)
  }

  property val xkb: niri.keyboardLayouts

  Connections {
    target: niri.keyboardLayouts

    function onNamesChanged()
    {
      console.log("names:", JSON.stringify(niri.keyboardLayouts.names));
    }

    function onCurrentIndexChanged()
    {
      console.log("idx changed": niri.keyboardLayouts.currentIndex, "(", niri.keyboardLayouts.currentName, ")")
    }
  }

  Timer {
    interval: 2000
    running: true
    onTriggered: {
      const result = niri.switchLayoutNext();
      if (!result.ok)
        console.error("switchLayoutNext failed: ", result.error)
    }
  }
}
