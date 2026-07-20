#pragma once

#include <QObject>
#include <QJsonObject>
#include <QQmlEngine>
#include <QStringList>


class keyboardLayouts : public QObject
{
  Q_OBJECT
  QML_ELEMENT
  QML_UNCREATABLE("keyboardLayouts is owned by Niri")

  Q_PROPERTY(QStringList names READ names NOTIFY namesChanged)
  Q_PROPERTY(int currentIndex READ currentIndex NOTIFY currentIndexChanged)
  Q_PROPERTY(QString currentName READ currentName NOTIFY currentIndexChanged)

public:
  explicit keyboardLayouts(QObject *parent = nullptr);

  QStringList names() const { return m_names; };
  int currentIndex() const { return m_currentIndex; };
  QString currentName() const;

public slots:
  void handleEvent(const QJsonObject &event);

signals:
  void namesChanged();
  void currentIndexChanged();

private:
  void handleLayoutChanged(const QJsonObject &data);
  void handleLayoutSwitched(int idx);

  QStringList m_names;
  int m_currentIndex = 0;
}
