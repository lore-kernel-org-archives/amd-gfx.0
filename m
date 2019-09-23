From: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/display: include slab.h in dcn21_resource.c
Date: Mon, 23 Sep 2019 21:14:51 +0000
Message-ID: <9ad314e5-1a6f-f17f-ac1c-ec33aed2912e@amd.com>
References: <20190923205804.12300-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190923205804.12300-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <2370170EA4D6F7479592148C8BE85EFF-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0wOS0yMyA0OjU4IHAubS4sIEFsZXggRGV1Y2hlciB3cm90ZToNCj4gSXQncyBhcHBh
cmVudGx5IG5lZWRlZCBpbiBzb21lIGNvbmZpZ3VyYXRpb25zLg0KDQpDdXJpb3VzIHdoaWNoIGNv
bmZpZyBmYWlscyBhbmQgd2hhdCBjb21waWxlciBlcnJvcnMgd2UgZ2V0Li4uIFNvdW5kcw0KbGlr
ZSBvdXIgaW5jbHVkZXMgYXJlIG1lc3NlZCB1cCBzb21ld2hlcmUuDQoNCkhhcnJ5DQoNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVz
b3VyY2UuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFf
cmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9y
ZXNvdXJjZS5jDQo+IGluZGV4IDNjYTUxMzlmMTI3My4uZGUxODIxODVmZTFmIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2Uu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVz
b3VyY2UuYw0KPiBAQCAtMjMsNiArMjMsOCBAQA0KPiAgICoNCj4gICAqLw0KPiAgDQo+ICsjaW5j
bHVkZSA8bGludXgvc2xhYi5oPg0KPiArDQo+ICAjaW5jbHVkZSAiZG1fc2VydmljZXMuaCINCj4g
ICNpbmNsdWRlICJkYy5oIg0KPiAgDQo+IA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
