# Analysis-of-PayPal-Transactions
1. Project Overview:
This project analyzes a dataset of PayPal transactions to uncover insights into financial activities. It explores different types of transactions, customer behaviors, and potential fraudulent activities. By leveraging data analysis techniques, the project aims to provide a clearer understanding of transaction trends, success rates, and regional transaction distributions.

2. Problem Statement:
With the growing number of digital transactions, it becomes increasingly important to detect fraudulent activities, optimize payment processes, and understand customer transaction behaviors. This project addresses key challenges such as:

            Identifying patterns in successful and unsuccessful transactions.
            
            Detecting anomalies that might indicate fraudulent transactions.
            
            Analyzing transaction trends across different regions, platforms, and payment types.
            
            Providing actionable insights to improve financial decision-making.

3. Data Source:
The dataset, "Paypal_Transactions3.csv", contains 200 transaction records with the following key fields:
        
            Transaction ID – A unique identifier for each transaction.
            
            Type – The nature of the transaction (e.g., Charge, Refund).
            
            Transaction Type – Categorization into "Goods and Services" or "Friends & Family".
            
            Customer Name – The name of the customer involved.
            
            Total – The transaction amount.
            
            Success – Whether the transaction was successful (1) or not (0).
            
            Day – The date of the transaction.
            
            Transaction Notes – Additional details about the transaction.
            
            Source – The platform used for the transaction (Tablet, Phone, Desktop).
            
            Country – The country where the transaction originated.
            
            Auth Code – A unique authorization code for security purposes.
            
4. Methodology (Tools, Techniques, and Process Used)

   Tools Used:

            Python libraries: pandas, numpy, and datetime
            
            Jupyter Notebook for data analysis and visualization
            
            CSV file processing using pandas
            
   Techniques & Process:

            Data Loading & Cleaning

                        The dataset is loaded using pandas.read_csv().
                        
                        Irrelevant columns like "Transaction_ID" and "Auth_code" are dropped.
                        
                        Missing values in "Transaction_Notes" are filled with "N/A".
                        
                        The "Day" column is converted into a datetime format.
                        
            Data Exploration & Transformation

                        The project analyzes successful transactions only (Success == 1).
                        
                        Transaction trends over time are examined using .max() and .min().
                        
                        Categorical values like "Type", "Transaction_Type", "Country", and "Source" are analyzed for trends.
                        
            Statistical Analysis & Insights Extraction

                        Summary statistics are calculated using .describe().
                        
                        The distribution of transaction types, sources, and country-based transactions is analyzed.
                        
5. Key Insights (Trends and Findings)
   
   Transaction Success Rate is High
   
            97.5% of all transactions were successful, indicating a smooth payment process.
   
            Only 2.5% of transactions failed, which is relatively low.
   
   Charge Transactions Dominate
   
            88.5% of transactions are "Charge", meaning most transactions involve standard payments.

            Refunds account for 10%, while chargebacks make up only 1.5%, indicating minimal disputes.

   Goods & Services Transactions are More Common
   
            63% of transactions fall under "Goods and Services", while 37% are "Friends & Family" transactions.

            This suggests that PayPal is primarily used for business payments in this dataset.
   
   Most Transactions are from the US
   
            95.5% of transactions originate from the United States (US).

            The UK accounts for 4%, while Australia has only one transaction.

            This suggests that the dataset primarily represents PayPal users in the US market.
   
   Desktop is the Most Used Platform
   
            64.5% of transactions were made on a desktop, compared to 25% on mobile phones and 10.5% on tablets.

            This indicates that users prefer PayPal on desktop for financial transactions.
   
   Transaction Amounts Range from $450 to $4,996
   
            The average transaction amount is $3,144, with a standard deviation of $1,087.

            The highest transaction recorded was $4,996, while the lowest was $450.

            Most transactions fall within $2,256 – $3,995, suggesting mid-range payments are common.

6. Conclusion & Recommendations
   
   Conclusion:
      
            PayPal transactions in this dataset are highly successful (97.5%), showing strong reliability.
      
            Most payments are standard charges, with few refunds and chargebacks.
      
            Goods and Services transactions dominate, suggesting that business payments are a primary use case.
      
            Most users are from the US and prefer making transactions via desktop.
      
      Recommendations for PayPal / Business:
      
            Enhance Mobile Payment Experience:

            Since only 25% of transactions happen on mobile, PayPal should improve mobile UX to increase engagement.
            Expand to International Markets:
            
            Since 95.5% of transactions are from the US, PayPal should focus on growing its UK and Australian markets.
   
            Monitor Chargebacks Closely:
            
            Even though chargebacks are only 1.5%, they can indicate potential fraud or disputes. A fraud detection system should be in place.
      
            Target Business Users More:
            
            Since most transactions fall under "Goods & Services", PayPal should tailor more business-friendly features.


















