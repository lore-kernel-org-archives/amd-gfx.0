From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add one rlc version into gfxoff blacklist
Date: Wed, 20 Mar 2019 11:25:34 +0000
Message-ID: <56882a95-0512-eb07-9ca8-dbfad7a1bf8c@amd.com>
References: <1553002293-8565-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1553002293-8565-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <FB0073B0FE81294892370ACF2E0123B7-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

RldJVyB3aGVuIEkgbWFudWFsbHkgYXBwbHkgdGhpcyB0byBteSBkcm0tbmV4dCBrZXJuZWwgb24g
bXkgcmF2ZW4xIGRldmVsIA0KYm94IGl0IHdvcmtzIGZpbmUuDQoNCg0KVGVzdGVkLWJ5OiBUb20g
U3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+DQoNClRvbQ0KDQpPbiAyMDE5LTAzLTE5IDk6
MzEgYS5tLiwgSHVhbmcgUnVpIHdyb3RlOg0KPiBSTEMgIzUzODE1IHVjb2RlIGhhcyB0aGUgbm9p
c2UgaXNzdWUgb24gNGsgcGxheWJhY2sgd2hpbGUgZ2Z4b2ZmIGVuYWJsZWQuDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5j
DQo+IGluZGV4IDZiNDhkNGMuLjM3NjVkOTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y5XzAuYw0KPiBAQCAtNTg5LDYgKzU4OSw3IEBAIHN0YXRpYyB2b2lkIGdmeF92OV8w
X2NoZWNrX2lmX25lZWRfZ2Z4b2ZmKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIAkJ
aWYgKGFkZXYtPnJldl9pZCA+PSAweDggfHwgYWRldi0+cGRldi0+ZGV2aWNlID09IDB4MTVkOCkN
Cj4gICAJCQlicmVhazsNCj4gICAJCWlmICgoYWRldi0+Z2Z4LnJsY19md192ZXJzaW9uIDwgNTMx
KSB8fA0KPiArCQkgICAgKGFkZXYtPmdmeC5ybGNfZndfdmVyc2lvbiA9PSA1MzgxNSkgfHwNCj4g
ICAJCSAgICAoYWRldi0+Z2Z4LnJsY19mZWF0dXJlX3ZlcnNpb24gPCAxKSB8fA0KPiAgIAkJICAg
ICFhZGV2LT5nZngucmxjLmlzX3JsY192Ml8xKQ0KPiAgIAkJCWFkZXYtPnBtLnBwX2ZlYXR1cmUg
Jj0gflBQX0dGWE9GRl9NQVNLOw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
