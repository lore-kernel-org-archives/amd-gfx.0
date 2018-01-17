From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: all vram is visible for APU
Date: Wed, 17 Jan 2018 10:26:35 +0100
Message-ID: <23ef5f13-075a-4d25-6e74-324ae65713b3@gmail.com>
References: <20180117085357.28373-1-david1.zhou@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180117085357.28373-1-david1.zhou-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTcuMDEuMjAxOCB1bSAwOTo1MyBzY2hyaWViIENodW5taW5nIFpob3U6Cj4gbWlzc2VkIGlu
IGdtYzkuCj4KPiBDaGFuZ2UtSWQ6IEk3MTAwNDQ1OTU0NTQzMzhlZGQ3NzAwOTIxMDBmMTNkNmY0
NmNiMGZlCj4gU2lnbmVkLW9mZi1ieTogQ2h1bm1pbmcgWmhvdSA8ZGF2aWQxLnpob3VAYW1kLmNv
bT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyB8IDYg
KysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPiBpbmRleCA3ZWM1NGMyM2MwN2QuLjk5NWRiMjMwOWYz
OCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+IEBAIC03MjgsNiAr
NzI4LDEyIEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfbWNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKPiAgIAlhZGV2LT5tYy5hcGVyX2Jhc2UgPSBwY2lfcmVzb3VyY2Vfc3RhcnQoYWRl
di0+cGRldiwgMCk7Cj4gICAJYWRldi0+bWMuYXBlcl9zaXplID0gcGNpX3Jlc291cmNlX2xlbihh
ZGV2LT5wZGV2LCAwKTsKPiAgIAo+ICsjaWZkZWYgQ09ORklHX1g4Nl82NAo+ICsJaWYgKGFkZXYt
PmZsYWdzICYgQU1EX0lTX0FQVSkgewo+ICsJCWFkZXYtPm1jLmFwZXJfYmFzZSA9IGdmeGh1Yl92
MV8wX2dldF9tY19mYl9vZmZzZXQoYWRldik7Cj4gKwkJYWRldi0+bWMuYXBlcl9zaXplID0gYWRl
di0+bWMucmVhbF92cmFtX3NpemU7Cj4gKwl9Cj4gKyNlbmRpZgo+ICAgCS8qIEluIGNhc2UgdGhl
IFBDSSBCQVIgaXMgbGFyZ2VyIHRoYW4gdGhlIGFjdHVhbCBhbW91bnQgb2YgdnJhbSAqLwo+ICAg
CWFkZXYtPm1jLnZpc2libGVfdnJhbV9zaXplID0gYWRldi0+bWMuYXBlcl9zaXplOwo+ICAgCWlm
IChhZGV2LT5tYy52aXNpYmxlX3ZyYW1fc2l6ZSA+IGFkZXYtPm1jLnJlYWxfdnJhbV9zaXplKQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
