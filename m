From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 01/13] drm/amdgpu: introduce and honour DRM_FORCE_AUTH
 workaround
Date: Tue, 4 Jun 2019 15:28:14 +0200
Message-ID: <CAKMK7uGoSbtXVNthr6oUomc7EcYUheNDWHsZ4=F0QwsSN3y=CQ@mail.gmail.com>
References: <20190527081741.14235-1-emil.l.velikov@gmail.com>
 <3c9b5688-5e83-f173-00e3-6e139e05d466@amd.com>
 <20190527132041.GP21222@phenom.ffwll.local>
 <20190527132607.GH15067@arch-x1c3>
 <0426fb3e-e7bc-2464-cb42-4d5753956d23@amd.com>
 <CAKMK7uE_pRro8PxTwUq+pC_1GVVT7nUxan1T-kqSYT=BMHTf2g@mail.gmail.com>
 <d12a7dd4-595b-d0aa-a87d-527392fb0384@amd.com>
 <CAKMK7uE1ZWjCeg3q7qDrbcj89+DuPQwfjMqC8hTjDAMU5bhh-w@mail.gmail.com>
 <98c3d891-6966-2043-9709-4e718dbc6bac@amd.com>
 <ee1b8980-3d78-aa6d-fe46-2c0d45c2bbdd@daenzer.net>
 <1b697f02-a6cf-0bc1-9149-3acd71eb4e30@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1b697f02-a6cf-0bc1-9149-3acd71eb4e30@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, Emil Velikov <emil.l.velikov@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBKdW4gNCwgMjAxOSBhdCAxOjI0IFBNIEtvZW5pZywgQ2hyaXN0aWFuCjxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+IHdyb3RlOgo+Cj4gQW0gMDQuMDYuMTkgdW0gMTI6NTAgc2Nocmll
YiBNaWNoZWwgRMOkbnplcjoKPiA+IE9uIDIwMTktMDUtMjggMTA6MDMgYS5tLiwgS29lbmlnLCBD
aHJpc3RpYW4gd3JvdGU6Cj4gPj4gSSByYXRoZXIgdGhpbmsgdGhhdCB3ZSBzaG91bGQgZ28gZG93
biB0aGUgcm91dGUgb2YgY29tcGxldGVseSBkcm9wcGluZwo+ID4+IGNvbW1hbmQgc3VibWlzc2lv
biBhbmQgYnVmZmVyIGFsbG9jYXRpb24gdGhyb3VnaCB0aGUgcHJpbWFyeSBub2RlIGZvcgo+ID4+
IG5vbiBtYXN0ZXIgY2xpZW50cy4gQW5kIHRoZW4gYXMgbmV4dCBzdGVwIGF0IHNvbWUgcG9pbnQg
ZHJvcCBzdXBwb3J0IGZvcgo+ID4+IGF1dGhlbnRpY2F0aW9uL2ZsaW5rLgo+ID4gS2VlcCBpbiBt
aW5kIHRoYXQgZXZlbiBkaXNwbGF5IHNlcnZlcnMgYXJlbid0IERSTSBtYXN0ZXIgd2hpbGUgdGhl
aXIgVlQKPiA+IGlzbid0IGFjdGl2ZSwgc28gdGhpcyBtaWdodCBiZSBwcm9ibGVtYXRpYyBpZiBh
IGRpc3BsYXkgc2VydmVyIG5lZWRzIHRvCj4gPiBkbyBzb21lIGNvbW1hbmQgc3VibWlzc2lvbiAv
IGJ1ZmZlciBhbGxvY2F0aW9uIGR1cmluZyB0aGF0IHRpbWUuCj4KPiBJZiBJIHVuZGVyc3RhbmQg
aXQgY29ycmVjdGx5IHRoZSBEUk0gZmQgc3RheXMgbWFzdGVyIGV2ZW4gd2hlbiB0aGUgVlQgaXMK
PiBzd2l0Y2hlZCBhd2F5LCBpdCdzIGp1c3Qgbm90IHRoZSBjdXJyZW50IG1hc3RlciBhbnkgbW9y
ZS4KPgo+IFNvIGluIHRoaXMgY2FzZSBmcHJpdi0+aXNfbWFzdGVyIHN0YXlzIHRydWUsIGJ1dAo+
IGRybV9pc19jdXJyZW50X21hc3RlcihmcHJpdikgcmV0dXJucyBmYWxzZS4KPgo+IEFuZCB5ZXMg
d2UgbWl4ZWQgdGhhdCB1cCBpbiBhbWRncHUsIGk5MTUgYW5kIHZtd2dmeC4gU29tZWJvZHkgc2hv
dWxkCj4gcHJvYmFibHkgd3JpdGUgcGF0Y2hlcyB0byBmaXggdGhpcy4KCm1hc3RlciBzaG91bGQg
YWx3YXlzIGJlIGF1dGhlbnRpY2F0ZWQsIHNvIHNob3VsZCBiZSBhYmxlIHRvIGNvbnRpbnVlCnJl
bmRlcmluZy4gV2VsbCAuLi4gZXhjZXB0IG9uIGRyaXZlcnMgd2hvIGRvIHRha2UgaXNvbGF0aW9u
IHNvbWV3aGF0CnNlcmlvdXMsIGJ1dCBkb24ndCBoYXZlIGZ1bGwgcGVyLWNsaWVudCBpc29sYXRp
b24uIFRob3NlIGFjdHVhbGx5CnJlZnVzZSByZW5kZXJpbmcvZ3B1IGFjY2VzcyBmb3IgYW55IGF1
dGhlbnRpY2F0ZWQgY2xpZW50IGlmIHRoZWlyCmNvcnJlc3BvbmRpbmcgbWFzdGVyIGlzbid0IHRo
ZSBjdXJyZW50IG1hc3Rlci4gQnV0IEkgdGhpbmsgb25seSB2bXdnZngKZG9lcyB0aGF0LgoKUGVy
LWNsaWVudCBpc29sYXRpb24gaGFzIHRha2VuIG92ZXIgYW55d2F5LCBzbyBhbGwgYSBiaXQgbW9v
dCwgYXQKbGVhc3Qgb24gbW9kZXJuIGh3LgotRGFuaWVsCi0tIApEYW5pZWwgVmV0dGVyClNvZnR3
YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgorNDEgKDApIDc5IDM2NSA1NyA0OCAtIGh0
dHA6Ly9ibG9nLmZmd2xsLmNoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ry
aS1kZXZlbA==
