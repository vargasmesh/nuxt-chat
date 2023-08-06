<template>
    <div class="mx-auto container h-full mt-10">
        <div class="text-white">
            <div class="text-xl border-b py-2 flex gap-2 items-baseline">
                <div font-bold># General</div>
                <div class="text-sm">logged as {{ user }}</div>
            </div>
            <div class="flex flex-col py-4">
                <div v-for="message in messages" :key="message" hover="bg-#282b30" class="py-2">
                    {{ message }}
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
const user = useUser()
const router = useRouter();
const ws = ref<WebSocket>()
const messages = ref<string[]>([])

if (!user.value) {
    router.push("/")
} else {
    ws.value = new WebSocket("ws://192.168.31.177:8000/ws")
    ws.value.onmessage = (e) => {
        messages.value.push(e.data)
    }
}

</script>
