# UNDER CONSTRUCTION

# copi-node-monitor
Telegram message for node errors

# UNDER CONSTRUCTION
Every approximately 15 minutes your node will run copi-node-monitor.sh script which will check your node and message you at telegbram when there is something that needs attention.

## Step 1: Create Telegram Bot Using Botfather

In order to message you on telegram, we will create a telegram bot which you control the bot token for.

#### The following steps describe how to create a new bot:

* Contact [**@BotFather**](https://telegram.me/BotFather) in your Telegram messenger.
* To get a bot token, send BotFather a message that says **`/newbot`**.
* When asked for a name for your new bot choose something that ends with the word bot, so for example YOUR_NODE_NAMEbot.
* If your chosen name is available, BotFather will then send you a token.
* Save this token as you will be asked for it once you execute the install-coti-node-monitor.sh script.

Once your bot is created, you can set a custom name, profile photo and description for it. The description is basically a message that explains what the bot can do.

#### To set the Bot name in BotFather do the following:

* Send **`/setname`** to BotFather.
* Select the bot which you want to change.
* Send the new name to BotFather.

#### To set a Profile photo for your bot in BotFather do the following:

* Send **`/setuserpic`** to BotFather.
* Select the bot that you want the profile photo changed on.
* Send the photo to BotFather.

#### To set Description for your bot in BotFather do the following:

* Send **`/setdescription`** to BotFather.
* Select the bot for which you are writing a description.
* Change the description and send it to BotFather.

For a full list of command type /help

## Step 2: Obtain Your Chat Identification Number

Visit my dedicated telegram bot here [**@StafiChatIDBot**](https://t.me/StafiChatIDBot) for collecting your Chat ID that you will be asked for when you run install-copi-node-monitor.sh in Step 3 that follows.

## Step 3: Download & Setup The Scripts Required

<br>

Scripts to go here once ready


## Step 4: Test Telegram

Test that your telegram bot is setup correctly by running the following.

```
wget -O telegramtest.sh https://raw.githubusercontent.com/Geordie-R/copi-node-monitor/refs/heads/main/telegramtest.sh
sudo chmod +x telegramtest.sh && ./telegramtest.sh
```

Note: Anytime you want to run a telegram test in the future just run /home/coti/coti-node-monitor/telegramtest.sh

## Step 5: Test Copi Node Monitor

```
/home/coti/coti-node-monitor/coti-node-monitor.sh
```

Thats it! Now amend the config back to reasonable values by repeating Step 5 and you're good to go.
