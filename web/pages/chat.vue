<template>
    <div class="mx-auto container h-full mt-10">
        <div class="text-white">
            <div class="text-xl border-b py-2 flex gap-2 items-baseline">
                <div font-bold># General</div>
                <div class="text-sm">logged as {{ user }}</div>
            </div>
            <div class="flex flex-col py-4">
                <div v-for="message in messages" :key="message.id" hover="bg-#282b30"
                    class="py-2 flex gap-4 items-center px-1">
                    <div class="p-3 bg-#7289da rounded-full text-center">
                        {{ getInitials(message.username) }}
                    </div>
                    <div>
                        <div class="font-semibold">
                            {{ message.username }}
                        </div>
                        <div>
                            {{ message.message }}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
const user = useUser()
const router = useRouter();
const ws = ref<WebSocket>()

type WebSocketMessage = {
    id: string
    message: string
    user_id: string
    username: string
}

const messages = ref<WebSocketMessage[]>([])

function getInitials(name: string) {
    let initials = name.split(" ").map((n) => n[0]).join("").substring(0, 2)
    if (initials.length < 2) {
        initials = name.substring(0, 2)
    }
    return initials.toUpperCase()
}


if (!user.value) {
    router.push("/")
} else {
    ws.value = new WebSocket("ws://192.168.31.177:8000/ws")
    ws.value.onmessage = (e: MessageEvent) => {
        const message = JSON.parse(e.data) as WebSocketMessage
        messages.value.push(message)
    }
}

</script>
