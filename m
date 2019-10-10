From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: Potential NULL pointer deference in drm/amdgpu
Date: Thu, 10 Oct 2019 06:52:29 +0000
Message-ID: <4b4166e6-738a-5c64-4ca7-e183a6c94aac@amd.com>
References: <CABvMjLQuxeZnRMV0T5VDeEj7zV7mD4wzp5QPFCJ_oVhH0vRihQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABvMjLQuxeZnRMV0T5VDeEj7zV7mD4wzp5QPFCJ_oVhH0vRihQ@mail.gmail.com>
Content-Language: en-US
Content-ID: <783354EA019E6B4A9C3BC22797F81E4B@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yizhuo Zhai <yzhai003@ucr.edu>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, "Quan, Evan" <Evan.Quan@amd.com>, "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhiyun Qian <zhiyunq@cs.ucr.edu>, Chengyu Song <csong@cs.ucr.edu>
List-Id: amd-gfx.lists.freedesktop.org

SGkgWWl6aHVvLA0KDQpBbSAxMC4xMC4xOSB1bSAwNzowOSBzY2hyaWViIFlpemh1byBaaGFpOg0K
PiBIaSBBbGw6DQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jOg0K
PiBUaGUgZnVuY3Rpb24gdG9fYW1kZ3B1X2ZlbmNlKCkgY291bGQgcmV0dXJuIE5VTEwsIGJ1dCBj
YWxsZXJzDQo+IGluIHRoaXMgZmlsZSBkb2VzIG5vdCBjaGVjayB0aGUgcmV0dXJuIHZhbHVlIGJ1
dCBkaXJlY3RseSBkZXJlZmVyZW5jZSBpdCwNCj4gd2hpY2ggc2VlbXMgcG90ZW50aWFsbHkgdW5z
YWZlLg0KPiBTdWNoIGNhbGxlcnMgaW5jbHVkZSBhbWRncHVfZmVuY2VfZ2V0X3RpbWVsaW5lX25h
bWUoKSwNCj4gYW1kZ3B1X2ZlbmNlX2VuYWJsZV9zaWduYWxpbmcoKSBhbmQgYW1kZ3B1X2ZlbmNl
X2ZyZWUoKS4NCg0KVGhhdCBpcyBleHBlY3RlZCBiZWhhdmlvciBhbmQgbm8gbmVlZCB0byB3b3Jy
eS4NCg0KVGhlIGZ1bmN0aW9ucyBpbiBhbWRncHVfZmVuY2UuYyBhcmUgdGhlIGNhbGxiYWNrcyB0
byBpbXBsZW1lbnQgDQphbWRncHVfZmVuY2Vfb3BzLiBUaGUgZnVuY3Rpb24gdG9fYW1kZ3B1X2Zl
bmNlKCkgY2hlY2tzIGlmIHRoZSBvcHMgb2YgDQp0aGUgZmVuY2UgYXJlIGFtZGdwdV9mZW5jZV9v
cHMsIHNvIGl0IGlzIGd1YXJhbnRlZWQgdGhhdCB0aGUgZnVuY3Rpb25zIA0KYXJlIGNhbGxlZCB3
aXRoIGFuIGFtZGdwdV9mZW5jZSBzdHJ1Y3R1cmUuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQo=
