From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gfx8: remove stale function declaration
Date: Wed, 3 Aug 2016 14:03:20 +0200
Message-ID: <da728fd1-0570-fc2b-834b-d8a713505cc0@vodafone.de>
References: <1470076249-27614-1-git-send-email-alexander.deucher@amd.com>
 <579FFE32.5030808@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <579FFE32.5030808-5C7GfCeVMHo@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMDIuMDguMjAxNiB1bSAwMzo1OCBzY2hyaWViIHpob3VjbTE6Cj4KPgo+IE9uIDIwMTblubQw
OOaciDAy5pelIDAyOjMwLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+IFRoaXMgZ290IGxlZnRvdmVy
IHNvbWVob3cgd2hlbiBJIGNsZWFuZWQgdGhpcyB1cC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBDaHVu
bWluZyBaaG91IDxkYXZpZDEuemhvdUBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCkknbSByZWFsbHkgd29uZGVyaW5nIHdo
eSB0aGUgc3RhdGljIGNvZGUgY2hlY2tlcnMgZG9uJ3QgY29tcGxhaW4gYWJvdXQgCnN1Y2ggdGhp
bmdzLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPj4gLS0tCj4+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4X3Y4XzAuaCB8IDIgLS0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlv
bnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OF8wLmggCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuaAo+PiBpbmRl
eCBiYzgyYzc5Li5lYmVkMWY4IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjhfMC5oCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OF8wLmgKPj4gQEAgLTI2LDYgKzI2LDQgQEAKPj4gICAgIGV4dGVybiBjb25zdCBzdHJ1Y3QgYW1k
X2lwX2Z1bmNzIGdmeF92OF8wX2lwX2Z1bmNzOwo+PiAgIC12b2lkIGdmeF92OF8wX3NlbGVjdF9z
ZV9zaChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMyIHNlX251bSwgCj4+IHUzMiBzaF9u
dW0pOwo+PiAtCj4+ICAgI2VuZGlmCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
