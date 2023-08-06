<template>
    {{ user }}
</template>

<script setup lang="ts">
const user = useUser()
const router = useRouter();

if (!user.value) {
    router.push("/")
}
</script>
