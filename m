From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 2/7] drm: add syncobj timeline support v8
Date: Wed, 17 Oct 2018 09:29:01 +0000
Message-ID: <2f99da09-7bf7-d5e7-d7c1-fe2e4cf43b40@amd.com>
References: <20181015085553.30656-1-david1.zhou@amd.com>
 <20181015085553.30656-2-david1.zhou@amd.com>
 <20181017080908.GK31561@phenom.ffwll.local>
 <2066a18d-8002-014b-ef3c-a6f6014bdb55@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <2066a18d-8002-014b-ef3c-a6f6014bdb55@amd.com>
Content-Language: en-US
Content-ID: <6BE33CA8564ABD4E94476267B93F7A4E@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, Daniel Vetter <daniel@ffwll.ch>"Zhou, David(ChunMing)" <David1.Zhou@amd.com>
Cc: Dave Airlie <airlied@redhat.com>, "Rakos, Daniel" <Daniel.Rakos@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMTcuMTAuMTggdW0gMTE6MTcgc2NocmllYiB6aG91Y20xOg0KPiBbU05JUF0NCj4+PiDCoCAr
c3RydWN0IGRybV9zeW5jb2JqX3NpZ25hbF9wdCB7DQo+Pj4gK8KgwqDCoCBzdHJ1Y3QgZG1hX2Zl
bmNlX2FycmF5ICpiYXNlOw0KPj4gT3V0IG9mIGN1cmlvc2l0eSwgd2h5IHRoZSBwb2ludGVyIGFu
ZCBub3QgZW1iZWRkaW5nPyBiYXNlIGlzIGtpbmRhDQo+PiBtaXNsZWFkaW5nIGZvciBhIHBvaW50
ZXIuDQo+IFllYWgsIENocmlzdGlhbiBkb2Vzbid0IGxpa2Ugc2lnbmFsX3B0IGxpZmVjeWNsZSBz
YW1lIGFzIGZlbmNlLCBzbyANCj4gaXQncyBhIHBvaW50ZXIuDQo+IElmIHlvdSBkb24ndCBsaWtl
ICdiYXNlJyBuYW1lLCBJIGNhbiBjaGFuZ2UgaXQuDQoNCldlbGwgSSBuZXZlciBzYWlkIHRoYXQg
eW91IGNhbid0IGVtYmVkIHRoZSBmZW5jZSBhcnJheSBpbnRvIHRoZSBzaWduYWxfcHQuDQoNCllv
dSBqdXN0IG5lZWQgdG8gbWFrZSBzdXJlIHRoYXQgd2UgZG9uJ3QgYWZmZWN0IHRoZSBkcm1fc3lu
Y29iaiANCmxpbGVjeWNsZSBhcyB3ZWxsLCBlLmcuIHRoYXQgd2UgZG9uJ3QgYWxzbyBuZWVkIHRv
IGtlZXAgdGhhdCBhcm91bmQuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0
CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
