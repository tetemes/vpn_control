# vpn_control
Customized Patrick MyLund's one.sh script. (See http://patrickmylund.com/projects/one/ for more information.)

In it's original form, that script does not clean-up, does not recognize when the subprocess is stopped.

I added control over the subprocess. When the subprocess is terminated, one.sh script cleans up, so it can be started again.
Same usage, and I control the subprocess with start and stop scripts.
