export const useUser = () => useState<string | undefined>('user', () => undefined)
export const useWebSocket = () => useState<WebSocket | undefined>('websocket', () => undefined)
