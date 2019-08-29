From: "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH libdrm 0/4] amdgpu: new approach for ras inject test
Date: Thu, 29 Aug 2019 09:26:23 +0000
Message-ID: <MN2PR12MB3054C28779C45164475C7F45B0A20@MN2PR12MB3054.namprd12.prod.outlook.com>
References: <20190829085917.20439-1-guchun.chen@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190829085917.20439-1-guchun.chen-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Li, Dennis" <Dennis.Li-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Li, Candice" <Candice.Li-5C7GfCeVMHo@public.gmane.org>, "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>

VGhlIHNlcmllcyBpczoNCg0KUmV2aWV3ZWQtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNv
bT4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHdWNodW4gQ2hlbiA8
Z3VjaHVuLmNoZW5AYW1kLmNvbT4NCj4gU2VudDogMjAxOeW5tDjmnIgyOeaXpSAxNjo1OQ0KPiBU
bzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5nLCBIYXdraW5nDQo+IDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+OyBMaSwgRGVubmlzIDxEZW5uaXMuTGlAYW1kLmNvbT47IEtvZW5p
ZywNCj4gQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4
YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaG91MSwgVGFvIDxUYW8uWmhv
dTFAYW1kLmNvbT4NCj4gQ2M6IExpLCBDYW5kaWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+OyBDaGVu
LCBHdWNodW4NCj4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCBsaWJk
cm0gMC80XSBhbWRncHU6IG5ldyBhcHByb2FjaCBmb3IgcmFzIGluamVjdCB0ZXN0DQo+IA0KPiBU
aGVzZSBwYXRjaGVzIGFyZSB0byByZW1vdmUgYWRkaXRpb25hbCBleHRlcm5hbCBsaWItanNvbmMg
ZGVwZW5kZW5jZSwgYW5kDQo+IHRvIHB1dCBhbGwgdGVzdCBjb25maWd1cmF0aW9ucyBpbnRvIEMg
Y29kZS4NCj4gDQo+IEd1Y2h1biBDaGVuICg0KToNCj4gICBhbWRncHU6IHJlbW92ZSBqc29uIHBh
Y2thZ2UgZGVwZW5kZW5jZQ0KPiAgIGFtZGdwdTogZGVsZXRlIHRlc3QgY29uZmlndXJhdGlvbiBm
aWxlDQo+ICAgYW1kZ3B1OiBhZGQgcmFzIGluamVjdCB1bml0IHRlc3QNCj4gICBhbWRncHU6IGFk
ZCByYXMgZmVhdHVyZSBjYXBhYmlsaXR5IGNoZWNrIGluIGluamVjdCB0ZXN0DQo+IA0KPiAgY29u
ZmlndXJlLmFjICAgICAgICAgICAgIHwgIDE4IC0tLQ0KPiAgZGF0YS9hbWRncHVfcmFzLmpzb24g
ICAgIHwgMjY3IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIG1lc29uLmJ1
aWxkICAgICAgICAgICAgICB8ICAgMSAtDQo+ICB0ZXN0cy9hbWRncHUvTWFrZWZpbGUuYW0gfCAg
IDUgKy0NCj4gIHRlc3RzL2FtZGdwdS9tZXNvbi5idWlsZCB8ICAxNiArLQ0KPiAgdGVzdHMvYW1k
Z3B1L3Jhc190ZXN0cy5jIHwgMzA1ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiAgNiBmaWxlcyBjaGFuZ2VkLCAxMTYgaW5zZXJ0aW9ucygrKSwgNDk2IGRlbGV0aW9u
cygtKSAgZGVsZXRlIG1vZGUgMTAwNjQ0DQo+IGRhdGEvYW1kZ3B1X3Jhcy5qc29uDQo+IA0KPiAt
LQ0KPiAyLjE3LjENCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
