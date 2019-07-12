From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 07/10] drm/i915: Implement MST Aux device registration
Date: Fri, 12 Jul 2019 23:15:25 +0300
Message-ID: <20190712201525.GO5942@intel.com>
References: <20190704190519.29525-1-sunpeng.li@amd.com>
 <20190704190519.29525-8-sunpeng.li@amd.com>
 <5673f815f4bc01b5d88961a1c087bed2e84ad466.camel@redhat.com>
 <20190712200559.GN5942@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190712200559.GN5942-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
To: Lyude Paul <lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: sunpeng.li-5C7GfCeVMHo@public.gmane.org, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gRnJpLCBKdWwgMTIsIDIwMTkgYXQgMTE6MDU6NTlQTSArMDMwMCwgVmlsbGUgU3lyasOkbMOk
IHdyb3RlOgo+IE9uIEZyaSwgSnVsIDEyLCAyMDE5IGF0IDAzOjQ4OjUzUE0gLTA0MDAsIEx5dWRl
IFBhdWwgd3JvdGU6Cj4gPiBCVFcsIEkganVzdCB0cmllZCB0aGVzZSBwYXRjaGVzIG9uIG15IFQ0
NTBzICh1c2luZyBpOTE1KSBhbmQgSSdtIHNlZWluZyBzb21lCj4gPiBrZXJuZWwgd2FybmluZ3Mg
d2l0aCB0aGVtIHdoZW4gYWRkaW5nIERQIGF1eCBkZXZpY2VzIGFmdGVyIGNvbm5lY3RpbmcgYSBu
ZXcKPiA+IE1TVCB0b3BvbG9neSB0byB0aGUgc3lzdGVtOiAKPiA+IAo+ID4gWyAgMzY3Ljc0MjU3
MV0gV0FSTklORzogQ1BVOiAyIFBJRDogNDQyIGF0IGRyaXZlcnMvZ3B1L2RybS9kcm1fbW9kZV9v
YmplY3QuYzo0NSBfX2RybV9tb2RlX29iamVjdF9hZGQrMHhhYS8weGIwIFtkcm1dCj4gCj4gTG9v
a3MgbGlrZSBEYW5pZWwgYWRkZWQgdGhhdCBwYXJ0aWN1bGFyIFdBUk4gaW4KPiBjb21taXQgNGY1
MzY4YjU1NDFhICAoImRybS9rbXM6IENhdGNoIG1vZGVfb2JqZWN0IGxpZmV0aW1lIGVycm9ycyIp
LgoKQW5kIEknbSB0aGUgb25lIHdobyBhZGRlZCB0aGUgbWF4X2JwYyBwcm9wIHRvIHRoZSBtc3Qg
Y29ubmVjdG9ycywgd2hpY2gKaXMgYSBwZXItY29ubmVjdG9yIHByb3BlcnR5IChpZS4gYSBuZXcg
b25lIGdldHMgY3JlYXRlZCBmb3IgZXZlcnkKY29ubmVjb3RvcikuIFNvIHRoYXQgY291bGQgYmUg
YSBwcm9ibGVtIEkgc3VwcG9zZS4gSSBndWVzcyB3ZSBtYXkgbmVlZAp0byBjcmVhdGUganVzdCBv
bmUgb2YgdGhlc2UgZm9yIE1TVCBhbmQgcmV1c2UgaXQgZm9yIGV2ZXJ5IGNvbm5lY3Rvci4KQ291
bGQganVzdCBwb2ludCBhdCB0aGUgcHJvcCBvZiB0aGUgY29ycmVzcG9uZGluZyBTU1QgY29ubmVj
dG9yIEkKc3VwcG9zZS4uLgoKKyAgICAgICAvKiBSZXVzZSB0aGUgcHJvcCBiZWNhdXNlIGJsYWgg
Ki8KKyAgICAgICBjb25uZWN0b3ItPm1heF9icGNfcHJvcGVydHkgPQorICAgICAgICAgICAgICAg
aW50ZWxfZHAtPmF0dGFjaGVkX2Nvbm5lY3Rvci0+YmFzZS5tYXhfYnBjX3Byb3BlcnR5OwogICAg
ICAgIGRybV9jb25uZWN0b3JfYXR0YWNoX21heF9icGNfcHJvcGVydHkoY29ubmVjdG9yLCA2LCAx
Mik7CgoKLS0gClZpbGxlIFN5cmrDpGzDpApJbnRlbApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZng=
