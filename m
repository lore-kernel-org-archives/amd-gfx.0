From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/soc15: fix warnings in register macro
Date: Wed, 26 Sep 2018 18:38:17 +0200
Message-ID: <8911102c-971b-467e-7c17-28690da391b4@gmail.com>
References: <20180926162517.6467-1-alexander.deucher@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180926162517.6467-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

QW0gMjYuMDkuMjAxOCB1bSAxODoyNSBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBleHBlY3RzIGFy
Z3VtZW50IG9mIHR5cGUg4oCYdW5zaWduZWQgaW504oCZIGhhcyB0eXBlIOKAmGxvbmcgaW504oCZ
Cj4KPiBGaXhlczogNTJlMjExYzFmMDQgKCJkcm0vYW1kZ3B1OkFkZCBlcnJvciBtZXNzYWdlIHdo
ZW4gcmVnaXN0ZXIgZmFpbGVkIHRvIHJlYWNoIGV4cGVjdGVkIHZhbHVlIikKPiBTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpSZXZpZXdlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiBmb3IgdGhlIHNl
cmllcy4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNV9jb21tb24u
aCB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1X2NvbW1v
bi5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTVfY29tbW9uLmgKPiBpbmRleCBk
MzVmYWM1YjVhOGEuLjk1OGIxMGE1NzA3MyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zb2MxNV9jb21tb24uaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NvYzE1X2NvbW1vbi5oCj4gQEAgLTU3LDcgKzU3LDcgQEAKPiAgIAkJCWxvb3AtLTsJCQkJ
CVwKPiAgIAkJCWlmICghbG9vcCkgewkJCQlcCj4gICAJCQkJRFJNX0VSUk9SKCJSZWdpc3Rlcigl
ZCkgWyVzXSBmYWlsZWQgdG8gcmVhY2ggdmFsdWUgMHglMDh4ICE9IDB4JTA4eFxuIiwgXAo+IC0J
CQkJCQkJaW5zdCwgI3JlZywgZXhwZWN0ZWRfdmFsdWUsICh0bXBfICYgKG1hc2spKSk7IFwKPiAr
CQkJCQkgIGluc3QsICNyZWcsICh1bnNpZ25lZClleHBlY3RlZF92YWx1ZSwgKHVuc2lnbmVkKSh0
bXBfICYgKG1hc2spKSk7IFwKPiAgIAkJCQlyZXQgPSAtRVRJTUVET1VUOwkJXAo+ICAgCQkJCWJy
ZWFrOwkJCQlcCj4gICAJCQl9CQkJCQlcCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
