# ChristBASHTree

You know, a Christmas tree on Bash :)

![Screenshot](./screenshot.png?raw=true)

# Usage

Via cURL:

```
curl https://raw.githubusercontent.com/sergiolepore/ChristBASHTree/master/tree.sh | bash
```

Via Wget:

```
wget -qO- https://raw.githubusercontent.com/sergiolepore/ChristBASHTree/master/tree.sh | bash
```

Docker:

```
docker pull sergiolepore/christbashtree:latest
docker run -it sergiolepore/christbashtree:latest
```

Git clone and execute:

```
git clone https://github.com/sergiolepore/ChristBASHTree.git && cd ./ChristBASHTree && bash tree.sh
```

You can override the language with the `LANG` env variable.

```
LANG=es_ES.UTF-8 tree.sh
```

__Enjoy!__

# FAQ

## License?

[Do what you want with it](./LICENSE) license.

## Will it run under _whatever-OS_?

Only GNU/Linux and Unix flavors.

## What OS are you using?

Ubuntu 17.10.

## What about your terminal emulator?

[Tilix](https://gnunn1.github.io/tilix-web/)

## And your color palette?

Custom, based on Atom's "One Dark" theme.

## Contributors

[Here](https://github.com/sergiolepore/ChristBASHTree/graphs/contributors)
