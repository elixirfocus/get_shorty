# Glossary

A place to document the application's **ubiquitous language**, a consistent language that describes the domain model of the application. This ubiquitous language should be pervasive through the entirety of the business and application, from the marketing, user experience, code and back again. 

Development of ubiquitous language is a group exercise. It should match real world terminology use and not be idealized. When building a domain model for an application or business of a certain size and/or complexity sometimes parts of that business/application need to be separated into distinct domains, each their own ubiquitous languages. This is not ideal but sometimes necessary. For more info, read up on Domain-Driven Design.

This is a living document and if it is observed that any terms of the glossary no longer represent the true ubiquitous language this glossary and related code should be revisited. We place high value on ubiquitous language and it is worth the extra refactoring time to make sure it is honored fully. 

--- 

## Terms

* **Get Shorty:** An open-source link shortener written in Elixir and Phoenix.
* **Link:** The address of a webpage. Technical users may use the term URL but to make the service more approachable by non-technical users we instead prefer link. 
  * **Long Link:** When referring to the link that a short link redirects a user to, the destination is to be refereed to as the long link.
  * **Short Link:** The link that a user generates using this service. A short link will redirect a user to a long link that was provided when a short link was created.
* **Token:** The unique path ending section of the short link.
* **URL:** An abbreviation for Uniform Resource Locator. When exposing internal behavior or describing things to a user, please use the term link and not URL.
* **User:** Someone who visits our website to generate short links or has clicked a previous generated short link from our service is considered a user.
