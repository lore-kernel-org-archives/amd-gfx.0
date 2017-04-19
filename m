From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/amdgpu: Change comp GFXv6 ring name to remove
 space
Date: Wed, 19 Apr 2017 15:30:33 +0200
Message-ID: <8d9b6d66-a20b-da4e-807c-7342e143a234@vodafone.de>
References: <20170419131056.16369-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170419131056.16369-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTkuMDQuMjAxNyB1bSAxNToxMCBzY2hyaWViIFRvbSBTdCBEZW5pczoKPiB1bXIgZXhwZWN0
cyB0aGUgcmluZyBuYW1lIHRvIGJlIGEgY29tcGxldGUgd29yZC4gIFRoaXMgYWxzbwo+IG1ha2Vz
IGl0IGNvbnNpc3RlbnQgd2l0aCBHRlh2Ny84Lgo+Cj4gU2lnbmVkLW9mZi1ieTogVG9tIFN0IERl
bmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gZm9yIGJvdGguCgo+IC0tLQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y2XzAuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92Nl8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjZfMC5jCj4gaW5kZXggNjI1ZGJmYzRmODI2Li5mNzU3OWRlZGM1NzcgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y2XzAuYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92Nl8wLmMKPiBAQCAtMzI5Miw3ICszMjkyLDcgQEAgc3Rh
dGljIGludCBnZnhfdjZfMF9zd19pbml0KHZvaWQgKmhhbmRsZSkKPiAgIAkJcmluZy0+bWUgPSAx
Owo+ICAgCQlyaW5nLT5waXBlID0gaTsKPiAgIAkJcmluZy0+cXVldWUgPSBpOwo+IC0JCXNwcmlu
dGYocmluZy0+bmFtZSwgImNvbXAgJWQuJWQuJWQiLCByaW5nLT5tZSwgcmluZy0+cGlwZSwgcmlu
Zy0+cXVldWUpOwo+ICsJCXNwcmludGYocmluZy0+bmFtZSwgImNvbXBfJWQuJWQuJWQiLCByaW5n
LT5tZSwgcmluZy0+cGlwZSwgcmluZy0+cXVldWUpOwo+ICAgCQlpcnFfdHlwZSA9IEFNREdQVV9D
UF9JUlFfQ09NUFVURV9NRUMxX1BJUEUwX0VPUCArIHJpbmctPnBpcGU7Cj4gICAJCXIgPSBhbWRn
cHVfcmluZ19pbml0KGFkZXYsIHJpbmcsIDEwMjQsCj4gICAJCQkJICAgICAmYWRldi0+Z2Z4LmVv
cF9pcnEsIGlycV90eXBlKTsKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
