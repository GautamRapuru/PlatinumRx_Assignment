def Convertion(minutes):
    hour=minutes//60 #gives hours
    remaining_minutes=minutes-hour*60 #gives minutes
    converted_string="{} hours {} minutes" 
    print(converted_string.format(hour,remaining_minutes))
    

minutes = int(input()) #give input in integer format

Convertion(minutes) #calling function