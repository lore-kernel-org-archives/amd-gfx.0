From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix scheduler timeout calc
Date: Mon, 24 Jun 2019 11:36:20 +0200
Message-ID: <44e2f73b-2102-8361-034d-6176eb952ce3@gmail.com>
References: <1561366217-13261-1-git-send-email-flora.cui@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1561366217-13261-1-git-send-email-flora.cui-5C7GfCeVMHo@public.gmane.org>
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
To: "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMjQuMDYuMTkgdW0gMTA6NTAgc2NocmllYiBDdWksIEZsb3JhOgo+IHNjaGVkdWxlciB0aW1l
b3V0IGlzIGluIGppZmZpZXMKPgo+IENoYW5nZS1JZDogSTI2NzA4YzE2M2RiOTQzZmY4ZDkzMGRk
ODFiY2FiNGI0YjlkODRlYjIKPiBTaWduZWQtb2ZmLWJ5OiBGbG9yYSBDdWkgPGZsb3JhLmN1aUBh
bWQuY29tPgoKSSBhY3R1YWxseSBzdWdnZXN0ZWQgdG8gZG8gdGhpcyBjb25zaXN0ZW50bHkgaW4g
CmFtZGdwdV9kZXZpY2VfZ2V0X2pvYl90aW1lb3V0X3NldHRpbmdzIGFmdGVyIHBhcnNpbmcgdGhl
IHZhbHVlLgoKQlRXOiBUaGUgdGVzdCBmb3IgbmVnYXRpdmUgdmFsdWVzIHRoZXJlIGlzIHN0aWxs
IG5vdCBjb3JyZWN0IGVpdGhlci4KCkNhbiB5b3UgZml4IHVwIGJvdGg/IENhdXNlIG90aGVyd2lz
ZSB3ZSBhcmUgbm90IGFibGUgdG8gY29tcGxldGVseSAKZGlzYWJsZSB0aGUgdGltZW91dCBmb3Ig
dGVzdGluZy4KCkNocmlzdGlhbi4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZmVuY2UuYyB8IDMgKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Zl
bmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYwo+IGluZGV4
IGNiY2FhN2MuLjJlZGFhNmMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2ZlbmNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZmVuY2UuYwo+IEBAIC00ODEsNiArNDgxLDkgQEAgaW50IGFtZGdwdV9mZW5jZV9kcml2ZXJf
aW5pdF9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKPiAgIAkJCWJyZWFrOwo+ICAgCQl9
Cj4gICAKPiArCQlpZiAodGltZW91dCAhPSBNQVhfU0NIRURVTEVfVElNRU9VVCkKPiArCQkJdGlt
ZW91dCA9IG1zZWNzX3RvX2ppZmZpZXModGltZW91dCk7Cj4gKwo+ICAgCQlyID0gZHJtX3NjaGVk
X2luaXQoJnJpbmctPnNjaGVkLCAmYW1kZ3B1X3NjaGVkX29wcywoKQo+ICAgCQkJCSAgIG51bV9o
d19zdWJtaXNzaW9uLCBhbWRncHVfam9iX2hhbmdfbGltaXQsCj4gICAJCQkJICAgdGltZW91dCwg
cmluZy0+bmFtZSk7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
