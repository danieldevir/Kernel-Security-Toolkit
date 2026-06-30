// kmalloc_check.cocci – Find missing NULL checks after kmalloc
// Usage: spatch --sp-file kmalloc_check.cocci --dir <kernel_dir> --no-includes

@@
expression ptr;
expression size;
@@

  ptr = kmalloc(size, GFP_KERNEL);
  ... when != if (ptr == NULL) { ... }
  ... when != if (!ptr) { ... }
