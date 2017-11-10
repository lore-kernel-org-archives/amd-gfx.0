From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: if visible VRAM allocation fail, fall
 back to invisible try again
Date: Fri, 10 Nov 2017 13:23:39 +0100
Message-ID: <1e5b24b0-4373-22e8-c59e-2f765e7ec284@amd.com>
References: <1510316253-2874-1-git-send-email-Hongbo.He@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1510316253-2874-1-git-send-email-Hongbo.He-5C7GfCeVMHo@public.gmane.org>
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
To: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTAuMTEuMjAxNyB1bSAxMzoxNyBzY2hyaWViIFJvZ2VyIEhlOgo+IENoYW5nZS1JZDogSWIz
MGVmYTVmMDA3ZmNlMTJhODVhNjY3MjJhOGM5Zjc2NDk2ZjJkZWMKPiBTaWduZWQtb2ZmLWJ5OiBS
b2dlciBIZSA8SG9uZ2JvLkhlQGFtZC5jb20+CgpZZXAsIGV4YWN0bHkgd2hhdCBJIGhhZCBpbiBt
aW5kIGR1cmluZyBvdXIgZGlzY3Vzc2lvbiBhcyB3ZWxsLgoKUGF0Y2ggaXMgUmV2aWV3ZWQtYnk6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uCgpUaGFua3MgZm9y
IHRha2luZyBjYXJlIG9mIHRoaXMsCkNocmlzdGlhbi4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgfCA1ICsrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dlbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5j
Cj4gaW5kZXggZmI3MmVkYy4uYTFlYWFiYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ2VtLmMKPiBAQCAtNjMsNiArNjMsMTEgQEAgaW50IGFtZGdwdV9nZW1fb2JqZWN0
X2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgbG9uZyBzaXplLAo+
ICAgCQkJICAgICBmbGFncywgTlVMTCwgcmVzdiwgMCwgJmJvKTsKPiAgIAlpZiAocikgewo+ICAg
CQlpZiAociAhPSAtRVJFU1RBUlRTWVMpIHsKPiArCQkJaWYgKGZsYWdzICYgQU1ER1BVX0dFTV9D
UkVBVEVfQ1BVX0FDQ0VTU19SRVFVSVJFRCkgewo+ICsJCQkJZmxhZ3MgJj0gfkFNREdQVV9HRU1f
Q1JFQVRFX0NQVV9BQ0NFU1NfUkVRVUlSRUQ7Cj4gKwkJCQlnb3RvIHJldHJ5Owo+ICsJCQl9Cj4g
Kwo+ICAgCQkJaWYgKGluaXRpYWxfZG9tYWluID09IEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0pIHsK
PiAgIAkJCQlpbml0aWFsX2RvbWFpbiB8PSBBTURHUFVfR0VNX0RPTUFJTl9HVFQ7Cj4gICAJCQkJ
Z290byByZXRyeTsKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
