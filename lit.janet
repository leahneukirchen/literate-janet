#!/usr/bin/env janet
```
% Literate Janet
% Leah Neukirchen
% 2020-03-07

This is a literate Janet program to generate Markdown from literate Janet.
You can use it like this:

	janet lit.janet < lit.janet |
		pandoc --standalone --syntax-definition=janet.xml > lit.html

Literate Janet misuses the backquote-string feature of Janet to
delimit code blocks.  Literate Janet programs are actually plain
valid Janet code!

This program just strips the first and the last fence, and the leading
shebang line if it exists.  Opening fences are modified to enable
syntax highlighting.

## Helper functions
```
(defn gets []
  (file/read stdin :line))

(defn fence? [buf]
  (deep= buf @"```\n"))
```

## The main program

```
(var line (gets))

# Skip shebang if it exists.
(when (string/has-prefix? "#!" line)
  (set line (gets)))

# Skip first fence.
(if (fence? line)       
  (set line (gets))
  (eprint "Warning: file does not start with a fence."))

(var next-line nil)
(var fenced false)
(while (set next-line (gets))
  (when (fence? line)
    (unless fenced
      (set line @"```{.janet}\n"))
    (set fenced (not fenced)))
  (prin line)
  (set line next-line))

# Skip last fence.
(unless (fence? line)
  (eprint "Warning: file does not end with a fence.")
  (prin line))

```

## License

To the extent possible under law, the creator of this work has waived
all copyright and related or neighboring rights to this work.

<http://creativecommons.org/publicdomain/zero/1.0/>


```
