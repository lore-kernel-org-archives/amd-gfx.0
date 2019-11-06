From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix potential double drop fence reference
Date: Wed, 6 Nov 2019 09:38:57 +0000
Message-ID: <52555cc3-b8ea-63c0-1c8c-ae8318c4f469@amd.com>
References: <1573031685-25969-1-git-send-email-bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1573031685-25969-1-git-send-email-bianpan2016@163.com>
Content-Language: en-US
Content-ID: <EA7B777B3409E543A5BA1215D9CE8C5F@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pan Bian <bianpan2016@163.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMDYuMTEuMTkgdW0gMTA6MTQgc2NocmllYiBQYW4gQmlhbjoNCj4gVGhlIG9iamVjdCBmZW5j
ZSBpcyBub3Qgc2V0IHRvIE5VTEwgYWZ0ZXIgaXRzIHJlZmVyZW5jZSBpcyBkcm9wcGVkLiBBcyBh
DQo+IHJlc3VsdCwgaXRzIHJlZmVyZW5jZSBtYXkgYmUgZHJvcHBlZCBhZ2FpbiBpZiBlcnJvciBv
Y2N1cnMgYWZ0ZXIgdGhhdCwNCj4gd2hpY2ggbWF5IGxlYWQgdG8gYSB1c2UgYWZ0ZXIgZnJlZSBi
dWcuIFRvIGF2b2lkIHRoZSBpc3N1ZSwgZmVuY2UgaXMNCj4gZXhwbGljaXRseSBzZXQgdG8gTlVM
TCBhZnRlciBkcm9wcGluZyBpdHMgcmVmZXJlbmNlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBQYW4g
QmlhbiA8YmlhbnBhbjIwMTZAMTYzLmNvbT4NCg0KQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdGVzdC5jIHwgMiArKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV90ZXN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdGVzdC5j
DQo+IGluZGV4IGI2NmQyOWQ1ZmZhMi4uYjE1ODIzMGFmOGRiIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdGVzdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90ZXN0LmMNCj4gQEAgLTEzOCw2ICsxMzgsNyBAQCBzdGF0
aWMgdm9pZCBhbWRncHVfZG9fdGVzdF9tb3ZlcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikN
Cj4gICAJCX0NCj4gICANCj4gICAJCWRtYV9mZW5jZV9wdXQoZmVuY2UpOw0KPiArCQlmZW5jZSA9
IE5VTEw7DQo+ICAgDQo+ICAgCQlyID0gYW1kZ3B1X2JvX2ttYXAodnJhbV9vYmosICZ2cmFtX21h
cCk7DQo+ICAgCQlpZiAocikgew0KPiBAQCAtMTgzLDYgKzE4NCw3IEBAIHN0YXRpYyB2b2lkIGFt
ZGdwdV9kb190ZXN0X21vdmVzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIAkJfQ0K
PiAgIA0KPiAgIAkJZG1hX2ZlbmNlX3B1dChmZW5jZSk7DQo+ICsJCWZlbmNlID0gTlVMTDsNCj4g
ICANCj4gICAJCXIgPSBhbWRncHVfYm9fa21hcChndHRfb2JqW2ldLCAmZ3R0X21hcCk7DQo+ICAg
CQlpZiAocikgew0KDQo=
