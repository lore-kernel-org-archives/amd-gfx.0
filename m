From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gfx: use proper offset define for MEC doorbells
Date: Fri, 16 Nov 2018 20:32:38 +0000
Message-ID: <a178bd72-4f4b-1b61-d1c1-b5140ebfb1d5@amd.com>
References: <20181116203037.17893-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181116203037.17893-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <E0744977342A9149AA6EB3F6E01BA947-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOC0xMS0xNiAzOjMwIHAubS4sIEFsZXggRGV1Y2hlciB3cm90ZToNCj4gTG9va3MgbGlr
ZSBhIGNvcHkgcGFzdGUgdHlwby4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KDQpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQoNCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OV8wLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlf
MC5jDQo+IGluZGV4IGMyN2NhYTE0NGM1Ny4uZTQwOWZiZjY3ZmU3IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMNCj4gQEAgLTE1NjYsNyArMTU2Niw3IEBAIHN0YXRp
YyBpbnQgZ2Z4X3Y5XzBfY29tcHV0ZV9yaW5nX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsIGludCByaW5nX2lkLA0KPiAgDQo+ICAJcmluZy0+cmluZ19vYmogPSBOVUxMOw0KPiAgCXJp
bmctPnVzZV9kb29yYmVsbCA9IHRydWU7DQo+IC0JcmluZy0+ZG9vcmJlbGxfaW5kZXggPSAoQU1E
R1BVX0RPT1JCRUxMX01FQ19SSU5HMCArIHJpbmdfaWQpIDw8IDE7DQo+ICsJcmluZy0+ZG9vcmJl
bGxfaW5kZXggPSAoQU1ER1BVX0RPT1JCRUxMNjRfTUVDX1JJTkcwICsgcmluZ19pZCkgPDwgMTsN
Cj4gIAlyaW5nLT5lb3BfZ3B1X2FkZHIgPSBhZGV2LT5nZngubWVjLmhwZF9lb3BfZ3B1X2FkZHIN
Cj4gIAkJCQkrIChyaW5nX2lkICogR0ZYOV9NRUNfSFBEX1NJWkUpOw0KPiAgCXNwcmludGYocmlu
Zy0+bmFtZSwgImNvbXBfJWQuJWQuJWQiLCByaW5nLT5tZSwgcmluZy0+cGlwZSwgcmluZy0+cXVl
dWUpOw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
