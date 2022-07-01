---
title: Phillip Pay

language_tabs: # must be one of https://git.io/vQNgJ
  - PHP
  - Java
  - JavaScript

includes:
  - errors

search: true

code_clipboard: true

meta:
  - name: description
    content: Document for Phillip Pay
---

# Introduction

Welcome to the Phillip Pay! 

With our sandbox environment, you can integrate your system to PhillipBank's payment gateway and test to make payment from Phillip Mobile to testing account. This is the sandbox environment so the transaction will only reflection in testing environment. You can mimic the whole customer journey from start to success with online payment.

We have language bindings in PHP, Java, and JavaScript!

# Mobile Payment
## Authentication
> To generate the access token, use this code:

```php
$curl = curl_init();
curl_setopt_array($curl, array(
  CURLOPT_URL => $url,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'{
    "grant_type" : "client_credentials",
	  "client_id"  : "9501d6df-d0c3-4f33-8bf1-eee5cc7a486e",
	  "client_secret" : "59Pr4UuXwkfZX7QDVOh143Vq3UEEmplEEPvJmT2T",
	  "scope" : "txn-create"
}'));
$response = curl_exec($curl);
curl_close($curl);
echo $response;
```

```java
HttpClient httpClient = HttpClientBuilder.create().build();
HttpPost post  = new HttpPost(postUrl);
StringEntity postingString = new StringEntity(gson.toJson(pojo1));
post.setEntity("{
    \"grant_type\": \"client_credentials\",
    \"client_id\": \"9501d6df-d0c3-4f33-8bf1-eee5cc7a486e\",
    \"client_secret\": \"59Pr4UuXwkfZX7QDVOh143Vq3UEEmplEEPvJmT2T\",
    \"scope\": \"txn-create\"
    }");
post.setHeader("Content-type", "application/json");
HttpResponse  response = httpClient.execute(post);
```

```javascript
var myHeaders = new Headers();
myHeaders.append("Content-Type", "application/json");
var raw = JSON.stringify({
  "grant_type": "client_credentials",
  "client_id": "9501d6df-d0c3-4f33-8bf1-eee5cc7a486e",
  "client_secret": "59Pr4UuXwkfZX7QDVOh143Vq3UEEmplEEPvJmT2T",
  "scope": "txn-create"
});
var requestOptions = {
  method: 'POST',
  headers: myHeaders,
  body: raw,
};
fetch(url, requestOptions)
  .then(response => response.text())
  .then(result => console.log(result))
  .catch(error => console.log('error', error));
```
> Above request will return below JSON Object

```json
{
    "token_type": "Bearer",
    "expires_in": 31536000,
    "access_token": "eyAI14!J2aXrpQ21AO==="
}
```

### HTTP Request

`POST https://api-uat145.phillipbank.com.kh:8441/oauth/token`

### Request Body
<table>
  <tr>
    <th>Parameter</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>client_id</td>
    <td>an UUID String from bank to partner</td>
  </tr>
  <tr>
    <td>client_secret</td>
    <td>combine this with client_id to get the token</td>
  </tr>
</table>

### Response 

