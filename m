From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Mon, 21 Jan 2019 07:59:08 -0800
Message-ID: <20190121155908.GA8084@infradead.org>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, David Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Maarten Lankhorst <maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Michel Daenzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>

T24gTW9uLCBKYW4gMjEsIDIwMTkgYXQgMDQ6MzM6MjdQTSArMDEwMCwgQXJkIEJpZXNoZXV2ZWwg
d3JvdGU6Cj4gT24gTW9uLCAyMSBKYW4gMjAxOSBhdCAxNjowNywgQ2hyaXN0b3BoIEhlbGx3aWcg
PGhjaEBpbmZyYWRlYWQub3JnPiB3cm90ZToKPiA+Cj4gPiA+ICsjaW5jbHVkZSA8bGludXgvZG1h
LW5vbmNvaGVyZW50Lmg+Cj4gPgo+ID4gVGhpcyBoZWFkZXIgaXMgbm90IGZvciB1c2FnZSBpbiBk
ZXZpY2UgZHJpdmVycywgYnV0IHB1cmVseSBmb3IKPiA+IGRtYS1tYXBwaW5nIGltcGxlbWVudGF0
aW9ucyEKPiA+Cj4gCj4gSXMgdGhhdCBkb2N1bWVudGVkIGFueXdoZXJlPwoKSSdsbCBhZGQgYmln
IGZhdCBjb21tZW50cy4gIEJ1dCB0aGUgZmFjdCB0aGF0IG5vdGhpbmcgaXMgZXhwb3J0ZWQKdGhl
cmUgc2hvdWxkIGJlIGEgZmFpcmx5IGJpZyBoaW50LgoKPiA+IEFuZCBldmVuIGlmIHNvbWV0aGlu
ZyBsaWtlIHRoaXMgd2FzIHZhbGlkIHRvIGRvLCBpdCB3b3VsZCBoYXZlIHRvIGJlCj4gPiBhIGNv
cmUgZnVuY3Rpb24gd2l0aCBhbiBhcmNoIGhvb2ssIGFuZCBub3QgaGlkZGVuIGluIGEgcmFuZG9t
IGRyaXZlci4KPiAKPiBXaHkgd291bGQgaXQgbm90IGJlIHZhbGlkIHRvIGRvPyBJcyBpdCB3cm9u
ZyBmb3IgYSBkcml2ZXIgdG8gYmUgYXdhcmUKPiBvZiB3aGV0aGVyIGEgZGV2aWNlIGlzIGNhY2hl
IGNvaGVyZW50IG9yIG5vdD8KPiAKPiBBbmQgaW4gY2FzZSBpdCBpc24ndCwgZG8geW91IGhhdmUg
YW4gYWx0ZXJuYXRpdmUgc3VnZ2VzdGlvbiBvbiBob3cgdG8KPiBmaXggdGhpcyBtZXNzPwoKRm9y
IHRoZSB3cml0ZSBjb21iaW5lIG1hcHBpbmdzIHdlIG5lZWQgYSBwcm9wZXIgY29yZSBBUEkgaG93
IGluc3RhbmNlcwpjYW4gYWR2ZXJ0aXNlIHRoZSBzdXBwb3J0LiAgT25lIHRoaW5nIEkgd2FudCB0
byBkbyBmYWlybHkgc29vbiBpcwplcnJvciBjaGVja2luZyBvZiB0aGUgYXR0cnMgYXJndW1lbnQg
dG8gZG1hX2FsbG9jX2F0dHJzIC0gc28gaWYgeW91CnBhc3MgaW4gc29tZXRoaW5nIHVuc3VwcG9y
dGVkIGl0IHdpbGwgZ2l2ZSB5b3UgYmFjayBhbiBlcnJvci4KCkl0IHNlZW1zIHRoYXQgaXNuJ3Qg
cXVpdGUgZW5vdWdoIGZvciB0aGUgZHJtIHVzZSBjYXNlLCBzbyB3ZSBtaWdodAphbHNvIG5lZWQg
YSB3YXkgdG8gcXVlcnkgdGhlc2UgZmVhdHVyZXMsIGJ1dCB0aGF0IHJlYWxseSBoYXMgdG8gZ28K
dGhyb3VnaCB0aGUgdXN1YWwgZG1hIGxheWVyIGFic3RyYWN0aW9uIGFzIHdlbGwgYW5kIG5vdCBo
YWNrZWQgdG9nZXRoZXIKaW4gYSBkcml2ZXIgYmFzZWQgb24gYW4gZWR1YWN0ZWQgZ3Vlc3RpbWF0
ZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
