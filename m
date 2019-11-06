From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: fix si_enable_smc_cac() failed issue
Date: Wed, 6 Nov 2019 17:06:08 +0000
Message-ID: <3ee9a780-36ec-82e6-3349-b20c15562fcb@amd.com>
References: <20191030142241.1575786-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191030142241.1575786-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <6972E96807A52543B511247EC30C0C01-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

UmV2aWV3ZWQtYnk6IFlvbmcgWmhhbzx5b25nLnpoYW9AYW1kLmNvbT4NCg0KT24gMjAxOS0xMC0z
MCAxMDoyMiBhLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6DQo+IE5lZWQgdG8gc2V0IHRoZSBkdGUg
ZmxhZyBvbiB0aGlzIGFzaWMuDQo+DQo+IFBvcnQgdGhlIGZpeCBmcm9tIGFtZGdwdToNCj4gNWNi
ODE4Yjg2MWJlMTE0MTQ4ZThkYmViNDI1OTY5ODE0ODAxOWRkMQ0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24v
c2lfZHBtLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpX2RwbS5jDQo+IGluZGV4IDQ2MGZk
OThlNDBhNy4uYTBiMzgyYTYzN2E2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3NpX2RwbS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vc2lfZHBtLmMNCj4g
QEAgLTE5NTgsNiArMTk1OCw3IEBAIHN0YXRpYyB2b2lkIHNpX2luaXRpYWxpemVfcG93ZXJ0dW5l
X2RlZmF1bHRzKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQ0KPiAgIAkJY2FzZSAweDY4MkM6
DQo+ICAgCQkJc2lfcGktPmNhY193ZWlnaHRzID0gY2FjX3dlaWdodHNfY2FwZV92ZXJkZV9wcm87
DQo+ICAgCQkJc2lfcGktPmR0ZV9kYXRhID0gZHRlX2RhdGFfc3VuX3h0Ow0KPiArCQkJdXBkYXRl
X2R0ZV9mcm9tX3BsMiA9IHRydWU7DQo+ICAgCQkJYnJlYWs7DQo+ICAgCQljYXNlIDB4NjgyNToN
Cj4gICAJCWNhc2UgMHg2ODI3Og0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4
