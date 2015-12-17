docker-drupal7
==============

This is a recipe for building a Docker container with Drupal 7, including Linux (Debian 8), Apache and MySQL.

Based on: https://github.com/janmashat/docker-drupal-brightcove

### How to use:

#### Clone repo:

```sh
git clone https://github.com/janmashat/docker-drupal7.git
cd docker-drupal7
```

Note: sources.list includes de.debian.org for the main repo, which can be modified for a closer location.

#### Build container:

Before building, make sure you have Docker Engine installed: https://docs.docker.com/engine/installation/

```sh
docker build -t drupal7 .
```

#### Run container with docroot stored inside:

```sh
docker run -it --name drupal7 -p 80:80 -p 9001:9001 drupal7
```

---OR---

#### Run container with docroot stored on the host:

```sh
docker run -it --name drupal7 -p 80:80 -p 9001:9001 -v path_on_host/docroot:/var/www/html drupal7
```

#### After the container starts, you'll be able to create a new screen in it and run bash - followed by drush or other commands:

```sh
$ docker run -it --name drupal7 -p 80:80 -p 9001:9001 drupal7
NOTICE: /var/www/html/sites/default/settings.php doesn't exist, creating DB and installing Drupal...
151217 10:38:30 mysqld_safe Can't log to error log and syslog at the same time.  Remove all --log-error configuration options for --syslog to take effect.
151217 10:38:30 mysqld_safe Logging to '/var/log/mysql/error.log'.
151217 10:38:30 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql
mysql root password: aiD3nieph9ch
drupal password: bah9pooBaad3
Project drupal (7.41) downloaded to /var/www/html.                                                                                                                                                                                                                 [success]
Project drupal contains:                                                                                                                                                                                                                                           [success]
 - 3 profiles: testing, standard, minimal
 - 4 themes: stark, bartik, seven, garland
 - 47 modules: drupal_system_listing_incompatible_test, drupal_system_listing_compatible_test, locale, contact, system, field_ui, menu, php, trigger, simpletest, path, tracker, poll, openid, toolbar, search, help, book, forum, shortcut, translation, options,
list, field_sql_storage, number, text, field, dblog, file, profile, overlay, contextual, aggregator, taxonomy, block, syslog, dashboard, color, comment, blog, update, node, filter, rdf, statistics, user, image

You are about to create a /var/www/html/sites/default/settings.php file and DROP all tables in your 'drupal' database. Do you want to continue? (y/n): y
Starting Drupal installation. This takes a while. Consider using the --notify global option.                                                                                                                                                                       [ok]
Installation complete.  User name: admin  User password: admin                                                                                                                                                                                                     [ok]
mkdir: cannot create directory '/var/www/html/sites/default/files': File exists
151217 10:38:48 mysqld_safe mysqld from pid file /var/run/mysqld/mysqld.pid ended
/usr/local/lib/python2.7/dist-packages/supervisor-3.2.0-py2.7.egg/supervisor/options.py:296: UserWarning: Supervisord is running as root and it is searching for its configuration file in default locations (including its current working directory); you probably want to specify a "-c" argument specifying an absolute path to a configuration file for improved security.
  'Supervisord is running as root and it is searching '
2015-12-17 10:38:57,252 CRIT Supervisor running as root (no user in config file)
2015-12-17 10:38:57,260 INFO RPC interface 'supervisor' initialized
2015-12-17 10:38:57,261 CRIT Server 'inet_http_server' running without any HTTP authentication checking
2015-12-17 10:38:57,262 INFO RPC interface 'supervisor' initialized
2015-12-17 10:38:57,263 CRIT Server 'unix_http_server' running without any HTTP authentication checking
2015-12-17 10:38:57,263 INFO supervisord started with pid 426
2015-12-17 10:38:58,266 INFO spawned: 'httpd' with pid 429
2015-12-17 10:38:58,269 INFO spawned: 'sshd' with pid 430
2015-12-17 10:38:58,271 INFO spawned: 'memcached' with pid 431
2015-12-17 10:38:58,289 INFO spawned: 'mysqld' with pid 437
2015-12-17 10:38:59,479 INFO success: httpd entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2015-12-17 10:38:59,480 INFO success: sshd entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2015-12-17 10:38:59,481 INFO success: memcached entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2015-12-17 10:38:59,482 INFO success: mysqld entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
[ctrl-a c]
# bash
root@0c18c1f6e39c:/# cd /var/www/html/
root@0c18c1f6e39c:/var/www/html# drush status
 Drupal version                  :  7.41
 Site URI                        :  http://default
 Database driver                 :  mysql
 Database hostname               :  localhost
 Database port                   :  3306
 Database username               :  drupal
 Database name                   :  drupal
 Drupal bootstrap                :  Successful
 Drupal user                     :
 Default theme                   :  bartik
 Administration theme            :  seven
 PHP configuration               :  /etc/php5/cli/php.ini
 PHP OS                          :  Linux
 Drush script                    :  /usr/local/bin/drush
 Drush version                   :  8.0.1
 Drush temp directory            :  /tmp
 Drush configuration             :
 Drush alias files               :
 Install profile                 :  standard
 Drupal root                     :  /var/www/html
 Site path                       :  sites/default
 File directory path             :  sites/default/files
 Temporary file directory path   :  /tmp
```
