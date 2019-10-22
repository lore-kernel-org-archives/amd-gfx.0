From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix memory leak in amdgpu_fence_emit
Date: Tue, 22 Oct 2019 06:54:13 +0000
Message-ID: <fad3d810-d3bd-ccdf-1d21-f5a483597043@amd.com>
References: <20191021180944.22183-1-navid.emamdoost@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021180944.22183-1-navid.emamdoost@gmail.com>
Content-Language: en-US
Content-ID: <F7F816AE92352B4E8833E3EBD9AB3B3B@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Navid Emamdoost <navid.emamdoost@gmail.com>
Cc: "emamd001@umn.edu" <emamd001@umn.edu>, "kjlu@umn.edu" <kjlu@umn.edu>, "smccaman@umn.edu" <smccaman@umn.edu>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Quan, Evan" <Evan.Quan@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, Sam Ravnborg <sam@ravnborg.org>, "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjEuMTAuMTkgdW0gMjA6MDkgc2NocmllYiBOYXZpZCBFbWFtZG9vc3Q6DQo+IEluIHRoZSBp
bXBlbGVtZW50YXRpb24gb2YgYW1kZ3B1X2ZlbmNlX2VtaXQoKSBpZiBkbWFfZmVuY2Vfd2FpdCgp
IGZhaWxzDQo+IGFuZCByZXR1cm5zIGFuIGVycm5vLCBiZWZvcmUgcmV0dXJuaW5nIHRoZSBhbGxv
Y2F0ZWQgbWVtb3J5IGZvciBmZW5jZQ0KPiBzaG91bGQgYmUgcmVsZWFzZWQuDQo+DQo+IEZpeGVz
OiAzZDJhY2E4Yzg2MjAgKCJkcm0vYW1kZ3B1OiBmaXggb2xkIGZlbmNlIGNoZWNrIGluIGFtZGdw
dV9mZW5jZV9lbWl0IikNCj4gU2lnbmVkLW9mZi1ieTogTmF2aWQgRW1hbWRvb3N0IDxuYXZpZC5l
bWFtZG9vc3RAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9mZW5jZS5jIHwgNCArKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZmVuY2UuYw0KPiBpbmRleCAyMzA4NWIzNTJjZjIuLjJmNTljOTI3MGE3ZSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMNCj4gQEAgLTE2
Niw4ICsxNjYsMTAgQEAgaW50IGFtZGdwdV9mZW5jZV9lbWl0KHN0cnVjdCBhbWRncHVfcmluZyAq
cmluZywgc3RydWN0IGRtYV9mZW5jZSAqKmYsDQo+ICAgCQlpZiAob2xkKSB7DQo+ICAgCQkJciA9
IGRtYV9mZW5jZV93YWl0KG9sZCwgZmFsc2UpOw0KPiAgIAkJCWRtYV9mZW5jZV9wdXQob2xkKTsN
Cj4gLQkJCWlmIChyKQ0KPiArCQkJaWYgKHIpIHsNCj4gKwkJCQlkbWFfZmVuY2VfcHV0KGZlbmNl
KTsNCj4gICAJCQkJcmV0dXJuIHI7DQo+ICsJCQl9DQo+ICAgCQl9DQo+ICAgCX0NCj4gICANCg0K
