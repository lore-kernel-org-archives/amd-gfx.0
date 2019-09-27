From: Harry Wentland <hwentlan@amd.com>
Subject: Re: [PATCH 1/6] drm/amdgpu/dm/mst: Don't create MST topology managers
 for eDP ports
Date: Fri, 27 Sep 2019 17:48:06 +0000
Message-ID: <2a1d5221-b801-44f9-c966-1163b8d67b3f@amd.com>
References: <20190926225122.31455-1-lyude@redhat.com>
 <20190926225122.31455-2-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926225122.31455-2-lyude@redhat.com>
Content-Language: en-US
Content-ID: <97FEF00A2C6A6741909CDC28AD6A4DC8@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, Thomas Lim <Thomas.Lim@amd.com>, "Francis, David" <David.Francis@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOS0wOS0yNiA2OjUxIHAubS4sIEx5dWRlIFBhdWwgd3JvdGU6DQo+IFNpZ25lZC1vZmYt
Ynk6IEx5dWRlIFBhdWwgPGx5dWRlQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBIYXJyeSBX
ZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4NCg0KSGFycnkNCg0KPiAtLS0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5j
IHwgNCArKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1f
bXN0X3R5cGVzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbV9tc3RfdHlwZXMuYw0KPiBpbmRleCA1ZWMxNGVmZDRkOGMuLjE4NWJmMGUyYmRhMiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG1fbXN0X3R5cGVzLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMNCj4gQEAgLTQxNyw2ICs0MTcsMTAgQEAgdm9pZCBh
bWRncHVfZG1faW5pdGlhbGl6ZV9kcF9jb25uZWN0b3Ioc3RydWN0IGFtZGdwdV9kaXNwbGF5X21h
bmFnZXIgKmRtLA0KPiAgCWRybV9kcF9hdXhfcmVnaXN0ZXIoJmFjb25uZWN0b3ItPmRtX2RwX2F1
eC5hdXgpOw0KPiAgCWRybV9kcF9jZWNfcmVnaXN0ZXJfY29ubmVjdG9yKCZhY29ubmVjdG9yLT5k
bV9kcF9hdXguYXV4LA0KPiAgCQkJCSAgICAgICZhY29ubmVjdG9yLT5iYXNlKTsNCj4gKw0KPiAr
CWlmIChhY29ubmVjdG9yLT5iYXNlLmNvbm5lY3Rvcl90eXBlID09IERSTV9NT0RFX0NPTk5FQ1RP
Ul9lRFApDQo+ICsJCXJldHVybjsNCj4gKw0KPiAgCWFjb25uZWN0b3ItPm1zdF9tZ3IuY2JzID0g
JmRtX21zdF9jYnM7DQo+ICAJZHJtX2RwX21zdF90b3BvbG9neV9tZ3JfaW5pdCgNCj4gIAkJJmFj
b25uZWN0b3ItPm1zdF9tZ3IsDQo+IA0K
