# dfh
`df -h` in Cron with Slack notifications

## Installation

```shell
eval "$(curl "https://raw.githubusercontent.com/michaelradionov/gg_installer/master/gg_installer.sh")" && gg_installer dfh
```

## Usage

```
dfh [-d <website_path_where_env_is> | -sw <slack_channel_url>] [-sс <slack_channel>] [-l <disk_space_alert_percentage>]
```

## Usage with Cron

```shell
crontab -e
```
then insert
```shell
# Disk Space Monitoring
WEBSITE_PATH=/path/to/website
SLACK_CHANNEL=channel-name-without-hash
0 * * * * /bin/bash -c "source /root/.gg_tools/dfh.sh && cd "$WEBSITE_PATH" && dfh -sc "$SLACK_CHANNEL""
0 1 * * * /bin/bash -c "source /root/.gg_tools/dfh.sh && cd "$WEBSITE_PATH" && dfh -sc "$SLACK_CHANNEL" -l 80"
```