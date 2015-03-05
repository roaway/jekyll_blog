deploy:
	jekyll b
	git add .
	git commit -a -m "update"
	git push -u origin master
	cd _site ;\
	git add . ;\
	git commit -a -m "update" ;\
	git push -u origin gh-pages ;
	git checkout master
