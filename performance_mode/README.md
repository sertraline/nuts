# Set CPU to performance mode

```console
pacman -S cpupower
echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpufrequtils
sudo cpupower frequency-set --governor performance
```
