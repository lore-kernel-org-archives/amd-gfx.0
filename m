From: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
Subject: Re: [PATCH 07/10] drm/i915: Implement MST Aux device registration
Date: Tue, 23 Jul 2019 14:01:20 +0000
Message-ID: <c7c47828-cabb-f176-f480-d10335913bdd@amd.com>
References: <20190704190519.29525-1-sunpeng.li@amd.com>
 <20190704190519.29525-8-sunpeng.li@amd.com>
 <5673f815f4bc01b5d88961a1c087bed2e84ad466.camel@redhat.com>
 <20190712200559.GN5942@intel.com> <20190712201525.GO5942@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190712201525.GO5942@intel.com>
Content-Language: en-US
Content-ID: <532ECEFAF17DC0479277A30B5319C28C@namprd12.prod.outlook.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Lyude Paul <lyude@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Sean Paul <sean@poorly.run>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

DQoNCk9uIDIwMTktMDctMTIgNDoxNSBwLm0uLCBWaWxsZSBTeXJqw6Rsw6Qgd3JvdGU6DQo+IE9u
IEZyaSwgSnVsIDEyLCAyMDE5IGF0IDExOjA1OjU5UE0gKzAzMDAsIFZpbGxlIFN5cmrDpGzDpCB3
cm90ZToNCj4+IE9uIEZyaSwgSnVsIDEyLCAyMDE5IGF0IDAzOjQ4OjUzUE0gLTA0MDAsIEx5dWRl
IFBhdWwgd3JvdGU6DQo+Pj4gQlRXLCBJIGp1c3QgdHJpZWQgdGhlc2UgcGF0Y2hlcyBvbiBteSBU
NDUwcyAodXNpbmcgaTkxNSkgYW5kIEknbSBzZWVpbmcgc29tZQ0KPj4+IGtlcm5lbCB3YXJuaW5n
cyB3aXRoIHRoZW0gd2hlbiBhZGRpbmcgRFAgYXV4IGRldmljZXMgYWZ0ZXIgY29ubmVjdGluZyBh
IG5ldw0KPj4+IE1TVCB0b3BvbG9neSB0byB0aGUgc3lzdGVtOiANCj4+Pg0KPj4+IFsgIDM2Ny43
NDI1NzFdIFdBUk5JTkc6IENQVTogMiBQSUQ6IDQ0MiBhdCBkcml2ZXJzL2dwdS9kcm0vZHJtX21v
ZGVfb2JqZWN0LmM6NDUgX19kcm1fbW9kZV9vYmplY3RfYWRkKzB4YWEvMHhiMCBbZHJtXQ0KPj4N
Cj4+IExvb2tzIGxpa2UgRGFuaWVsIGFkZGVkIHRoYXQgcGFydGljdWxhciBXQVJOIGluDQo+PiBj
b21taXQgNGY1MzY4YjU1NDFhICAoImRybS9rbXM6IENhdGNoIG1vZGVfb2JqZWN0IGxpZmV0aW1l
IGVycm9ycyIpLg0KPiANCj4gQW5kIEknbSB0aGUgb25lIHdobyBhZGRlZCB0aGUgbWF4X2JwYyBw
cm9wIHRvIHRoZSBtc3QgY29ubmVjdG9ycywgd2hpY2gNCj4gaXMgYSBwZXItY29ubmVjdG9yIHBy
b3BlcnR5IChpZS4gYSBuZXcgb25lIGdldHMgY3JlYXRlZCBmb3IgZXZlcnkNCj4gY29ubmVjb3Rv
cikuIFNvIHRoYXQgY291bGQgYmUgYSBwcm9ibGVtIEkgc3VwcG9zZS4gSSBndWVzcyB3ZSBtYXkg
bmVlZA0KPiB0byBjcmVhdGUganVzdCBvbmUgb2YgdGhlc2UgZm9yIE1TVCBhbmQgcmV1c2UgaXQg
Zm9yIGV2ZXJ5IGNvbm5lY3Rvci4NCj4gQ291bGQganVzdCBwb2ludCBhdCB0aGUgcHJvcCBvZiB0
aGUgY29ycmVzcG9uZGluZyBTU1QgY29ubmVjdG9yIEkNCj4gc3VwcG9zZS4uLg0KPiANCj4gKyAg
ICAgICAvKiBSZXVzZSB0aGUgcHJvcCBiZWNhdXNlIGJsYWggKi8NCj4gKyAgICAgICBjb25uZWN0
b3ItPm1heF9icGNfcHJvcGVydHkgPQ0KPiArICAgICAgICAgICAgICAgaW50ZWxfZHAtPmF0dGFj
aGVkX2Nvbm5lY3Rvci0+YmFzZS5tYXhfYnBjX3Byb3BlcnR5Ow0KPiAgICAgICAgIGRybV9jb25u
ZWN0b3JfYXR0YWNoX21heF9icGNfcHJvcGVydHkoY29ubmVjdG9yLCA2LCAxMik7DQoNCkknZCBw
cmVmZXIgdG8gYWRkcmVzcyB0aGlzIHNlcGFyYXRlbHksIGlmIHRoYXQncyBhbHJpZ2h0Lg0KSXQg
aXNuJ3QgcmVsYXRlZCB0byB0aGlzIHNlcmllcywgYW5kIG5vIG5ldyB3YXJuaW5ncyBhcmUgaW50
cm9kdWNlZCBieQ0KdGhpcyBlaXRoZXIuDQoNCkxlbw0KDQo+IA0KPiANCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QK
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
