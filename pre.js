Module['stdin'] = function(){ return "root"; }
Module['arguments'] = []
Module['arguments'].push("-k");
Module['arguments'].push("Image");
Module['arguments'].push("-b");
Module['arguments'].push("minimal.dtb");
Module['arguments'].push("-i");
Module['arguments'].push("rootfs.cpio");
