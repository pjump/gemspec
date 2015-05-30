## Versioning
### Version Number for Machines

This gem uses a slightly modified version of the **SemVer** specification, namely:
```ruby
    spec.version = "BREAKING.PATCHES.NONBREAKING"
```
You can use this versioning with your dependency tools, only you have a somewhat stronger guarantee that your
code won't break if you limit yourself to the third number, but you need to allow second level updates in order to
get (security and other) patches.

### Version Number for Humans
Since the above-described type of versioning doesn't tell you anything about the functional state of the gem (you can go from a "hello world" to a full blown operating system
without making a breaking change, as long as your operating system prints "hello world" to the screen) (SemVer, when used correctly, doesn't tell anything about the functional state of a software package either), a second, human-friendly version number can be found in `spec.metadata[:human_version]`.

The magnitude of this version number shall be made to correspond to actual functional changes in the software. If I've worked a lot on the package, I'll make it move a lot, but unless I've made breaking changes, I'll stick to only moving the third number in the `spec.version` version.

This number is for you. If you see it increase a lot, it probably means much more new goodies, but is less strictly defined then the version number for the machine.  (I reserve the right to later change the way I change this number).
