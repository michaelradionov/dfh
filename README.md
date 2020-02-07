# Disk space monitoring script
`df -h` in Cron with Slack notifications

## Installation

```shell
eval "$(curl "https://raw.githubusercontent.com/michaelradionov/gg_installer/master/gg_installer.sh")" && gg_installer dfh
```

## Usage

```
dfh [-d <website_path_where_env_is> | -sw <slack_channel_url>] [-sс <slack_channel>] [-l <disk_space_alert_percentage>]
```

- `-d` parameter accepts path to your website's `.env` file where you set Slack webhook URL with `LOG_SLACK_WEBHOOK_URL` variable. Default value is `.` (current directory). This parameter in `.env` file should look like this
```shell
LOG_SLACK_WEBHOOK_URL=https://hooks.slack.com/services/blablabla
```
- `-sw` parameter accepts Slack webhook URL. It is useful if you don't have `.env` file with `LOG_SLACK_WEBHOOK_URL` variable
- `-sc` parameter used to define Slack channel for notifications. Please notice that you should omit "#" when defining channel. Like **#monitoring** => `-sc monitoring`. Also you can set **@username**
- `-l` parameter accepts limitation percentage at which notification should be sent like `-l 80`. Default value is **90%**.


## Usage with Cron

```shell
crontab -e
```
then insert
```shell
WEBSITE_PATH=/path/to/website
SLACK_CHANNEL=channel-name-without-hash

# Disk Space Monitoring
0 * * * * /bin/bash -c "source /root/.gg_tools/dfh.sh && dfh -d "$WEBSITE_PATH" -sc "$SLACK_CHANNEL""
0 1 * * * /bin/bash -c "source /root/.gg_tools/dfh.sh && dfh -d "$WEBSITE_PATH" -sc "$SLACK_CHANNEL" -l 80"
```

This will work **only** if you have `.env` file with `LOG_SLACK_WEBHOOK_URL` variable set. If it's not convenient for you, then just pass one more flag to script `-sw https://hooks.slack.com/services/blablabla` and you are all set!