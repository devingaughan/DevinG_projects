import lightbulb
import hikari
import aiohttp


bot = lightbulb.BotApp(token='OTg0NjIxNTQyMzI5Njg4MTA0.Glk8iH.P47vtAbUI56SDfPm47aViR1BpesRzXlmVAmEEk', default_enabled_guilds=(984617688099872808))


@bot.listen(hikari.GuildMessageCreateEvent)
async def print_message(event):
    print(event.content)


@bot.listen(hikari.StartedEvent)
async def bot_started(event):
    print("bot has started")
## Bots ##
# order here is important #
@bot.command
@lightbulb.command('ping', 'Says Pong')
@lightbulb.implements(lightbulb.SlashCommand)
async def ping(ctx):
    await ctx.respond('pong!')


## Group Stuff ##
@bot.command
@lightbulb.command('group', 'This is a group')
@lightbulb.implements(lightbulb.SlashCommandGroup)
async def my_group(ctx): 
    pass

@my_group.child
@lightbulb.command('subcommand', 'This is a Subcommand')
@lightbulb.implements(lightbulb.SlashSubCommand)
async def subcommand(ctx):
    await ctx.respond('I am a subcommand')

## Options for Commands ##
@bot.command
@lightbulb.option('num2', 'second number', type=int)
@lightbulb.option('num1', 'first number', type=int)
@lightbulb.command('add', 'adding two numbers together')
@lightbulb.implements(lightbulb.SlashCommand)
async def add(ctx):
    await ctx.respond(ctx.options.num1 + ctx.options.num2)


## FETCH EMOTE FUNCTION ##
@bot.command
@lightbulb.command('fetchemote', 'responds with random emoji')
@lightbulb.implements(lightbulb.SlashCommand)
async def fetch_emote(ctx): # I got help with this function from Hikari offical Discord Server.
    async with aiohttp.ClientSession() as session:
        async with session.get('https://emoji-api.com') as resp:
             await ctx.respond(await resp.json()["emoji"]) # fetches dict
            # print(resp.text())
    # await ctx.respond(display)


    
bot.run() # allows the bot to be online