Variable | Description 
-------------- | -------------- 
token_type | Token type to authorize in request header to [Initiate](#initiate-payment) and [Check](#check-payment)
expires_in | Expiration of token in milliseconds
access_token | Token to authorize in request header to [Initiate](#initiate-payment) and [Check](#check-payment)


## Initiate Payment

```php
$curl = curl_init();
curl_setopt_array($curl, array(CURLOPT_URL => $url, CURLOPT_RETURNTRANSFER => true,CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'{
    "partner_id": "sanbox",
    "merchant_id": "12345",
    "merchant_name": "Sandbox Merchant",
    "merchant_city": "Phnom Penh",
    "merchant_category": "5814",
    "merchant_rdn": "example.com",
    "phone": "012345678",
    "payload": "Item1, Item2,",
    "txn_id": "INV_82091-9001",
    "label": "Invoice No",
    "currency": "USD",
    "amount": 10.75, 
    "fee": 0.0,
    "country_code": "KH",
    "success_redirect": "https://www.example.com/redirect_payment_sucess",
    "fail_redirect": "https://example.com/redirect_payment_fail"
}',
  CURLOPT_HTTPHEADER => array('Authorization: Bearer eyAI14!J2aXrpQ21AO===','Content-Type: application/json')));
$response = curl_exec($curl);
curl_close($curl);
echo $response;
```

```java
HttpClient httpClient = HttpClientBuilder.create().build();
HttpPost post  = new HttpPost(postUrl);
StringEntity postingString = new StringEntity(gson.toJson(pojo1));
post.setEntity("{
  \"partner_id\": \"sanbox\",
  \"merchant_id\": \"12345\",
  \"merchant_name\": \"Sandbox Merchant\",
  \"merchant_city\": \"Phnom Penh\",
  \"merchant_category\": \"5814\",
  \"merchant_rdn\": \"example.com\",
  \"phone\": \"012345678\",
  \"payload\": \"Item1, Item2,\",
  \"txn_id\": \"INV_82091-9001\",
  \"label\": \"Invoice No\",
  \"currency\": \"USD\",
  \"amount\": 10.75, 
  \"fee\": 0.0,
  \"country_code\": \"KH\",
  \"success_redirect\": \"https://www.example.com/redirect_payment_sucess\",
  \"fail_redirect\": \"https://example.com/redirect_payment_fail\"\r\n}");
post.setHeader("Content-type", "application/json");
post.setHeader("Authorization", "Bearer eyAI14!J2aXrpQ21AO===");
HttpResponse  response = httpClient.execute(post);
```

```javascript
var myHeaders = new Headers();
myHeaders.append("Authorization", "Bearer eyAI14!J2aXrpQ21AO===");
myHeaders.append("Content-Type", "application/json");
var raw = JSON.stringify({
  "partner_id": "sanbox",
  "merchant_id": "12345",
  "merchant_name": "Sandbox Merchant",
  "merchant_city": "Phnom Penh",
  "merchant_category": "5814",
  "merchant_rdn": "example.com",
  "phone": "012345678",
  "payload": "Item1, Item2,",
  "txn_id": "INV_82091-9001",
  "label": "Invoice No",
  "currency": "USD",
  "amount": 10.75,
  "fee": 0,
  "country_code": "KH",
  "success_redirect": "https://www.example.com/redirect_payment_sucess",
  "fail_redirect": "https://example.com/redirect_payment_fail"
});
var requestOptions = { method: 'POST', headers: myHeaders, body: raw };
fetch(url, requestOptions)
  .then(response => response.text())
  .then(result => console.log(result))
  .catch(error => console.log('error', error));
```

> Above request will return below JSON Object

```json
{
    "success": true,
    "message": "Transaction created successfully",
    "data": {
        "txn_id": "INV_82091-9002",
        "url":"https://api-uat145.phillipbank.com.kh:8441/pay?token=123"
    }
}
```


### HTTP Request

`POST https://api-uat145.phillipbank.com.kh:8441/oauth/token`

### Request Header

Field | Required | Description
----- | -------- | ----
Authorization | Yes | Authorized from [Authenticate](#authentication)   

### Request Body
<table>
  <tr>
    <th>Variable</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>partner_id</td>
    <td>An integration partner ID provided by the bank</td>
  </tr>
  <tr>
    <td>merchant_id</td>
    <td>Merchant ID registered at the bank</td>
  </tr>
  <tr>
    <td>merchant_name</td>
    <td>Name to show in Transaction</td>
  </tr>
  <tr>
    <td>merchant_city</td>
    <td>City of trx of operating merchant</td>
  </tr>
  <tr>
    <td>merchant_category</td>
    <td>Merchant category code by following EMV standard</td>
  </tr>
  <tr>
    <td>merchant_rdn</td>
    <td>Merchant website, social media page...</td>
  </tr>
  <tr>
    <td>phone</td>
    <td>Merchant or merchant's outlet phone number</td>
  </tr>
  <tr>
    <td>payload</td>
    <td>Merchant item list</td>
  </tr>
  <tr>
    <td>txn_id</td>
    <td>The unique transaction ID between Partner and PhillipBank.</td>
  </tr>
  <tr>
    <td>label</td>
    <td>Label by merchant to show txn_id as</td>
  </tr>
  <tr>
    <td>currency</td>
    <td>Payment currency either USD or KHR</td>
  </tr>
  <tr>
    <td>amount</td>
    <td>Payment amount</td>
  </tr>
  <tr>
    <td>fee</td>
    <td>For showing purpose at merhcant only</td>
  </tr>
  <tr>
    <td>country_code</td>
    <td>ISO standard country code only KH</td>
  </tr>
  <tr>
    <td>success_redirect</td>
    <td>Redirect URL upon payment success at PhillipBank</td>
  </tr>
  <tr>
    <td>fail_redirect</td>
    <td>Redirect URL upon payment failed at PhillipBank</td>
  </tr>
</table>

### Response 

<table>
  <tr>
    <th>Variable</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>txn_id</td>
    <td>The transaction ID initiated by the partner stored at bank side.</td>
  </tr>
  <tr>
    <td>url</td>
    <td>The URL to create payment request and complete the payment.</td>
  </tr>
</table>

<aside class="success">
Open URL within a webview (within application) or device browser (external) to complete the transaction with Phillip Mobile.

This endpoint will create a request for payment from customer at Phillip Pay system.

Complete the payment by scanning QR or deeplinking with Phillip Mobile.
</aside>

## Check Payment

```php
$curl = curl_init();
curl_setopt_array($curl, array(
  CURLOPT_URL => $url,
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS =>'{
    "merchant_id": "12345",
    "txn_id": "INV_82091-9001"
    }',
  CURLOPT_HTTPHEADER => array(
    'Authorization: Bearer eyAI14!J2aXrpQ21AO===',
    'Content-Type: application/json'
  ),
));
$response = curl_exec($curl);
curl_close($curl);
echo $response;
```

```java
HttpClient httpClient = HttpClientBuilder.create().build();
HttpPost post  = new HttpPost(postUrl);
StringEntity postingString = new StringEntity(gson.toJson(pojo1));
post.setEntity("{
  \"merchant_id\": \"12345\",
  \"txn_id\": \"INV_82091-9001\"
  }");
post.setHeader("Content-type", "application/json");
post.setHeader("Authorization", "Bearer eyAI14!J2aXrpQ21AO===");
HttpResponse  response = httpClient.execute(post);
```

```javascript
var myHeaders = new Headers();
myHeaders.append("Authorization", "Bearer eyAI14!J2aXrpQ21AO===");
myHeaders.append("Content-Type", "application/json");

var raw = JSON.stringify({
  "merchant_id": "12345",
  "txn_id": "INV_82091-9001"
});
var requestOptions = {
  method: 'POST',
  headers: myHeaders,
  body: raw,
};

fetch("https://api-uat145.phillipbank.com.kh:8441/api/check/transaction", requestOptions)
  .then(response => response.text())
  .then(result => console.log(result))
  .catch(error => console.log('error', error));
```

> The above command returns JSON structured like this:

```json
{
    "success": true,
    "message": "Transaction status retrieved successfully",
    "data": {
        "txn_status": "PENDING"
    }
}
```

### HTTP Request

`POST https://api-uat145.phillipbank.com.kh:8441/api/check/transaction`

### Request Body

<table>
  <tr>
    <th>Variable</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>merchant_id</td>
    <td>Merchant ID registered at the bank.</td>
  </tr>
  <tr>
    <td>txn_id</td>
    <td>The transaction ID  between Partner and PhillipBank.</td>
  </tr>
</table>

### Reponse
<table>
  <tr>
    <th>Variable</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>txn_status</td>
    <td>Status of payment, it can be SUCCESS, PENDING, and FAILED.</td>
  </tr>
</table>

# Card Payment
Coming Soon!
# Open API (PSD2)
Coming Soon!
