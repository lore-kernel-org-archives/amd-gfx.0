From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: release allocated memory
Date: Sat, 21 Sep 2019 11:32:33 +0000
Message-ID: <06d1d086-0628-829b-766f-e1f614fab909@amd.com>
References: <20190920224915.2788-1-navid.emamdoost@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920224915.2788-1-navid.emamdoost@gmail.com>
Content-Language: en-US
Content-ID: <93FCB6AD83785947822B890DABAB1753@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Navid Emamdoost <navid.emamdoost@gmail.com>
Cc: "emamd001@umn.edu" <emamd001@umn.edu>, "smccaman@umn.edu" <smccaman@umn.edu>, "kjlu@umn.edu" <kjlu@umn.edu>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, Rex Zhu <Rex.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjEuMDkuMTkgdW0gMDA6NDkgc2NocmllYiBOYXZpZCBFbWFtZG9vc3Q6DQo+IEluIGFtZGdw
dV92bWlkX2dyYWJfaWRsZSwgZmVuY2VzIGlzIGJlaW5nIGxlYWtlZCBpbiBvbmUgZXhlY3V0aW9u
IHBhdGguDQo+IFRoZSBtaXNzaW5nIGtmcmVlIHdhcyBhZGRlZC4NCg0KTkFLLCB0aGUgYXJyYXkg
aXMgZnJlZWQgYnkgdGhlIGRtYV9mZW5jZV9hcnJheS7CoCBUaGlzIGlzIGEgZG91YmxlIGZyZWUu
DQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gU2lnbmVkLW9mZi1ieTogTmF2aWQgRW1h
bWRvb3N0IDxuYXZpZC5lbWFtZG9vc3RAZ21haWwuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWRzLmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9pZHMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMu
Yw0KPiBpbmRleCA1N2IzZDhhOWJlZjMuLjkwNjNjZDM2ZmE5NCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lkcy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYw0KPiBAQCAtMjQ0LDYgKzI0NCw3IEBAIHN0YXRp
YyBpbnQgYW1kZ3B1X3ZtaWRfZ3JhYl9pZGxlKHN0cnVjdCBhbWRncHVfdm0gKnZtLA0KPiAgIAkJ
ciA9IGFtZGdwdV9zeW5jX2ZlbmNlKGFkZXYsIHN5bmMsICZhcnJheS0+YmFzZSwgZmFsc2UpOw0K
PiAgIAkJZG1hX2ZlbmNlX3B1dChyaW5nLT52bWlkX3dhaXQpOw0KPiAgIAkJcmluZy0+dm1pZF93
YWl0ID0gJmFycmF5LT5iYXNlOw0KPiArCQlrZnJlZShmZW5jZXMpOw0KPiAgIAkJcmV0dXJuIHI7
DQo+ICAgCX0NCj4gICAJa2ZyZWUoZmVuY2VzKTsNCg0K
