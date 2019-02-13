From: Mario Kleiner via amd-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 2/3] drm: Add basic helper to allow precise pageflip
 timestamps in vrr.
Date: Wed, 13 Feb 2019 12:05:27 +0100
Message-ID: <CAEsyxygzqwWGJLBZ5M_AkGQ7HFgzS=rxRgZ+dCFK0QG7Ek63Zw@mail.gmail.com>
References: <20190211032225.9488-1-mario.kleiner.de@gmail.com>
 <20190211032225.9488-3-mario.kleiner.de@gmail.com>
 <20190211083540.GR23159@phenom.ffwll.local>
 <41354dd1-e3fe-58cc-9c10-1a8cd05b2a40@amd.com>
 <CAKMK7uHERMMLJyu3uMP2k+atZAtUdOazzqA2R9tM05yJvk2FdA@mail.gmail.com>
 <CAEsyxyiT-k5LecWs1=Zyj9J=GPjbQFQSPzYQpDxFzjwwRvFS-A@mail.gmail.com>
 <20190213095055.GF23159@phenom.ffwll.local>
 <155005174695.11832.14626201304826541281@skylake-alporthouse-com>
Reply-To: Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <155005174695.11832.14626201304826541281@skylake-alporthouse-com>
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
To: Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>
Cc: "michel-otUistvHUpPR7s880joybQ@public.gmane.org" <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>

T24gV2VkLCBGZWIgMTMsIDIwMTkgYXQgMTA6NTYgQU0gQ2hyaXMgV2lsc29uIDxjaHJpc0BjaHJp
cy13aWxzb24uY28udWs+IHdyb3RlOgo+Cj4gUXVvdGluZyBEYW5pZWwgVmV0dGVyICgyMDE5LTAy
LTEzIDA5OjUwOjU1KQo+ID4gT24gVHVlLCBGZWIgMTIsIDIwMTkgYXQgMTA6MzI6MzFQTSArMDEw
MCwgTWFyaW8gS2xlaW5lciB3cm90ZToKPiA+ID4gSSB0aGluayBhbGwga21zIGRyaXZlcnMgdHJ5
IHRvIGNhbGwgZHJtX2NydGNfaGFuZGxlX3ZibGFuaygpIGF0IHN0YXJ0Cj4gPiA+IG9mIHZibGFu
ayB0byBnaXZlIE1lc2EgdGhlIG1vc3QgdGltZSBmb3IgZnJvbnRidWZmZXIgcmVuZGVyaW5nIGZv
cgo+ID4gPiBjbGFzc2ljIFguIEJ1dCB2YmxhbmsgZXZlbnRzIGFyZSBhbHNvIHVzZWQgZm9yIHNj
aGVkdWxpbmcgYnVmZmVyc3dhcHMKPiA+ID4gb3Igb3RoZXIgc3R1ZmYgZm9yIHJlZGlyZWN0ZWQg
d2luZG93ZWQgcmVuZGVyaW5nLCBvciB2aWEgYXBpJ3MgbGlrZQo+ID4gPiBPTUxfc3luY19jb250
cm9scyBnbFhXYWl0Rm9yTXNjT01MLCBzbyB0aGVyZSBtaWdodCBiZSBvdGhlciB0aGluZ3MKPiA+
ID4gYWZmZWN0ZWQgYnkgYSBtb3JlIGRlbGF5ZWQgdmJsYW5rIGhhbmRsaW5nLgo+ID4KPiA+IFRo
ZSBmcm9udGJ1ZmZlciByZW5kZXJpbmcgaXMgdmVyeSBtdWNoIFggZHJpdmVyIHNwZWNpZmljLCBh
bmQgSSB0aGluawo+ID4gLWFtZGdwdS9yYWRlb24gaXMgdGhlIG9ubHkgb25lIHRoYXQgcmVxdWly
ZXMgdGhpcy4gTm8gaTkxNSBkcml2ZXIgZXZlcgo+ID4gdXNlZCB0aGUgdmJsYW5rIGludGVycnVw
dCB0byBzY2hlZHVsZSBmcm9udGJ1ZmZlciBibGl0cywgd2UgdXNlIHNvbWUKPiA+IENTLXNpZGUg
c3RhbGxzLgo+Cj4gRndpdywgdGhlIFByZXNlbnQgbWlkbGF5ZXIgZG9lcyB1c2UgdmJsYW5rIHNj
aGVkdWxpbmcgZm9yIGlucGxhY2UgY29weQo+IHVwZGF0ZXMuIE5vdCB0aGF0IEkgd2lzaCB0byBl
bmNvdXJhZ2UgYW55b25lIHRvIHVzZSBmcm9udGJ1ZmZlcgo+IHJlbmRlcmluZy4KPiAtQ2hyaXMK
ClllcywgdGhhdCdzIHdoYXQgaSBtZWFudC4gVW5kZXIgRFJJMiBhdCBsZWFzdCBBTUQsIEludGVs
IGFuZCBub3V2ZWF1CmhhdmUgdGhyb3R0bGluZyBiYXNlZCBvbiBDUyBzdGFsbHMgdG8gYXZvaWQg
dGVhcmluZyBhbmQgZG8gdGhyb3R0bGluZy4KRFJJMy9QcmVzZW50IGxhc3QgdGltZSBpIGNoZWNr
ZWQganVzdCB3YWl0ZWQgZm9yIGEgdmJsYW5rIGV2ZW50IGFuZAp0aGVuIHRyaWdnZXJlZCB0aGUg
YmxpdCAtIHNvbWV0aGluZyB0aGF0IGNhdXNlcyB0ZWFyaW5nIGV2ZW4gd2hlbgp0cmlnZ2VyZWQg
YXQgc3RhcnQgb2YgdmJsYW5rLgoKLW1hcmlvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
