Hey everyone,

You are all in bcc, which is why this email looks like I sent it to myself.

Tomorrow is our workshop! You signed up for the Practical introduction to relational databases by Gabor Javorszky, hence this email.

I'm excited to see y'all shortly! Bit of a housekeeping first:

If you'd like to follow along on your own computer there are a few things you will need before we begin. If you're okay watching me do things and reviewing the video when it becomes available, then you can safely ignore the rest of the email. :)

The things you will need to follow along:

A Github account. If you don't have one, now is as good a time as any to create one! Head on over to https://github.com/ to sign up.
A supabase account. You may have seen Jon Meyers's lightning talk about it. I'll be using that to provide an easy way to have a postgres database in your hands. You do need to have a Github account to create an account with them though. They are at https://supabase.io/. The sign up button is called "Start your project" in the upper right corner.
Within supabase, once you're in, create a new project. Name it anything you'd like, create a strong database password and save it in a password manager or somewhere you won't forget, and pick a region. It does not matter which region you choose for what we're going to be doing.
Make a note of your project anon/public key and your project url. We'll need both of these shortly.
Have nodejs and npm/yarn installed locally. This is needed to compile / generate / serve the scaffolding code. I'm on a mac, I use nvm (https://github.com/nvm-sh/nvm) to manage my node stuff. There are a bunch of different ways to install it, the canonical one is through their official site: https://nodejs.org/en/.
Make sure you have this repository cloned locally someplace: https://github.com/javorszky/jamstack-workshop-db-2021. I plan on adding some more code before our workshop begins, so I'll ask everyone to pull latest main branch before we begin.
In the directory, rename the .env.example file, and replace the example values with the supabase project anon key and project url from step 4. If you need to find them again, it's in Settings (cog icon on the left edge of the site), and API menu item in the settings page.
Run npm install to pull all dependencies.
And I'll see you at the workshop!

Until tomorrow!
Gabor
