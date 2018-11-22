From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: disable page queue support for Vega12
Date: Thu, 22 Nov 2018 10:16:11 +0100
Message-ID: <63131f03-73e5-aa0d-226d-3607beefc87c@gmail.com>
References: <20181121145440.4626-1-alexander.deucher@amd.com>
 <1e279bbd-dd7d-2c1e-ae71-5f5ac89a255c@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1e279bbd-dd7d-2c1e-ae71-5f5ac89a255c-5C7GfCeVMHo@public.gmane.org>
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
To: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
CkFtIDIxLjExLjE4IHVtIDE2OjA0IHNjaHJpZWIgWWFuZywgUGhpbGlwOgo+IFJldmlld2VkLWJ5
OiBQaGlsaXAgWWFuZyA8cGhpbGlwLnlhbmdAYW1kLmNvbT4KPgo+Cj4gT24gMjAxOC0xMS0yMSA5
OjU0IGEubS4sIEFsZXggRGV1Y2hlciB3cm90ZToKPj4gS2VlcCBpdCBkaXNhYmxlZCB1bnRpbCB3
ZSBjb25maXJtIGl0J3MgcmVhZHkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPj4gLS0tCj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NkbWFfdjRfMC5jIHwgNSArKystLQo+PiAgICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zZG1hX3Y0XzAuYwo+PiBpbmRleCBlNmNiMmMzOTk5NTcuLmE5NzNkZWE3YjI0MiAxMDA2NDQK
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKPj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKPj4gQEAgLTE0NTUsOSArMTQ1
NSwxMCBAQCBzdGF0aWMgYm9vbCBzZG1hX3Y0XzBfZndfc3VwcG9ydF9wYWdpbmdfcXVldWUoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+ICAgIAljYXNlIENISVBfVkVHQTEwOgo+PiAgICAJ
CXJldHVybiBmd192ZXJzaW9uID49IDQzMDsKPj4gICAgCWNhc2UgQ0hJUF9WRUdBMTI6Cj4+IC0J
CXJldHVybiBmd192ZXJzaW9uID49IDMxOwo+PiArCQkvKnJldHVybiBmd192ZXJzaW9uID49IDMx
OyovCj4+ICsJCXJldHVybiBmYWxzZTsKPj4gICAgCWNhc2UgQ0hJUF9WRUdBMjA6Cj4+IC0JCS8v
cmV0dXJuIGZ3X3ZlcnNpb24gPj0gMTE1Owo+PiArCQkvKnJldHVybiBmd192ZXJzaW9uID49IDEx
NTsqLwo+PiAgICAJCXJldHVybiBmYWxzZTsKPj4gICAgCWRlZmF1bHQ6Cj4+ICAgIAkJcmV0dXJu
IGZhbHNlOwo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
