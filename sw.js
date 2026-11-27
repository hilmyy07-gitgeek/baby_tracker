const C='bayi-v3';
self.addEventListener('install',()=>self.skipWaiting());
self.addEventListener('activate',e=>e.waitUntil(clients.claim()));
self.addEventListener('fetch',e=>{
  const u=new URL(e.request.url);
  if(e.request.method!=='GET'||!(u.origin===location.origin||u.hostname==='cdn.jsdelivr.net'))return;
  e.respondWith(caches.open(C).then(async c=>{
    const m=await c.match(e.request);
    const n=fetch(e.request).then(r=>{if(r.ok||r.type==='opaque')c.put(e.request,r.clone());return r}).catch(()=>m);
    return m||n;
  }));
});
