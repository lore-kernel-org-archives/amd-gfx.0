From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] drm: fourcc byteorder: brings header file comments in
 line with reality.
Date: Fri, 21 Apr 2017 14:05:56 +0300
Message-ID: <20170421110556.GG30290@intel.com>
References: <20170421075825.6307-1-kraxel@redhat.com>
 <20170421092530.GE30290@intel.com>
 <1492768218.25675.33.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1492768218.25675.33.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>

T24gRnJpLCBBcHIgMjEsIDIwMTcgYXQgMTE6NTA6MThBTSArMDIwMCwgR2VyZCBIb2ZmbWFubiB3
cm90ZToKPiBPbiBGciwgMjAxNy0wNC0yMSBhdCAxMjoyNSArMDMwMCwgVmlsbGUgU3lyasOkbMOk
IHdyb3RlOgo+ID4gT24gRnJpLCBBcHIgMjEsIDIwMTcgYXQgMDk6NTg6MjRBTSArMDIwMCwgR2Vy
ZCBIb2ZmbWFubiB3cm90ZToKPiA+ID4gV2hpbGUgd29ya2luZyBvbiBncmFwaGljcyBzdXBwb3J0
IGZvciB2aXJ0dWFsIG1hY2hpbmVzIG9uIHBwYzY0ICh3aGljaAo+ID4gPiBleGlzdHMgaW4gYm90
aCBsaXR0bGUgYW5kIGJpZyBlbmRpYW4gdmFyaWFudHMpIEkndmUgZmlndXJlZCB0aGUgY29tbWVu
dHMKPiA+ID4gZm9yIHZhcmlvdXMgZHJtIGZvdXJjYyBmb3JtYXRzIGluIHRoZSBoZWFkZXIgZmls
ZSBkb24ndCBtYXRjaCByZWFsaXR5Lgo+ID4gPiAKPiA+ID4gQ29tbWVudHMgc2F5cyB0aGUgUkdC
IGZvcm1hdHMgYXJlIGxpdHRsZSBlbmRpYW4sIGJ1dCBpbiBwcmFjdGljZSB0aGV5Cj4gPiA+IGFy
ZSBuYXRpdmUgZW5kaWFuLiAgTG9vayBhdCB0aGUgZHJtX21vZGVfbGVnYWN5X2ZiX2Zvcm1hdCgp
IGhlbHBlci4gIEl0Cj4gPiA+IG1hcHMgLS0gZm9yIGV4YW1wbGUgLS0gYnBwL2RlcHRoIDMyLzI0
IHRvIERSTV9GT1JNQVRfWFJHQjg4ODgsIG5vIG1hdHRlcgo+ID4gPiB3aGVuZXZlciB0aGUgbWFj
aGluZSBpcyBsaXR0bGUgZW5kaWFuIG9yIGJpZyBlbmRpYW4uICBUaGUgdXNlcnMgb2YgdGhpcwo+
ID4gPiBmdW5jdGlvbiAoZmJkZXYgZW11bGF0aW9uLCBEUk1fSU9DVExfTU9ERV9BRERGQikgZXhw
ZWN0IHRoZSBmcmFtZWJ1ZmZlcgo+ID4gPiBpcyBuYXRpdmUgZW5kaWFuLCBub3QgbGl0dGxlIGVu
ZGlhbi4gIE1vc3QgdXNlcnNwYWNlIGFsc28gb3BlcmF0ZXMgb24KPiA+ID4gbmF0aXZlIGVuZGlh
biBvbmx5Lgo+ID4gCj4gPiBJJ20gbm90IGEgZmFuIG9mICJuYXRpdmUiLiBOYXRpdmUgdG8gd2hh
dD8gIkNQVSIgb3IgImhvc3QiIGlzIHdoYXQgSSdkCj4gPiBjYWxsIGl0Lgo+IAo+IG5hdGl2ZSA9
PSB3aGF0ZXZlciB0aGUgY3B1IGlzIHVzaW5nLgo+IAo+IEkgcGVyc29uYWxseSBmaW5kICJuYXRp
dmUiIG1vcmUgaW50dWl0aXZlLCBidXQgYXQgdGhlIGVuZCBvZiB0aGUgZGF5IEkKPiBkb24ndCBt
aW5kIG11Y2guICBJZiBwZW9wbGUgcHJlZmVyICJob3N0IiBvdmVyICJuYXRpdmUiIEknbGwgY2hh
bmdlIGl0Lgo+IAo+ID4gQW5kIHdoYXQgYWJvdXQgdGhlIG14aWVkIGVuZGlhbiBjYXNlPyBBcmUg
eW91IGp1c3QgZ29pbmcgdG8gcHJldGVuZCBpdAo+ID4gZG9lc24ndCBleGlzdCBvciB3aGF0Pwo+
IAo+IFdoYXQgZXhhY3RseSBkbyB5b3UgbWVhbiB3aXRoICJtaXhlZCBlbmRpYW4iPyAgVGhlIHBv
d2VycGMgY2FzZSwgd2hlcmUKPiBrZXJuZWwgKyB1c2Vyc3BhY2UgY2FuIHJ1biBpbiBlaXRoZXIg
YmlnIG9yIGxpdHRsZSBlbmRpYW4gbW9kZT8gIE9yCj4gc29tZXRoaW5nIGVsc2U/CgpCaWcgZW5k
aWFuIENQVSBhbmQgbGl0dGxlIGVuZGlhbiBHUFUuIEkgdGhpbmsgdGhhdCBzaG91bGQgYmUgdGhl
IG1vc3QKY29tbW9uIGNhc2UgdGhlc2UgZGF5cy4KCi0tIApWaWxsZSBTeXJqw6Rsw6QKSW50ZWwg
T1RDCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
