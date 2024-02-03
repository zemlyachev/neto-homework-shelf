# Домашняя работа к занятию 10 «Jenkins»

## Подготовка к выполнению

1. Создать два VM: для jenkins-master и jenkins-agent.
2. Установить Jenkins при помощи playbook.
3. Запустить и проверить работоспособность.
4. Сделать первоначальную настройку.

![Настроенный и сдобренный слезами jenkins](./img/installed.png)

## Основная часть

1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.

> Сборочная директория с исходниками роли и успешная сборка #9

![Автор задания - человек-молекула](./img/freestyle.png)

2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.

> Скрипт

![](./img/declarative-inline-script.png)

> Успешное выполнение pipeline

![Угадал мелодию с 3х нот](./img/declarative-inline-yes.png)

3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.

> Перенес удалив секцию про гит - [Jenkinsfile](https://github.com/zemlyachev/vector-role/blob/main/Jenkinsfile)

4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.

![Bored](./img/multibranch-yes.png)

5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).
6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True). По умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.

> Добавляем параметры для запуска

![Паратризимед пипелине](./img/scripted-conf-params.png)

> Правим скрипт

![](./img/scripted-script.png)

> Получаем чекбокс при запуске с параметрами

![Pipeline scripted pipeline](./img/scripted-run-params.png)

7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.

> [Scripted Pipeline](./pipeline/ScriptedJenkinsfile)

8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.

> [Declarative Pipeline Jenkinsfile](https://github.com/zemlyachev/vector-role/blob/main/Jenkinsfile)
> 
> [Scripted Pipeline](./pipeline/ScriptedJenkinsfile)