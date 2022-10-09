import os
from twilio.rest import Client


# Find your Account SID and Auth Token at twilio.com/console
# and set the environment variables. See http://twil.io/secure
account_sid = os.environ['AC60e7b1faefedf1c15e105f35bc2d9530']
auth_token = os.environ['b979b36e0718bbe25b3216ce03c1de34']
client = Client(account_sid, auth_token)

message = client.messages.create(
                              body='Hi there, Twilio here',
                              from_='+17014017064',
                              to='+917978939845'
                          )

print(message.sid)
