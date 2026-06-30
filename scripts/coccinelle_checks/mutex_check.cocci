// mutex_check.cocci – Find missing mutex_unlock in error paths
// Usage: spatch --sp-file mutex_check.cocci --dir <kernel_dir> --no-includes

@@
struct mutex *lock;
expression E;
@@

  mutex_lock(lock);
  ... when != mutex_unlock(lock)
  return E; // ❌ Lock not released
