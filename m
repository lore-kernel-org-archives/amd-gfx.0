From: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 01/13] drm/amdgpu: introduce and honour DRM_FORCE_AUTH
 workaround
Date: Fri, 21 Jun 2019 08:23:54 +0000
Message-ID: <c954db03-098d-096c-6fc3-c6aae5a9b3d3@amd.com>
References: <20190527081741.14235-1-emil.l.velikov@gmail.com>
 <20190614120927.GA32412@arch-x1c3>
 <9dbdda6c-8916-e5ae-1676-86828b9890e7@amd.com>
 <20190614155325.GC32412@arch-x1c3>
 <84b3337c-0cdc-44d4-02c6-c56bd729ed47@amd.com>
 <20190620163012.GF1896@arch-x1c3>
 <9cad6e74-4751-0b0a-35d1-e8f0ac4d3efc@amd.com>
 <80d7f5d7-e1a3-f03b-6dd9-d1979da27adc@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <80d7f5d7-e1a3-f03b-6dd9-d1979da27adc@daenzer.net>
Content-Language: en-US
Content-ID: <69F644A58F7BE54DAFC056201413F393@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>, Emil Velikov <emil.l.velikov@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, David Airlie <airlied@linux.ie>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjEuMDYuMTkgdW0gMDk6NDEgc2NocmllYiBNaWNoZWwgRMOkbnplcjoNCj4gT24gMjAxOS0w
Ni0yMSA5OjEyIGEubS4sIEtvZW5pZywgQ2hyaXN0aWFuIHdyb3RlOg0KPj4gRmlyc3Qgb2YgYWxs
IEkgdHJpZWQgdG8gZGlzYWJsZSBEUk0gYXV0aGVudGljYXRpb24gY29tcGxldGVseSB3aXRoIGEN
Cj4+IGtlcm5lbCBjb25maWcgb3B0aW9uLiBTdXJwcmlzaW5nbHkgdGhhdCBhY3R1YWxseSB3b3Jr
cyBvdXQgb2YgdGhlIGJveCBhdA0KPj4gbGVhc3Qgb24gdGhlIEFNREdQVSBzdGFjay4NCj4+DQo+
PiBUaGlzIGVmZmVjdGl2ZWx5IGFsbG93cyB1cyB0byBnZXQgcmlkIG9mIERSSTIgYW5kIHRoZSBy
ZWxhdGVkIHNlY3VyaXR5DQo+PiBwcm9ibGVtcy4gT25seSB0aGluZyBsZWZ0IGZvciB0aGF0IGlz
IHRoYXQgSSdtIGp1c3Qgbm90IHN1cmUgaG93IHRvDQo+PiBzaWduYWwgdGhpcyB0byB1c2Vyc3Bh
Y2Ugc28gdGhhdCB0aGUgRERYIHdvdWxkbid0IGFkdmVydGlzZSBEUkkyIGF0IGFsbA0KPj4gYW55
IG1vcmUuDQo+IEZXSVcsIGdldHRpbmcgcmlkIG9mIERSSTIgYWxzbyBuZWVkcyB0byBiZSBkaXNj
dXNzZWQgd2l0aCBhbWRncHUtcHJvDQo+IE9wZW5HTCBkcml2ZXIgZm9sa3MuDQoNCkdvb2QgcG9p
bnQsIGJ1dCBJIGRvbid0IGV4cGVjdCBtdWNoIHByb2JsZW1zIGZyb20gdGhhdCBkaXJlY3Rpb24u
DQoNCklJUkMgdGhleSB3aGVyZSBxdWl0ZSBoYXBweSB0byBub3QgaGF2ZSB0byBzdXBwb3J0IERS
STIgZXhjZXB0IGZvciBhIA0KdmVyeSB2ZXJ5IG9sZCBYIHNlcnZlciB2ZXJzaW9uLg0KDQo+PiBB
cyBhIG5leHQgc3RlcCBJIGxvb2tlZCBpbnRvIGlmIHdlIGNhbiBkaXNhYmxlIHRoZSBjb21tYW5k
IHN1Ym1pc3Npb24NCj4+IGZvciBEUk0gbWFzdGVyLiBUdXJuZWQgb3V0IHRoYXQgdGhpcyBpcyBy
ZWxhdGl2ZWx5IGVhc3kgYXMgd2VsbC4NCj4+DQo+PiBBbGwgd2UgaGF2ZSB0byBkbyBpcyB0byBm
aXggdGhlIGJ1ZyBNaWNoZWwgcG9pbnRlZCBvdXQgYWJvdXQgS01TIGhhbmRsZXMNCj4+IGZvciBk
aXNwbGF5DQo+IEknbSB3b3JraW5nIG9uIHRoYXQsIGNvbnNpZGVyIGl0IGZpeGVkLg0KPg0KPg0K
Pj4gYW5kIGxldCB0aGUgRERYIHVzZSBhIHJlbmRlciBub2RlIGluc3RlYWQgb2YgdGhlIERSTSBt
YXN0ZXIgZm9yIEdsYW1vci4NCj4+IFN0aWxsIG5lZWQgdG8gc3luYyB1cCB3aXRoIE1pY2hlbCBh
bmQvb3IgTWFyZWsgd2hhdHMgdGhlIGJlc3Qgd2F5IG9mDQo+PiBkb2luZyB0aGlzLg0KPiBNeSBz
dWdnZXN0aW9uIHdhcyB0byBhZGQgYSBuZXcgdmFyaWFudCBvZiBhbWRncHVfZGV2aWNlX2luaXRp
YWxpemUuIFdoZW4NCj4gdGhlIG5ldyB2YXJpYW50IGlzIGNhbGxlZCwgbGliZHJtX2FtZGdwdSBp
bnRlcm5hbGx5IHVzZXMgYSByZW5kZXIgbm9kZQ0KPiBmb3IgY29tbWFuZCBzdWJtaXNzaW9uIGV0
Yy4gd2hlbmV2ZXIgcG9zc2libGUuDQoNClllYWgsIHNvdW5kcyBsaWtlIGEgcGxhbiB0byBtZS4N
Cg0KQ2hyaXN0aWFuLg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRl
dmVs
