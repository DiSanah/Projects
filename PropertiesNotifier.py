
import requests
from bs4 import BeautifulSoup
import smtplib
import time

# Improving redability by listing values
Housing_website_link = 'https://plaza.newnewnew.space/en/availables-places/living-place#?gesorteerd-op=prijs%2B'
headers = {"User-Agent": 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.4 Safari/605.1.15'}
mail_port = 587 #gmail port to establish connection
mail_subject = 'New property appeared!'
mail_body = 'Check this email: https://plaza.newnewnew.space/en/availables-places/living-place#?gesorteerd-op=prijs%2B'


def check_new_properties():
    page = requests.get(Housing_website_link, headers=headers)
    soup = BeautifulSoup(page.text, 'html.parser') #pulls a whole HTML file to read and make searched in it
    
    # look for a class with a properties listing in it
    listings = soup.find_all(class_='woningaanbod-lijst')
    # array to store new properties
    new_properties = []
    
    # in theory should go through all elements in a list and get their name and link
    for listing in listings:
        title = listing.find("address-part ng-binding").get_text()
        link = listing.find('a')['href']
        print(listings)
        print(link)
        

       # if is_new_listing(title):  # Function to check if it's new
            #new_properties.append(f"{title}: {link}")
           
    
    if new_properties:
        send_mail("\n".join(new_properties)) #joins all array elements in one string each with a new line 


#def is_new_listing():
    # This function could check if the property is new 


# Send an email notification
def send_mail():
    server = smtplib.SMTP('smtp.gmail.com', mail_port)
    server.starttls()
    server.login('pythonpersonalporfolio@gmail.com', 'xoSnyr-7rabhi-fuwsor')
    mail_message = f"Subject: {mail_subject}\n\n{mail_body}"
    server.sendmail('pythonpersonalporfolio@gmail.com', 'pythonpersonalporfolio@gmail.com', mail_message)
    print("Messege sent!")
    server.quit()

check_new_properties()

while(True):
    check_new_properties()
    time.sleep(86400)


