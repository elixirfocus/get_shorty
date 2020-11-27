# GetShorty Ideas

## Tools

* Install TailwindCSS for styling.
* Deploy to [Gigalixir](https://www.gigalixir.com/).
* Use Lets Encrypt to have SSL.
* Dockerize app for GitHub Actions testing / deployment.

## Behaviors

* From homepage, make a short link.
* On the create result page
	* Use a url like https://getshorty.app/abc123/xyz456
	* This is a secret report page for the link.
	* From here you can see how often the link was expanded.

* What should we record for an expanded link?
	* How can we filter out "my traffic".

* A getshorty link posted to slack / twitter should show the target's meta card preview.

* While getshorty.app will be a public site, offer instructions to host on gigalixir under your own domain.
	* Selfhosted apps could have an admin page showing a master report of all links.

## Bad Ideas

* On the create result page, offer the ability to enter email.
	* We'll email you reports of the link use? 
	* Prob a bad idea since I don't want to make an account system.