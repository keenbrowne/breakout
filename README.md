# Bonsai CLI & SDK
Build your own breakout BRAIN

## Install Dependencies

### Install the Bonsai CLI & Python SDK
```sh
pip install git+https://github.com/BonsaiAI/bonsaicli
pip install git+https://github.com/BonsaiAI/pythonsdk
```

### Install Breakout's dependencies
```sh
pip install -r requirements.txt
```

## Authenticate this CLI 
The following command will popup a web page that asks you to login once you 
login it has an access key you need and copy and paste into the terminal.

```sh
$ bonsai configure
You can get the access key at https://brains.bons.ai/accesskey
Access Key:
authenticated.
```

## Train the myBreakout BRAIN

Once your CLI is setup you can load inkling into your BRAIN, run the simulator
and begin training. Read breakout.py for more information about how the 
breakout game works with the BRAIN Server to train.

```sh
$ bonsai load mybreakout breakout.ink
loaded

$ python breakout.py --train --brain=<http link to BRAIN server>

$ bonsai brain train mybreakout
training started.
Training...
10000 trials, 90% accuracy 
Train complete.
```

## Using a trained myBreakout BRAIN

Once you've trained the BRAIN, it can play the game at any time.
```sh
$ python breakout.py --brain=<http link to BRAIN server>
```


