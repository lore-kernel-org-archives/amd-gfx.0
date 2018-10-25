From: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 0/3] A DRM API for adaptive sync and variable refresh
 rate support
Date: Thu, 25 Oct 2018 17:57:10 +0000
Message-ID: <1c3d19a7-3afa-6de5-59e0-37a19d73848b@amd.com>
References: <20180924181537.12092-1-nicholas.kazlauskas@amd.com>
 <20181001071525.GJ11082@phenom.ffwll.local>
 <CAHbf0-HhjG2xc1sAjHBR=Ep11LzumO6tdyzBcKSZ8h82H28Zbg@mail.gmail.com>
 <814b9eae-8c17-4eb7-2bb7-a6ec1f0fab41@amd.com>
 <ac5b5865-6bb0-08e8-d83c-26893e75b11e@daenzer.net>
 <84c4a243-ca2c-49a7-9e2c-22666292aea9@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <84c4a243-ca2c-49a7-9e2c-22666292aea9-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <65786A042FD7F74A9A3D3ACF34B7631A-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: "Haehnle, Nicolai" <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>, "Olsak,
 Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>

DQoNCk9uIDIwMTgtMTAtMTIgNDozMSBhLm0uLCBLb2VuaWcsIENocmlzdGlhbiB3cm90ZToNCj4g
QW0gMTIuMTAuMjAxOCB1bSAxMDoyNiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOg0KPj4gT24gMjAx
OC0xMC0xMSA5OjQ0IHAubS4sIEhhcnJ5IFdlbnRsYW5kIHdyb3RlOg0KPj4+IE9uIDIwMTgtMTAt
MDMgMDQ6MjUgQU0sIE1pa2UgTG90aGlhbiB3cm90ZToNCj4+Pj4gSSdtIGN1cmlvdXMgdG8ga25v
dyB3aGV0aGVyIHRoaXMgd2lsbC9jb3VsZCB3b3JrIG92ZXIgUFJJTUUNCj4+PiBJIGRvbid0IHNl
ZSB3aHkgdGhpcyBzaG91bGRuJ3Qgd29yayBvdmVyIFBSSU1FIGFzIGxvbmcgYXMgdGhlDQo+Pj4g
cHJlc2VudGluZyBHUFUgc3VwcG9ydHMgdGhlIG5ldyB2YXJpYWJsZSByZWZyZXNoIHJhdGUgQVBJ
LCBidXQgSSBrbm93DQo+Pj4gdmVyeSBsaXR0bGUgYWJvdXQgcHJpbWUsIHNvIG1heWJlIHNvbWVv
bmUgZWxzZSBjYW4gY2hpbWUgaW4gYW5kIGdpdmUNCj4+PiBhIGJldHRlciBvcGluaW9uLg0KPj4g
SXQgd29uJ3Qgd29yayBmb3IgZGlzcGxheXMgY29ubmVjdGVkIHRvIGEgc2Vjb25kYXJ5IEdQVSwg
YmVjYXVzZSB0aG9zZQ0KPj4gYXJlbid0IGhvb2tlZCB1cCB0byB0aGUgUHJlc2VudCBleHRlbnNp
b24gZGlyZWN0bHkuDQo+Pg0KPj4gSXQgY2FuIHRoZW9yZXRpY2FsbHkgd29yayB3aXRoIHJlbmRl
ciBvZmZsb2FkaW5nLCBpZiB0aGUgcHJpbWFyeSBHUFUgY2FuDQo+PiBzY2FuIG91dCBkaXJlY3Rs
eSBmcm9tIHRoZSBzaGFyZWQgcGl4bWFwLiBUaGlzIGlzIG9ubHkgcG9zc2libGUgd2l0aA0KPj4g
Y3VycmVudCBBTUQgQVBVcyB3aGljaCBzdXBwb3J0IHNjYXR0ZXIvZ2F0aGVyIHNjYW5vdXQgKENh
cnJpem8gYW5kDQo+PiBuZXdlcj8pLg0KPiANCj4gQWN0dWFsbHkgb25seSBDYXJpenpvIGFuZCBT
dG9uZXkgYXQgdGhlIG1vbWVudCBiZWNhdXNlIHRoaXMgaXMgYnVnZ3kgb24gDQo+IFJhdmVuLiBO
b3Qgc3VyZSBpZiB0aGF0IGlzIGEgcHVyZSBzb2Z0d2FyZSBvciBhIGhhcmR3YXJlIHByb2JsZW0u
DQo+IA0KPiBDaHJpc3RpYW4uDQo+IA0KPj4gT25lIGdvdGNoYSBpcyB0aGF0IHhmODYtdmlkZW8t
YW1kZ3B1IGN1cnJlbnRseSBkb2Vzbid0IGFsbG93DQo+PiBmbGlwcGluZyBiZXR3ZWVuIGJ1ZmZl
cnMgd2l0aCBkaWZmZXJlbnQgdGlsaW5nIHBhcmFtZXRlcnMgKEJUVyBIYXJyeSwNCj4+IGRvZXMg
dGhhdCB3b3JrIHdpdGggREM/KSwgYnV0IHRoYXQgc2hvdWxkIGJlIGVhc3kgdG8gZml4Lg0KPiAN
Cg0KTm90IGN1cnJlbnRseS4gRml4YWJsZSwgYnV0IHVuZm9ydHVuYXRlbHkgbm90IGFzIGVhc3kg
YXMgSSdkIGhvcGUuIFRoZSBnb29kIG5ld3MgaXMgdGhhdCBJJ20gcGxhbm5pbmcgdG8gcmV3b3Jr
IHRoYXQgY29kZSBzbyBpdCB3b3VsZCBiZSBlYXN5IHRvIGZpeCBvciBzaG91bGQganVzdCBoYXBw
ZW4gb24gYSBwZXItZmxpcCBiYXNpcy4NCg0KSGFycnkNCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
