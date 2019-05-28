From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add DRIVER_SYNCOBJ_TIMELINE to amdgpu
Date: Tue, 28 May 2019 09:38:23 +0200
Message-ID: <4e147e0d-fa0d-ce56-8dfd-e1bdce390a01@gmail.com>
References: <20190528025203.11593-1-david1.zhou@amd.com>
 <3e5a2a4c-f4b5-d600-30a4-ce6e50e2cd72@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3e5a2a4c-f4b5-d600-30a4-ce6e50e2cd72-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: "Cui, Flora" <fcui-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>

UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
CkFtIDI4LjA1LjE5IHVtIDA1OjA1IHNjaHJpZWIgQ3VpLCBGbG9yYToKPiB0aGUgcGF0Y2ggaXMg
UmV2aWV3ZWQtYnk6IEZsb3JhIEN1aSA8RmxvcmEuQ3VpQGFtZC5jb20+Cj4KPiDlnKggNS8yOC8y
MDE5IDEwOjUyIEFNLCBDaHVubWluZyBaaG91IOWGmemBkzoKPj4gQ2hhbmdlLUlkOiBJMmIxYWYx
NDc4ZmJkZGJiNTA4NGI5MGIzZmY4NWMyZWI5NjRiZDIxNwo+PiBTaWduZWQtb2ZmLWJ5OiBDaHVu
bWluZyBaaG91IDxkYXZpZDEuemhvdUBhbWQuY29tPgo+PiAtLS0KPj4gICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgMyArKy0KPj4gICAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2Rydi5jCj4+IGluZGV4IDc4NzA2ZGZhNzUzYS4uMWYzOGQ2ZmMxZmUzIDEw
MDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4+IEBAIC0xMzA3
LDcgKzEzMDcsOCBAQCBzdGF0aWMgc3RydWN0IGRybV9kcml2ZXIga21zX2RyaXZlciA9IHsKPj4g
ICAgCS5kcml2ZXJfZmVhdHVyZXMgPQo+PiAgICAJICAgIERSSVZFUl9VU0VfQUdQIHwgRFJJVkVS
X0FUT01JQyB8Cj4+ICAgIAkgICAgRFJJVkVSX0dFTSB8Cj4+IC0JICAgIERSSVZFUl9QUklNRSB8
IERSSVZFUl9SRU5ERVIgfCBEUklWRVJfTU9ERVNFVCB8IERSSVZFUl9TWU5DT0JKLAo+PiArCSAg
ICBEUklWRVJfUFJJTUUgfCBEUklWRVJfUkVOREVSIHwgRFJJVkVSX01PREVTRVQgfCBEUklWRVJf
U1lOQ09CSiB8Cj4+ICsJICAgIERSSVZFUl9TWU5DT0JKX1RJTUVMSU5FLAo+PiAgICAJLmxvYWQg
PSBhbWRncHVfZHJpdmVyX2xvYWRfa21zLAo+PiAgICAJLm9wZW4gPSBhbWRncHVfZHJpdmVyX29w
ZW5fa21zLAo+PiAgICAJLnBvc3RjbG9zZSA9IGFtZGdwdV9kcml2ZXJfcG9zdGNsb3NlX2ttcywK
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1n
ZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
