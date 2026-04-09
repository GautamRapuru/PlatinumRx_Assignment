def unique_string(string):
    result="" #intialize the result with empty string
    for char in string: #iterate through every character
        if char not in result: #checks with result string
            result=result+char
    print(result)
    
    
    
string=input() #give the input as string
unique_string(string) #call the function