
getconfig ()
{

if [ "$CONFIG_SEL" = "" ]; then
  CONFIG_SEL=linux
fi

CONFIG_FILE="config.$CONFIG_SEL"

if [ -f "$CONFIG_FILE" ]; then
. $CONFIG_FILE
else
fail "config file $CONFIG_FILE not found"
fi

}

