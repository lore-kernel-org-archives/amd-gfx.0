From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgu/vce_v3: start vce block before ring test
Date: Mon, 4 Feb 2019 12:49:08 +0000
Message-ID: <4bdfc32e-1236-1cb0-d141-a555034e23e6@amd.com>
References: <1549284230-32705-1-git-send-email-shirish.s@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1549284230-32705-1-git-send-email-shirish.s-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <D81DC6837245F34C9F77273967950D6B-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMDQuMDIuMTkgdW0gMTM6NDQgc2NocmllYiBTLCBTaGlyaXNoOg0KPiB2Y2UgcmluZyB0ZXN0
IGZhaWxzIGR1cmluZyByZXN1bWUgc2luY2UgbW1WQ0VfUkJfUlBUUioNCj4gaXMgbm90IGludGl0
YWxpemVkL3VwZGF0ZWQuDQo+DQo+IEhlbmNlIHN0YXJ0IHZjZSBibG9jayBiZWZvcmUgcmluZyB0
ZXN0Lg0KDQpNaG0sIEkgd29uZGVyIHdoeSB0aGlzIGV2ZXIgd29ya2VkLiBCdXQgeWVhaCwgc2Ft
ZSBwcm9ibGVtIHNlZW1zIHRvIA0KZXhpdHMgZm9yIFZDRSAyIGFzIHdlbGwuDQoNCkxlbyBhbnkg
Y29tbWVudCBvbiB0aGlzPw0KDQpUaGFua3MsDQpDaHJpc3RpYW4uDQoNCj4NCj4gU2lnbmVkLW9m
Zi1ieTogU2hpcmlzaCBTIDxzaGlyaXNoLnNAYW1kLmNvbT4NCj4gLS0tDQo+ICogdmNlX3Y0XzAu
YydzIGh3X2luaXQgc2VxdWVuY2UgYWxyZWFkeSBoYXMgdGhpcyBjaGFuZ2UuDQo+DQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAuYyB8IDQgKysrKw0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2Vf
djNfMC5jDQo+IGluZGV4IDZlYzY1Y2YxLi5kODA5YzEwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjNfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3ZjZV92M18wLmMNCj4gQEAgLTQ2OSw2ICs0NjksMTAgQEAgc3RhdGljIGludCB2
Y2VfdjNfMF9od19pbml0KHZvaWQgKmhhbmRsZSkNCj4gICAJaW50IHIsIGk7DQo+ICAgCXN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOw0K
PiAgIA0KPiArCXIgPSB2Y2VfdjNfMF9zdGFydChhZGV2KTsNCj4gKwlpZiAocikNCj4gKwkJcmV0
dXJuIHI7DQo+ICsNCj4gICAJdmNlX3YzXzBfb3ZlcnJpZGVfdmNlX2Nsb2NrX2dhdGluZyhhZGV2
LCB0cnVlKTsNCj4gICANCj4gICAJYW1kZ3B1X2FzaWNfc2V0X3ZjZV9jbG9ja3MoYWRldiwgMTAw
MDAsIDEwMDAwKTsNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
