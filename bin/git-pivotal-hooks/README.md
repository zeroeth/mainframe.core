This script creates a prepare-commit-msg hook for git. Whenever you commit, 
it connects to Pivotal Tracker, gets all the stories you own on the given 
project, and adds the story number(s) to your commit message. With GitHub's 
Pivotal post-receive hook set up, that will add a link to each commit
to the relevant story on Pivotal whenever you push to GitHub.  

## Global setup   

Clone this repository somewhere. Hypothetically, let's say you stuck it in
"~/code/git-pivotal-hooks".

Make the setup script executable:

	chmod a+x gitpiv-setup.sh

Add the following to your .bashrc (replacing the path with the actual path to
your clone of this repository, of course):

	alias gitpiv=". ~/code/git-pivotal-hooks/gitpiv-setup.sh"

Great! Now whenever you have a local project you want to link to a Pivotal 
Tracker project, you can set it up as follows:  

## Project setup  

Make sure your current project is set up with git already. Then in the main 
directory of your current project, just run

	gitpiv

That will copy the appropriate prepare-commit-msg hook to your local .git hooks 
directory and make it executable for you. It'll also copy a file called 
{project_name}.sample in your ~/.pivrc directory.

Edit .pivrc.sample by filling in your Pivotal API token, project ID #, and initials 
(or whatever Pivotal uses to identify you on stories, I suppose) (or whatever
other filter(s) you prefer - but remember, spacing matters!), then rename the file:

	mv ~/.pivrc/{project_name}.sample ~/.pivrc/{project_name}

Now you can go to the admin settings for your GitHub repository and set up GitHub's 
Pivotal Tracker post-receive hook by putting in your same Pivotal API. 

That's it, you're good to go! Whenever you make a commit in that project, you'll get 
a list of all of your Pivotal stories, and the chance to choose which one(s) to add to 
your commit message so that the links to that commit will be added to the relevant 
Pivotal story/storieswhen you push to GitHub.

Major thanks to npetrell, whose active_stories.py provided the meat of the 
prepare-commit-msg here.
