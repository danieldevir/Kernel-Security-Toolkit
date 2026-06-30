// deadlock_poc.c – Simple deadlock PoC (similar to QPSIIR-2072)
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

void* thread_a(void* arg) {
    pthread_mutex_lock(&lock);
    printf("[A] Lock acquired. Simulating error...\n");
    // ❌ Return without unlocking
    return NULL;
}

void* thread_b(void* arg) {
    sleep(1);
    printf("[B] Trying to acquire lock...\n");
    pthread_mutex_lock(&lock); // ⚠️ Deadlock here
    printf("[B] Acquired lock!\n");
    pthread_mutex_unlock(&lock);
    return NULL;
}

int main() {
    pthread_t t1, t2;
    pthread_create(&t1, NULL, thread_a, NULL);
    pthread_create(&t2, NULL, thread_b, NULL);
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    return 0;
}
