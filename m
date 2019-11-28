From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: move CS secure flag next the structs where
 it's used
Date: Thu, 28 Nov 2019 13:05:58 +0100
Message-ID: <55588fa0-9e8c-8ee8-94f9-86c4ee4e8a21@gmail.com>
References: <20191127205646.953566-1-alexander.deucher@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191127205646.953566-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

QW0gMjcuMTEuMTkgdW0gMjE6NTYgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gU28gaXQncyBub3Qg
bWl4ZWQgdXAgd2l0aCB0aGUgQ1RYIHN0dWZmLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBpbmNsdWRlL3VhcGkv
ZHJtL2FtZGdwdV9kcm0uaCB8IDYgKysrLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9kcm0v
YW1kZ3B1X2RybS5oIGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKPiBpbmRleCBmNzVj
Njk1NzA2NGQuLjkxOGFjMzU0OGNkMyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkvZHJtL2Ft
ZGdwdV9kcm0uaAo+ICsrKyBiL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oCj4gQEAgLTIw
Nyw5ICsyMDcsNiBAQCB1bmlvbiBkcm1fYW1kZ3B1X2JvX2xpc3Qgewo+ICAgI2RlZmluZSBBTURH
UFVfQ1RYX09QX1FVRVJZX1NUQVRFCTMKPiAgICNkZWZpbmUgQU1ER1BVX0NUWF9PUF9RVUVSWV9T
VEFURTIJNAo+ICAgCj4gLS8qIEZsYWcgdGhlIGNvbW1hbmQgc3VibWlzc2lvbiBhcyBzZWN1cmUg
Ki8KPiAtI2RlZmluZSBBTURHUFVfQ1NfRkxBR1NfU0VDVVJFICAgICAgICAgICgxIDw8IDApCj4g
LQo+ICAgLyogR1BVIHJlc2V0IHN0YXR1cyAqLwo+ICAgI2RlZmluZSBBTURHUFVfQ1RYX05PX1JF
U0VUCQkwCj4gICAvKiB0aGlzIHRoZSBjb250ZXh0IGNhdXNlZCBpdCAqLwo+IEBAIC01NTksNiAr
NTU2LDkgQEAgc3RydWN0IGRybV9hbWRncHVfY3NfY2h1bmsgewo+ICAgCV9fdTY0CQljaHVua19k
YXRhOwo+ICAgfTsKPiAgIAo+ICsvKiBGbGFnIHRoZSBjb21tYW5kIHN1Ym1pc3Npb24gYXMgc2Vj
dXJlICovCj4gKyNkZWZpbmUgQU1ER1BVX0NTX0ZMQUdTX1NFQ1VSRSAgICAgICAgICAoMSA8PCAw
KQo+ICsKPiAgIHN0cnVjdCBkcm1fYW1kZ3B1X2NzX2luIHsKPiAgIAkvKiogUmVuZGVyaW5nIGNv
bnRleHQgaWQgKi8KPiAgIAlfX3UzMgkJY3R4X2lkOwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
