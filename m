From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: fix possible memory leak in radeon_bo_create
Date: Tue, 21 Nov 2017 09:25:55 +0100
Message-ID: <fe410804-8635-213d-9ff7-328fdfeb9699@gmail.com>
References: <20171121043657.10247-1-alexander.deucher@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171121043657.10247-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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

QW0gMjEuMTEuMjAxNyB1bSAwNTozNiBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBpZiB0dG1fYm9f
aW5pdCBmYWlscywgZG9uJ3QgbGVhayB0aGUgYm8gb2JqZWN0LgoKTkFLLCBzZWUgdHRtX2JvX2lu
aXRfcmVzZXJ2ZWQgb25jZSBtb3JlLgoKV2hlbiB0aGUgZnVuY3Rpb24gZmFpbHMgaXQgY2FsbHMg
dGhlIGRlc3Ryb3kgY2FsbGJhY2sgd2hpY2ggcmVsZWFzZXMgdGhlIAptZW1vcnkuCgpDaHJpc3Rp
YW4uCgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fb2JqZWN0LmMg
fCAyICsrCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fb2JqZWN0LmMgYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9vYmplY3QuYwo+IGluZGV4IDA5MzU5NDk3NjEyNi4uNTNjNWJiNmMy
NWU0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX29iamVjdC5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fb2JqZWN0LmMKPiBAQCAtMjYy
LDYgKzI2Miw4IEBAIGludCByYWRlb25fYm9fY3JlYXRlKHN0cnVjdCByYWRlb25fZGV2aWNlICpy
ZGV2LAo+ICAgCQkJYWNjX3NpemUsIHNnLCByZXN2LCAmcmFkZW9uX3R0bV9ib19kZXN0cm95KTsK
PiAgIAl1cF9yZWFkKCZyZGV2LT5wbS5tY2xrX2xvY2spOwo+ICAgCWlmICh1bmxpa2VseShyICE9
IDApKSB7Cj4gKwkJZHJtX2dlbV9vYmplY3RfcmVsZWFzZSgmYm8tPmdlbV9iYXNlKTsKPiArCQlr
ZnJlZShibyk7Cj4gICAJCXJldHVybiByOwo+ICAgCX0KPiAgIAkqYm9fcHRyID0gYm87CgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
