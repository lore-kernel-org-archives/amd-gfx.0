From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use new HMM APIs and helpers
Date: Fri, 31 May 2019 19:42:49 +0000
Message-ID: <befbe7fa-0bd3-ffcf-d2eb-36f15053d1a5@amd.com>
References: <20190530144049.1996-1-Philip.Yang@amd.com>
 <704410a5-be01-f423-11ef-01a640cd469c@amd.com>
 <bd8f1fd6-f6c4-66fc-c0b9-c8ed36cd6027@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <bd8f1fd6-f6c4-66fc-c0b9-c8ed36cd6027-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <E14BEEB7AAC34442A8A44CA799B1172C-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wNS0zMSAxOjI4IHAubS4sIFlhbmcsIFBoaWxpcCB3cm90ZToNCj4NCj4gT24gMjAx
OS0wNS0zMCA2OjM2IHAubS4sIEt1ZWhsaW5nLCBGZWxpeCB3cm90ZToNCj4+PiAgICAgDQo+Pj4g
ICAgICNpZiBJU19FTkFCTEVEKENPTkZJR19EUk1fQU1ER1BVX1VTRVJQVFIpDQo+Pj4gLQlpZiAo
Z3R0LT5yYW5nZXMgJiYNCj4+PiAtCSAgICB0dG0tPnBhZ2VzWzBdID09IGhtbV9wZm5fdG9fcGFn
ZSgmZ3R0LT5yYW5nZXNbMF0sDQo+Pj4gLQkJCQkJICAgICBndHQtPnJhbmdlc1swXS5wZm5zWzBd
KSkNCj4+PiArCWlmIChndHQtPnJhbmdlICYmDQo+Pj4gKwkgICAgdHRtLT5wYWdlc1swXSA9PSBo
bW1fZGV2aWNlX2VudHJ5X3RvX3BhZ2UoZ3R0LT5yYW5nZSwNCj4+PiArCQkJCQkJICAgICAgZ3R0
LT5yYW5nZS0+cGZuc1swXSkpDQo+PiBJIHRoaW5rIGp1c3QgY2hlY2tpbmcgZ3R0LT5yYW5nZSBo
ZXJlIGlzIGVub3VnaC4gSWYgZ3R0LT5yYW5nZSBpcyBub3QNCj4+IE5VTEwgaGVyZSwgd2UncmUg
bGVha2luZyBtZW1vcnkuDQo+Pg0KPiBJZiBqdXN0IGNoZWNraW5nIGd0dC0+cmFuZ2UsIHRoZXJl
IGlzIGEgZmFsc2Ugd2FybmluZyBpbiBhbWRncHVfdGVzdA0KPiB1c2VycHRyIGNhc2UgaW4gYW1k
Z3B1X2NzX2xpc3RfdmFsaWRhdGUgcGF0aC4gSWYgdXNlcnB0ciBpcyBpbnZhbGlkYXRlZCwNCj4g
dGhlbiB0dG0tPnBhZ2VzWzBdIGlzIG91dGRhdGVkIHBhZ2VzLCBsb2JqLT51c2VyX3BhZ2VzIGlz
IG5ldyBwYWdlcywgaXQNCj4gZ29lcyB0byB0dG1fdHRfdW5iaW5kIGZpcnN0IHRvIHVucGluIG9s
ZCBwYWdlcyAodGhpcyBjYXVzZXMgZmFsc2UNCj4gd2FybmluZykgdGhlbiBjYWxsIGFtZGdwdV90
dG1fdHRfc2V0X3VzZXJfcGFnZXMuDQoNCkJ1dCBkb2Vzbid0IHRoYXQgbWVhbiB3ZSdyZSBsZWFr
aW5nIHRoZSBndHQtPnJhbmdlIHNvbWV3aGVyZT8NCg0KUmVnYXJkcywNCiDCoCBGZWxpeA0KDQoN
Cj4NCj4gSSB3aWxsIHN1Ym1pdCBwYXRjaCB2MiwgdG8gYWRkIHJldHJ5IGlmIGhtbV9yYW5nZV9m
YXVsdCByZXR1cm5zIC1FQUdBSU4uDQo+IHVzZSBremFsbG9jIHRvIGFsbG9jYXRlIHNtYWxsIHNp
emUgcmFuZ2UuDQo+DQo+IFRoYW5rcywNCj4gUGhpbGlwDQo+DQo+PiBSZWdhcmRzLA0KPj4gICAg
wqAgRmVsaXgNCj4+DQo+Pg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
