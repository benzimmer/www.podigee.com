# www.podigee.com - Our marketing site

## Used software

- [hugo static site generator](https://gohugo.io)
- [brunch asset compilation](https://brunch.io)

## Writing / Development

Start hugo and brunch
```
hugo server

brunch watch
```

Go to <http://localhost:1313/> to see the site.

## Deployment

The site is deployed via Codeship to Amazon S3. Just push either `develop` or `master` to trigger a build.

- `master` => www.podigee.com
- `develop` => staging-www.podigee.com