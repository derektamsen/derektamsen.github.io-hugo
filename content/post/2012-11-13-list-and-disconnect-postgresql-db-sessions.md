+++
date = "2012-11-13T23:53:00-08:00"
description = "Some times it is necessary to terminate a PostgreSQL query and connection. This can be very helpful when you have a run away command or script. It can also be helpful if your application has submitted a query to the backend that has caused everything to grind to a halt. Fortunately, postgres comes to the rescue and provides a few helpful commands that will allow you to cancel the query from the database and optionally terminate the user or application's connection."
draft = false
tags = ["postgres"]
title = "list and disconnect postgresql db sessions"

+++

Some times it is necessary to terminate a PostgreSQL query and connection. This can be very helpful when you have a run away command or script. It can also be helpful if your application has submitted a query to the backend that has caused everything to grind to a halt. Fortunately, postgres comes to the rescue and provides a few helpful commands that will allow you to cancel the query from the database and optionally terminate the user or application's connection.

*As usual please be careful and test any commands before running them in production.
Some applications do not like having there query or session closed.*

All of the following examples will require you to be connected to your database. This can either be an interactive connection or by passing the SQL code via `psql -c '<code>'`.

### List all current connections

- `pg_stat_activity` lists the current sessions and outputs information about the connected sessions.

```sql
/* ---------
List all of the current sessions
--------- */
SELECT *
FROM pg_stat_activity;
```


- You can add some `WHERE` clauses to your query if you would like to help filter down the information.

```sql
/* ---------
List current sessions from the "clients" database
--------- */
SELECT *
FROM pg_stat_activity
WHERE datname='clients';
```

The above queries will output a table which will contain information about the session. Some of the information will include the username, which db they are connected to, if the session is idle, or what the sql query is. It will also return the `procpid` which can be used to terminate the query. The `procpid` is essentially the Linux or Unix process id (pid) the subprocess was assigned by the kernel.

### Cancel the backend process and optional terminate the session

- `pg_cancel_backend` will cancel only the backend process leaving the user's session open.

```sql
/* ---------
Cancels the backend process
where <procpid> is the process id returned from pg_stat_activity
for the query you want to cancel
--------- */
SELECT pg_cancel_backend( <procpid> );
```

- If purely canceling the process does not work and you would like to be more forceful you can cancel the backend process with `pg_terminate_backend`. This will terminate the user's query and close their session to the database.

```sql
/* ---------
Cancels the backend process and terminates the user's session
where <procpid> is the process id returned from pg_stat_activity
for the query you want to cancel
--------- */
SELECT pg_terminate_backend( <procpid> );
```

The [PostgreSQL administration documentation](http://www.postgresql.org/docs/9.2/static/functions-admin.html "PostgreSQL 9.2.1 - Ch. 9 Functions and Operators") is a great source to learn about these commands and more.
