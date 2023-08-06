<template>
    <div class="fixed w-full h-full bg-#1e2124">
        <div class="mx-auto container flex items-center justify-center h-full">
            <div class="bg-#7289da max-w-sm w-full p-4 rounded">
                <form @submit.prevent="onSubmit">
                    <label for="name" class="text-white select-none font-semibold">Enter you name</label>
                    <div flex items-center gap-2>
                        <input name="name" class="w-full py-1 px-2 rounded focus:outline-none" v-model="user" />
                        <button class="p-2 rounded">
                            <div i-heroicons-arrow-right></div>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>


<script setup lang="ts">
const user = useUser()
const router = useRouter();


function onSubmit() {
    router.push("/chat")
}
</script>
