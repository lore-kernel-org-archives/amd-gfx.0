From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/4] drm/amdgpu/gmc9: don't keep stolen memory on Raven
Date: Fri, 31 Aug 2018 10:03:43 +0800
Message-ID: <5B88A1FF.6060904@amd.com>
References: <20180830145339.5162-1-alexander.deucher@amd.com>
 <20180830145339.5162-2-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180830145339.5162-2-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

T24gMDgvMzAvMjAxOCAxMDo1MyBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IFJhdmVuIGRvZXMg
bm90IGFwcGVhciB0byBiZSBhZmZlY3RlZCBieSB0aGUgc2FtZSBpc3N1ZQo+IGFzIHZlZ2ExMC4g
IEVuYWJsZSB0aGUgZnVsbCBzdG9sZW4gbWVtb3J5IGhhbmRsaW5nIG9uCj4gUmF2ZW4uICBSZXNl
cnZlIHRoZSBhcHByb3ByaWF0ZSBzaXplIGF0IGluaXQgdGltZSB0byBhdm9pZAo+IGRpc3BsYXkg
YXJ0aWZhY3RzIGFuZCB0aGVuIGZyZWUgaXQgYXQgdGhlIGVuZCBvZiBpbml0IG9uY2UKPiB0aGUg
bmV3IEZCIGlzIHVwIGFuZCBydW5uaW5nLgo+Cj4gQnVnOiBodHRwczovL2J1Z3MuZnJlZWRlc2t0
b3Aub3JnL3Nob3dfYnVnLmNnaT9pZD0xMDY2MzkKPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+ClJldmlld2VkLWJ5OiBKdW53ZWkgWmhhbmcg
PEplcnJ5LlpoYW5nQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3Y5XzAuYyB8IDEgKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPiBpbmRleCA0NmNmZjdkOGIzNzUu
LjkzOGQwMzU5MzcxMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjlfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+
IEBAIC03MDYsNiArNzA2LDcgQEAgc3RhdGljIGJvb2wgZ21jX3Y5XzBfa2VlcF9zdG9sZW5fbWVt
b3J5KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCSAqLwo+ICAgCXN3aXRjaCAoYWRl
di0+YXNpY190eXBlKSB7Cj4gICAJY2FzZSBDSElQX1JBVkVOOgo+ICsJCXJldHVybiBmYWxzZTsK
PiAgIAljYXNlIENISVBfVkVHQTEwOgo+ICAgCWNhc2UgQ0hJUF9WRUdBMTI6Cj4gICAJY2FzZSBD
SElQX1ZFR0EyMDoKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
