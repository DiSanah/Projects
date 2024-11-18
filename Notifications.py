
import requests
from bs4 import BeautifulSoup
import smtplib
import time


Product_link = 'https://www.bol.com/nl/nl/p/nuvona-theepot-met-filter-en-theelicht-warmhouder-borosilicaat-glas-voor-losse-thee-theebloemen-rvs-zeef-1-5l/9300000173898983/?bltgh=hMcuxHE94UAYDjs9tYBPuw.2_13.14.ProductTitle'

#Identifies the client making the request to the server (me - replace for your computer)
headers = {"User-Agent": 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.4 Safari/605.1.15'}

#Improving redability by listing values
desired_price = 20 #Сhange this one to >25 for it to work!!!
one_day_delay = 86400 #1 day in seconds
mail_port = 587 #gmail port to establish connection
mail_subject = 'Price fell down for a Teapot you wanted!'
mail_body = 'Check the link! https://www.bol.com/nl/nl/p/nuvona-theepot-met-filter-en-theelicht-warmhouder-borosilicaat-glas-voor-losse-thee-theebloemen-rvs-zeef-1-5l/9300000173898983/?bltgh=hMcuxHE94UAYDjs9tYBPuw.2_13.14.ProductTitle'


def check_if_price_fell_down():
    page = requests.get(Product_link, headers=headers)
    soup = BeautifulSoup(page.content, 'html.parser') #pulls a whole HTML file to read and make searched in it

    product_title = soup.find(class_='u-mr--xs', attrs={'data-test': 'title'}).get_text() #class of a name tag from an HTML website 
    current_price = soup.find(class_='promo-price', attrs={'data-test': 'price'}).get_text() #class of a price tag from an HTML website 
    #removes last 2 numbers off the price (in my case decimals)
    whole_price_number = int(current_price[:2])

    #Check if function pulls name and price correctly
    print(product_title)
    print(whole_price_number)
    
    if(whole_price_number < desired_price):
        send_mail_when_price_lower()

def send_mail_when_price_lower():
    server = smtplib.SMTP('smtp.gmail.com', mail_port)
    server.ehlo()
    server.starttls()
    server.ehlo()

    server.login('pythonpersonalporfolio@gmail.com', 'password') #email and password via which mail will be sent

    mail_messege = f"Subject:{mail_subject}\n\n{mail_body}"

    server.sendmail('pythonpersonalporfolio@gmail.com', 'pythonpersonalporfolio@gmail.com', mail_messege)
    print('Mail was sent!')
    server.quit()

#check price every day
while(True):
    check_if_price_fell_down()
    time.sleep(one_day_delay)