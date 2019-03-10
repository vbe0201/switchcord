# Contributing

Want to contribute? Great. First, read this page.

## 1. Reporting bugs

Encountered a bug? Report it then! Bug reports are very important to us because they help us improving this
software and make it more usable for everyone.

**Please follow some simple standards for bug reports:**
- Please completely fill out the bug report template.  
- Include your code, all necessary details and the full error you encountered.

## 2. Contributing Code

Before working on a new feature or a bug, please browse
[open issues](https://github.com/vbe0201/switchcord/issues?state=open) to check whether
this issue has been previously discussed. If you're planning major changes, it's always
better to open an issue for them to discuss the changes you're planning to make.
This way, we can support you and you can get feedback from others to see whether these changes are even
appreciated.

### Cloning the project

First of all, you need to fork https://github.com/vbe0201/switchcord to your GitHub account. Then you can clone the project and
start working on it.
```git
git clone https://github.com/<Your-Username>/switchcord
cd switchcord
```

### Adding changes

Now that you've got a local copy of switchcord, start working on it. Create a new branch and check it out.
```git
git checkout -b my_cool_new_feature
```

### Committing your changes

So, you cloned the project, created a feature branch and implemented something? Great!
Now it's time for you to commit your changes:
```git
git commit -m "A descriptive and short message about the changes you made."
```

Assuming your branch is called `my_cool_new_feature`, you need to push it to GitHub in order to create a pull request.
```git
git push origin my_cool_new_feature
```

And then you're all ready! Use GitHub's interface to create a pull request for Switchcord to the `dev` branch,
fill out the template and we'll review it.

**Important: Please do not change Switchcord's version yourself. That's what we do instead.**