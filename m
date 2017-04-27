From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH v2] drm/radeon: only warn once in radeon_ttm_bo_destroy if
 va list not empty
Date: Thu, 27 Apr 2017 16:57:42 +0200
Message-ID: <2224170e-536a-8619-9f72-ea46ea341709@vodafone.de>
References: <1493302208-8637-1-git-send-email-jisorce@oblong.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1493302208-8637-1-git-send-email-jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>
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
To: Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: michel.daenzer-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

QW0gMjcuMDQuMjAxNyB1bSAxNjoxMCBzY2hyaWViIEp1bGllbiBJc29yY2U6Cj4gRW5jb3VudGVy
ZWQgYSBkb3plbiBvZiBleGFjdCBzYW1lIGJhY2t0cmFjZXMgd2hlbiBtZXNhJ3MKPiBwYl9jYWNo
ZV9yZWxlYXNlX2FsbF9idWZmZXJzIGlzIGNhbGxlZCBhZnRlciB0aGF0IGEgZ3B1IHJlc2V0IGZh
aWxlZC4KPgo+IHYyOiBSZW1vdmUgc3VwZXJmbHVvdXMgZXJyb3IgbWVzc2FnZSBhZGRlZCBpbiB2
MS4KPgo+IGJ1ZzogaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9
OTYyNzEKPgo+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBJc29yY2UgPGppc29yY2VAb2Jsb25nLmNv
bT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fb2JqZWN0LmMgfCAy
ICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9vYmplY3QuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX29iamVjdC5jCj4gaW5kZXggYmVjMmVjMC4uOGI3
MjIyOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9vYmplY3Qu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX29iamVjdC5jCj4gQEAgLTgx
LDcgKzgxLDcgQEAgc3RhdGljIHZvaWQgcmFkZW9uX3R0bV9ib19kZXN0cm95KHN0cnVjdCB0dG1f
YnVmZmVyX29iamVjdCAqdGJvKQo+ICAgCWxpc3RfZGVsX2luaXQoJmJvLT5saXN0KTsKPiAgIAlt
dXRleF91bmxvY2soJmJvLT5yZGV2LT5nZW0ubXV0ZXgpOwo+ICAgCXJhZGVvbl9ib19jbGVhcl9z
dXJmYWNlX3JlZyhibyk7Cj4gLQlXQVJOX09OKCFsaXN0X2VtcHR5KCZiby0+dmEpKTsKPiArCVdB
Uk5fT05fT05DRSghbGlzdF9lbXB0eSgmYm8tPnZhKSk7Cj4gICAJZHJtX2dlbV9vYmplY3RfcmVs
ZWFzZSgmYm8tPmdlbV9iYXNlKTsKPiAgIAlrZnJlZShibyk7Cj4gICB9CgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
