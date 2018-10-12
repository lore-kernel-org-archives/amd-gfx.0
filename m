From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2 0/3] A DRM API for adaptive sync and variable refresh
 rate support
Date: Fri, 12 Oct 2018 08:31:05 +0000
Message-ID: <84c4a243-ca2c-49a7-9e2c-22666292aea9@amd.com>
References: <20180924181537.12092-1-nicholas.kazlauskas@amd.com>
 <20181001071525.GJ11082@phenom.ffwll.local>
 <CAHbf0-HhjG2xc1sAjHBR=Ep11LzumO6tdyzBcKSZ8h82H28Zbg@mail.gmail.com>
 <814b9eae-8c17-4eb7-2bb7-a6ec1f0fab41@amd.com>
 <ac5b5865-6bb0-08e8-d83c-26893e75b11e@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ac5b5865-6bb0-08e8-d83c-26893e75b11e-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-US
Content-ID: <BCC5CF701AF92D45BAEBB66535A6922C-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: "Haehnle, Nicolai" <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>, "Olsak,
 Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>

QW0gMTIuMTAuMjAxOCB1bSAxMDoyNiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOg0KPiBPbiAyMDE4
LTEwLTExIDk6NDQgcC5tLiwgSGFycnkgV2VudGxhbmQgd3JvdGU6DQo+PiBPbiAyMDE4LTEwLTAz
IDA0OjI1IEFNLCBNaWtlIExvdGhpYW4gd3JvdGU6DQo+Pj4gSSdtIGN1cmlvdXMgdG8ga25vdyB3
aGV0aGVyIHRoaXMgd2lsbC9jb3VsZCB3b3JrIG92ZXIgUFJJTUUNCj4+IEkgZG9uJ3Qgc2VlIHdo
eSB0aGlzIHNob3VsZG4ndCB3b3JrIG92ZXIgUFJJTUUgYXMgbG9uZyBhcyB0aGUNCj4+IHByZXNl
bnRpbmcgR1BVIHN1cHBvcnRzIHRoZSBuZXcgdmFyaWFibGUgcmVmcmVzaCByYXRlIEFQSSwgYnV0
IEkga25vdw0KPj4gdmVyeSBsaXR0bGUgYWJvdXQgcHJpbWUsIHNvIG1heWJlIHNvbWVvbmUgZWxz
ZSBjYW4gY2hpbWUgaW4gYW5kIGdpdmUNCj4+IGEgYmV0dGVyIG9waW5pb24uDQo+IEl0IHdvbid0
IHdvcmsgZm9yIGRpc3BsYXlzIGNvbm5lY3RlZCB0byBhIHNlY29uZGFyeSBHUFUsIGJlY2F1c2Ug
dGhvc2UNCj4gYXJlbid0IGhvb2tlZCB1cCB0byB0aGUgUHJlc2VudCBleHRlbnNpb24gZGlyZWN0
bHkuDQo+DQo+IEl0IGNhbiB0aGVvcmV0aWNhbGx5IHdvcmsgd2l0aCByZW5kZXIgb2ZmbG9hZGlu
ZywgaWYgdGhlIHByaW1hcnkgR1BVIGNhbg0KPiBzY2FuIG91dCBkaXJlY3RseSBmcm9tIHRoZSBz
aGFyZWQgcGl4bWFwLiBUaGlzIGlzIG9ubHkgcG9zc2libGUgd2l0aA0KPiBjdXJyZW50IEFNRCBB
UFVzIHdoaWNoIHN1cHBvcnQgc2NhdHRlci9nYXRoZXIgc2Nhbm91dCAoQ2Fycml6byBhbmQNCj4g
bmV3ZXI/KS4NCg0KQWN0dWFsbHkgb25seSBDYXJpenpvIGFuZCBTdG9uZXkgYXQgdGhlIG1vbWVu
dCBiZWNhdXNlIHRoaXMgaXMgYnVnZ3kgb24gDQpSYXZlbi4gTm90IHN1cmUgaWYgdGhhdCBpcyBh
IHB1cmUgc29mdHdhcmUgb3IgYSBoYXJkd2FyZSBwcm9ibGVtLg0KDQpDaHJpc3RpYW4uDQoNCj4g
T25lIGdvdGNoYSBpcyB0aGF0IHhmODYtdmlkZW8tYW1kZ3B1IGN1cnJlbnRseSBkb2Vzbid0IGFs
bG93DQo+IGZsaXBwaW5nIGJldHdlZW4gYnVmZmVycyB3aXRoIGRpZmZlcmVudCB0aWxpbmcgcGFy
YW1ldGVycyAoQlRXIEhhcnJ5LA0KPiBkb2VzIHRoYXQgd29yayB3aXRoIERDPyksIGJ1dCB0aGF0
IHNob3VsZCBiZSBlYXN5IHRvIGZpeC4NCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
