# Домашняя работа к занятию «Микросервисы: принципы»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.

## Задача 1: API Gateway

Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных
программных решений. На основе таблицы сделайте выбор решения.

Решение должно соответствовать следующим требованиям:

- маршрутизация запросов к нужному сервису на основе конфигурации,
- возможность проверки аутентификационной информации в запросах,
- обеспечение терминации HTTPS.

Обоснуйте свой выбор.

> Сравнительная таблица возможностей различных программных решений для API Gateway:

| Наименование          | Маршрутизация запросов | Проверка аутентификации | Терминация HTTPS | Стоимость                                   |
|-----------------------|------------------------|-------------------------|------------------|---------------------------------------------| 
| Nginx Plus            | ✔                      | ✔ (с модулем)           | ✔                | Бесплатно (с ограничениями), платная версия |
| Apache Traffic Server | ✔                      | ✔                       | ✔                | Бесплатно (с ограничениями), платная версия |
| Kong                  | ✔                      | ✔                       | ✔                | Открытый исходный код                       |
| Envoy Proxy           | ✔                      | ✔                       | ✔                | Открытый исходный код                       |
| Tyk                   | ✔                      | ✔                       | ✔                | Открытый исходный код                       |
| Goku                  | ✔                      | ✔                       | ✔                | Открытый исходный код                       |

> В качестве решения предлагаю взять Kong, так как ему поклонятся довольно большое количество специалистов. Найти
> решение проблемы будет не сложно.
> Подойдет любой из представленных вариантов, все зависит от бюджета. Так же стоит отметить что у большинства облачных
> платформ есть собственные решения API Gateway как сервис.

## Задача 2: Брокер сообщений

Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения.

Решение должно соответствовать следующим требованиям:

- поддержка кластеризации для обеспечения надёжности,
- хранение сообщений на диске в процессе доставки,
- высокая скорость работы,
- поддержка различных форматов сообщений,
- разделение прав доступа к различным потокам сообщений,
- простота эксплуатации.

Обоснуйте свой выбор.

> Ниже представлена таблица, сравнивающая возможности различных брокеров сообщений.

| Требование                   | RabbitMQ | Apache Kafka | AWS SQS | Azure Service Bus | Active MQ |
|------------------------------|----------|--------------|---------|-------------------|-----------|
| Поддержка кластеризации      | ✔        | ✔            | ✔       | ✔                 | ✔         |
| Хранение сообщений на диске  | ✔        | ✘            | ✘       | ✔                 | ✔         |
| Высокая скорость работы      | ✔        | ✔            | ✔       | ✔                 | ✔         |
| Поддержка различных форматов | ✔        | ✔            | ✔       | ✔                 | ✔         |
| Разделение прав доступа      | ✔        | ✔            | ✔       | ✔                 | ✔         |
| Простота эксплуатации        | ✔        | ✘            | ✔       | ✔                 | ✔         |

> На основе данной таблицы можно сделать следующие выводы:
> Исходя из этого, можно рекомендовать RabbitMQ как хорошее решение, которое сочетает в себе большинство необходимых характеристик. 
> Active MQ также хорошо подходит под большинство требований, но может быть менее известен и иметь меньшую экосистему, чем RabbitMQ.