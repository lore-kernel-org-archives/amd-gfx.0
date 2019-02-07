From: Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/5] drm/ttm: Define a single DRM_FILE_PAGE_OFFSET constant
Date: Thu, 7 Feb 2019 19:07:42 +0000
Message-ID: <67782273034c55fd14d7c5d20ba35309ade32afe.camel@vmware.com>
References: <20190207085931.29569-1-tzimmermann@suse.de>
 <20190207085931.29569-3-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190207085931.29569-3-tzimmermann-l3A5Bk7waGM@public.gmane.org>
Content-Language: en-US
Content-ID: <6EEB2504C6D02A44B866B4D8ACED3D53-HX+pjaQZbrqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zourongrong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "tzimmermann-l3A5Bk7waGM@public.gmane.org" <tzimmermann-l3A5Bk7waGM@public.gmane.org>, "alexander.deucher-5C7GfCeVMHo@public.gmane.org" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "David1.Zhou-5C7GfCeVMHo@public.gmane.org" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "ray.huang-5C7GfCeVMHo@public.gmane.org" <ray.huang-5C7GfCeVMHo@public.gmane.org>, "bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "daniel-/w4YWyX8dFk@public.gmane.org" <daniel-/w4YWyX8dFk@public.gmane.org>, "Jerry.Zhang-5C7GfCeVMHo@public.gmane.org" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, Linux-graphics-maintainer <Linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "spice-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <spice-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>

T24gVGh1LCAyMDE5LTAyLTA3IGF0IDA5OjU5ICswMTAwLCBUaG9tYXMgWmltbWVybWFubiB3cm90
ZToNCj4gTW9zdCBUVE0gZHJpdmVycyBkZWZpbmUgdGhlIGNvbnN0YW50IERSTV9GSUxFX1BBR0Vf
T0ZGU0VUIG9mIHRoZSBzYW1lDQo+IHZhbHVlLiBUaGUgb25seSBleGNlcHRpb24gaXMgdmJveHZp
ZGVvLCB3aGljaCBpcyBiZWluZyBjb252ZXJ0ZWQgdG8NCj4gdGhlDQo+IG5ldyBvZmZzZXQgYnkg
dGhpcyBwYXRjaC4gVW5pZnlpbmcgdGhlIGNvbnN0YW50cyBpbiBhIHNpbmdsZSBwbGFjZQ0KPiBz
aW1wbGlmaWVzIHRoZSBkcml2ZXIgY29kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBa
aW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyAgICAgfCAyIC0tDQo+ICBkcml2ZXJzL2dwdS9kcm0v
YXN0L2FzdF9kcnYuaCAgICAgICAgICAgICAgIHwgMiAtLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2Jv
Y2hzL2JvY2hzLmggICAgICAgICAgICAgICB8IDIgLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9jaXJy
dXMvY2lycnVzX2Rydi5oICAgICAgICAgfCAxIC0NCj4gIGRyaXZlcnMvZ3B1L2RybS9oaXNpbGlj
b24vaGlibWMvaGlibWNfdHRtLmMgfCAyIC0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWdhZzIwMC9t
Z2FnMjAwX2Rydi5oICAgICAgIHwgMSAtDQo+ICBkcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9ub3V2
ZWF1X2Rydi5oICAgICAgIHwgMiAtLQ0KPiAgZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfZHJ2Lmgg
ICAgICAgICAgICAgICB8IDMgLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90
dG0uYyAgICAgICAgIHwgMiAtLQ0KPiAgZHJpdmVycy9ncHUvZHJtL3ZpcnRpby92aXJ0Z3B1X3R0
bS5jICAgICAgICB8IDIgLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2Rydi5j
ICAgICAgICAgfCAyICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF9kcnYuaCAg
ICAgICAgIHwgMSAtDQo+ICBkcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF90dG1fZ2x1ZS5j
ICAgIHwgMiArLQ0KPiAgZHJpdmVycy9zdGFnaW5nL3Zib3h2aWRlby92Ym94X2Rydi5oICAgICAg
ICB8IDIgLS0NCj4gIGluY2x1ZGUvZHJtL3R0bS90dG1fYm9fZHJpdmVyLmggICAgICAgICAgICAg
fCAyICsrDQo+ICAxNSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9u
cygtKQ0KPiANCj4gDQoNCi4uLg0KDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS90dG0vdHRt
X2JvX2RyaXZlci5oDQo+IGIvaW5jbHVkZS9kcm0vdHRtL3R0bV9ib19kcml2ZXIuaA0KPiBpbmRl
eCBjYmYzMTgwY2I2MTIuLmMwYmVkNzI0OTJmMyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9kcm0v
dHRtL3R0bV9ib19kcml2ZXIuaA0KPiArKysgYi9pbmNsdWRlL2RybS90dG0vdHRtX2JvX2RyaXZl
ci5oDQo+IEBAIC00OSw2ICs0OSw4IEBADQo+ICAjZGVmaW5lIFRUTV9NRU1UWVBFX0ZMQUdfTUFQ
UEFCTEUgICAgICAoMSA8PCAxKQkvKiBNZW1vcnkNCj4gbWFwcGFibGUgKi8NCj4gICNkZWZpbmUg
VFRNX01FTVRZUEVfRkxBR19DTUEgICAgICAgICAgICgxIDw8IDMpCS8qIENhbid0IG1hcA0KPiBh
cGVydHVyZSAqLw0KPiAgDQo+ICsjZGVmaW5lIERSTV9GSUxFX1BBR0VfT0ZGU0VUICgweDEwMDAw
MDAwMFVMTCA+PiBQQUdFX1NISUZUKQ0KPiArDQoNCklNTyBzdHJpY3RseSwgdGhlIHBsYWNlIGlu
IHRoZSBkcm0gZmlsZSBhZGRyZXNzIHNwYWNlIHdoZXJlIGEgZHJpdmVyDQpjaG9vc2VzIHRvIGlu
c2VydCB0aGUgVFRNIGJvIGFkZHJlc3Mgc3BhY2UgaXMgdG8gYmUgZGV0ZXJtaW5lZCBieSBEUk0s
DQooYXMgYWxzbyB0aGUgZGVmaW5lIGluZGljYXRlcykgcmF0aGVyIHRoYW4gVFRNLiBTbyBJIHRo
aW5rIHRoZSByaWdodA0KcGxhY2UgZm9yIHRoaXMgZGVmaW5lIGlzIGEgZHJtIGhlYWRlciwgbm90
IGEgdHRtIGhlYWRlci4NCg0KVGhhbmtzLA0KVGhvbWFzDQoNCg0KPiAgc3RydWN0IHR0bV9tZW1f
dHlwZV9tYW5hZ2VyOw0KPiAgDQo+ICBzdHJ1Y3QgdHRtX21lbV90eXBlX21hbmFnZXJfZnVuYyB7
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
