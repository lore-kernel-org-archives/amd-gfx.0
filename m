From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2 0/3] A DRM API for adaptive sync and variable refresh
 rate support
Date: Fri, 26 Oct 2018 11:33:31 +0200
Message-ID: <8cb0ee1c-777c-47ae-166d-ca1130a00646@daenzer.net>
References: <20180924181537.12092-1-nicholas.kazlauskas@amd.com>
 <20181001071525.GJ11082@phenom.ffwll.local>
 <CAHbf0-HhjG2xc1sAjHBR=Ep11LzumO6tdyzBcKSZ8h82H28Zbg@mail.gmail.com>
 <814b9eae-8c17-4eb7-2bb7-a6ec1f0fab41@amd.com>
 <ac5b5865-6bb0-08e8-d83c-26893e75b11e@daenzer.net>
 <84c4a243-ca2c-49a7-9e2c-22666292aea9@amd.com>
 <1c3d19a7-3afa-6de5-59e0-37a19d73848b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1c3d19a7-3afa-6de5-59e0-37a19d73848b-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: "Haehnle, Nicolai" <Nicolai.Haehnle-5C7GfCeVMHo@public.gmane.org>, "Olsak,
 Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOC0xMC0yNSA3OjU3IHAubS4sIFdlbnRsYW5kLCBIYXJyeSB3cm90ZToKPiBPbiAyMDE4
LTEwLTEyIDQ6MzEgYS5tLiwgS29lbmlnLCBDaHJpc3RpYW4gd3JvdGU6Cj4+IEFtIDEyLjEwLjIw
MTggdW0gMTA6MjYgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPj4+IE9uIDIwMTgtMTAtMTEgOTo0
NCBwLm0uLCBIYXJyeSBXZW50bGFuZCB3cm90ZToKPj4+PiBPbiAyMDE4LTEwLTAzIDA0OjI1IEFN
LCBNaWtlIExvdGhpYW4gd3JvdGU6Cj4+Pj4+IEknbSBjdXJpb3VzIHRvIGtub3cgd2hldGhlciB0
aGlzIHdpbGwvY291bGQgd29yayBvdmVyIFBSSU1FCj4+Pj4gSSBkb24ndCBzZWUgd2h5IHRoaXMg
c2hvdWxkbid0IHdvcmsgb3ZlciBQUklNRSBhcyBsb25nIGFzIHRoZSAKPj4+PiBwcmVzZW50aW5n
IEdQVSBzdXBwb3J0cyB0aGUgbmV3IHZhcmlhYmxlIHJlZnJlc2ggcmF0ZSBBUEksIGJ1dAo+Pj4+
IEkga25vdyB2ZXJ5IGxpdHRsZSBhYm91dCBwcmltZSwgc28gbWF5YmUgc29tZW9uZSBlbHNlIGNh
biBjaGltZQo+Pj4+IGluIGFuZCBnaXZlIGEgYmV0dGVyIG9waW5pb24uCj4+PiBJdCB3b24ndCB3
b3JrIGZvciBkaXNwbGF5cyBjb25uZWN0ZWQgdG8gYSBzZWNvbmRhcnkgR1BVLCBiZWNhdXNlCj4+
PiB0aG9zZSBhcmVuJ3QgaG9va2VkIHVwIHRvIHRoZSBQcmVzZW50IGV4dGVuc2lvbiBkaXJlY3Rs
eS4KPj4+IAo+Pj4gSXQgY2FuIHRoZW9yZXRpY2FsbHkgd29yayB3aXRoIHJlbmRlciBvZmZsb2Fk
aW5nLCBpZiB0aGUgcHJpbWFyeQo+Pj4gR1BVIGNhbiBzY2FuIG91dCBkaXJlY3RseSBmcm9tIHRo
ZSBzaGFyZWQgcGl4bWFwLiBUaGlzIGlzIG9ubHkKPj4+IHBvc3NpYmxlIHdpdGggY3VycmVudCBB
TUQgQVBVcyB3aGljaCBzdXBwb3J0IHNjYXR0ZXIvZ2F0aGVyCj4+PiBzY2Fub3V0IChDYXJyaXpv
IGFuZCBuZXdlcj8pLgo+PiAKPj4gQWN0dWFsbHkgb25seSBDYXJpenpvIGFuZCBTdG9uZXkgYXQg
dGhlIG1vbWVudCBiZWNhdXNlIHRoaXMgaXMKPj4gYnVnZ3kgb24gUmF2ZW4uIE5vdCBzdXJlIGlm
IHRoYXQgaXMgYSBwdXJlIHNvZnR3YXJlIG9yIGEgaGFyZHdhcmUKPj4gcHJvYmxlbS4KPj4gCj4+
IENocmlzdGlhbi4KPj4gCj4+PiBPbmUgZ290Y2hhIGlzIHRoYXQgeGY4Ni12aWRlby1hbWRncHUg
Y3VycmVudGx5IGRvZXNuJ3QgYWxsb3cgCj4+PiBmbGlwcGluZyBiZXR3ZWVuIGJ1ZmZlcnMgd2l0
aCBkaWZmZXJlbnQgdGlsaW5nIHBhcmFtZXRlcnMgKEJUVwo+Pj4gSGFycnksIGRvZXMgdGhhdCB3
b3JrIHdpdGggREM/KSwgYnV0IHRoYXQgc2hvdWxkIGJlIGVhc3kgdG8gZml4Lgo+PiAKPiAKPiBO
b3QgY3VycmVudGx5LiBGaXhhYmxlLCBidXQgdW5mb3J0dW5hdGVseSBub3QgYXMgZWFzeSBhcyBJ
J2QgaG9wZS4KPiBUaGUgZ29vZCBuZXdzIGlzIHRoYXQgSSdtIHBsYW5uaW5nIHRvIHJld29yayB0
aGF0IGNvZGUgc28gaXQgd291bGQgYmUKPiBlYXN5IHRvIGZpeCBvciBzaG91bGQganVzdCBoYXBw
ZW4gb24gYSBwZXItZmxpcCBiYXNpcy4KCkZXSVcsIEkgd291bGRuJ3Qgc3BlbmQgYW55IGVmZm9y
dCBzcGVjaWZpY2FsbHkgb24gbWFraW5nIHRoaXMgd29yay4gSXQncwpub3QgaW50ZW5kZWQgdG8g
d29yayB3aXRoIHRoZSBub24tYXRvbWljIGZsaXAgaW9jdGwgYXQgbGVhc3QsIGFuZCBpdApkZWZp
bml0ZWx5IGRvZXNuJ3Qgd29yayB3aXRob3V0IERDLCBzbyB4Zjg2LXZpZGVvLWFtZGdwdSB3aWxs
IGhhdmUgdG8KaGFuZGxlIGl0IGFueXdheS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVy
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBz
b2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBk
ZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
