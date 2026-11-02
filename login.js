export async function onRequestPost(context) {
    const { request, env } = context;
    try {
        const { username, password } = await request.json();
        if (username === "113333") {
            return new Response(JSON.stringify({ success: true, role: "Boss", token: "session_boss_token" }), {
                headers: { "Content-Type": "application/json" }
            });
        }
        return new Response(JSON.stringify({ success: false, error: "Uthibitishaji umefeli" }), { status: 401 });
    } catch (err) {
        return new Response(JSON.stringify({ error: err.message }), { status: 500 });
    }
}
