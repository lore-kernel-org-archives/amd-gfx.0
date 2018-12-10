From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix stub function name
Date: Mon, 10 Dec 2018 21:46:16 +0000
Message-ID: <0b6312a0-d876-eb4c-ac4b-9c70ad083338@amd.com>
References: <1544477327-21625-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1544477327-21625-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <1F2D16C37AC56E4A941E96844ED10BC6-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>

QWNrZWQtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPg0K
DQpBbmRyZXkNCg0KDQpPbiAxMi8xMC8yMDE4IDA0OjI5IFBNLCBLdWVobGluZywgRmVsaXggd3Jv
dGU6DQo+IFRoaXMgZnVuY3Rpb24gd2FzIHJlbmFtZWQgaW4gYSBwcmV2aW91cyBjb21taXQuIFVw
ZGF0ZSB0aGUgc3R1Yg0KPiBmdW5jdGlvbiBuYW1lIGZvciBidWlsZHMgd2l0aCBDT05GSUdfSFNB
X0FNRCBkaXNhYmxlZC4NCj4NCj4gRml4ZXM6IDYyZjY1ZDNjYjM0YSAoImRybS9hbWRncHU6IEFk
ZCBLRkQgVlJBTSBsaW1pdCBjaGVja2luZyIpDQo+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhs
aW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkLmMNCj4gaW5kZXggMzlmN2M4Yy4uMmRmYWYxNSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYw0KPiBAQCAtNTg2LDcg
KzU4Niw3IEBAIGJvb2wgYW1ka2ZkX2ZlbmNlX2NoZWNrX21tKHN0cnVjdCBkbWFfZmVuY2UgKmYs
IHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQ0KPiAgIAlyZXR1cm4gZmFsc2U7DQo+ICAgfQ0KPiAgIA0K
PiAtdm9pZCBhbWRncHVfYW1ka2ZkX3VucmVzZXJ2ZV9zeXN0ZW1fbWVtb3J5X2xpbWl0KHN0cnVj
dCBhbWRncHVfYm8gKmJvKQ0KPiArdm9pZCBhbWRncHVfYW1ka2ZkX3VucmVzZXJ2ZV9tZW1vcnlf
bGltaXQoc3RydWN0IGFtZGdwdV9ibyAqYm8pDQo+ICAgew0KPiAgIH0NCj4gICANCg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
