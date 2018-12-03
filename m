From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: NULL check before some freeing functions is
 not needed.
Date: Mon, 3 Dec 2018 11:51:58 +0000
Message-ID: <c049c318-cbaa-dcd9-1954-54aabe0c300f@amd.com>
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
 <1543760930051-1905796531-2-diffsplit-thomas@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543760930051-1905796531-2-diffsplit-thomas@m3y3r.de>
Content-Language: en-US
Content-ID: <94A892FF783DE6429DCCC018DFEED71E@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "airlied@linux.ie" <airlied@linux.ie>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMDIuMTIuMTggdW0gMjE6NTIgc2NocmllYiBUaG9tYXMgTWV5ZXI6DQo+IE5VTEwgY2hlY2sg
YmVmb3JlIHNvbWUgZnJlZWluZyBmdW5jdGlvbnMgaXMgbm90IG5lZWRlZC4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogVGhvbWFzIE1leWVyIDx0aG9tYXNAbTN5M3IuZGU+DQoNClJldmlld2VkLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQoNCj4gLS0tDQo+DQo+
IGRpZmYgLXUgLXAgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYw0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMNCj4gQEAgLTgxNiw2ICs4MTYsNSBAQCBvdXQ6DQo+
ICAgdm9pZCBhbWRncHVfYWNwaV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAg
IHsNCj4gICAJdW5yZWdpc3Rlcl9hY3BpX25vdGlmaWVyKCZhZGV2LT5hY3BpX25iKTsNCj4gLQlp
ZiAoYWRldi0+YXRpZikNCj4gLQkJa2ZyZWUoYWRldi0+YXRpZik7DQo+ICsJa2ZyZWUoYWRldi0+
YXRpZik7DQo+ICAgfQ0KDQo=
