From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] drm: fourcc byteorder: brings header file comments in
 line with reality.
Date: Fri, 21 Apr 2017 12:44:49 +0300
Message-ID: <20170421094449.GF30290@intel.com>
References: <20170421075825.6307-1-kraxel@redhat.com>
 <20170421110605.1a255f44@eldfell>
 <1492767508.25675.23.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1492767508.25675.23.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

T24gRnJpLCBBcHIgMjEsIDIwMTcgYXQgMTE6Mzg6MjhBTSArMDIwMCwgR2VyZCBIb2ZmbWFubiB3
cm90ZToKPiAgIEhpLAo+IAo+ID4gPiBMZWF2aW5nIHRoZSB5dXYgZm9ybWF0cyBhcy1pcy4gIEkg
aGF2ZSBubyBpZGVhIGlmIGFuZCBob3cgdGhvc2UgYXJlIHVzZWQKPiA+ID4gb24gYmlnZW5kaWFu
IG1hY2hpbmVzLgo+IAo+ID4ganVzdCBhbiBpZGVhIC0gc2luY2Ugd2UgYXJlIG5vdCBzdXJlIGhv
dyB0aGUgcmVtYWluaW5nIGZvcm1hdHMgYXJlIGJlaW5nCj4gPiB1c2VkLCBzaG91bGQgdGhvc2Ug
YmUgbWFya2VkIHNvbWVob3cgdW5jZXJ0YWluIHdoZXRoZXIgdGhleSBhcmUgbGl0dGxlCj4gPiBv
ciBuYXRpdmUgZW5kaWFuPwo+IAo+IEFUTSB0aGUgeXV2IGRvbid0IGhhdmUgYW55IGJ5dGUgb3Jk
ZXIgYW5ub3RhdGlvbnMsIGFuZCBJIHNpbXBseSBsZWZ0Cj4gdGhlbSB0aGF0IHdheS4gIFNvIGl0
IGlzIGFzIGNsZWFyL3VuY2xlYXIgYXMgYmVmb3JlLgoKRWg/IEV2ZXJ5dGhpbmcgdGhhdCBpcyBh
ZmZlY3RlZCBieSBieXRlIG9yZGVyIGhhcyB0aGUgcmVsZXZhbnQgY29tbWVudHMuCklmIHRoZXkg
ZG9uJ3QsIHRoZW4gdGhhdCdzIGEgYnVnLgoKPiAKPiBJSVJDIHNvbWVvbmUgbWVudGlvbmVkIHRo
YXQgZm9yIHRoZSB5dXYgZm91cmNjcyB0aGVyZSBhY3R1YWxseSBpcyBzb21lCj4gc3RhbmRhcmQg
YWJvdXQgdGhlIGV4YWN0IG9yZGVyaW5nLiAgQW55b25lIGhhcyBhIGdvb2QgcmVmZXJlbmNlPyAg
V2UKPiBjb3VsZCBzdGljayBhIGxpbmsgdG8gaXQgaW50byBhIGNvbW1lbnQuCgpUaGUgInN0YW5k
YXJkIiBpcyBmb3VyY2MuIFdoZXRoZXIgdGhlcmUgaXMgYW55IG9mZmljaWFsIHJlZmVyZW5jZSBm
b3IKdGhhdCBpcyB1bmNsZWFyLiBUaGF0J3MgZXhhY3RseSB3aHkgSSBhZGRlZCB0aGUgZXhwbGlj
aXQgY29tbWVudHMgaW50bwpkcm1fZm91cmNjLmggc28gdGhhdCBwZW9wbGUgZG9uJ3QgaGF2ZSB0
byBnbyB0cmF3bGluZyB0aGUgaW50ZXJuZXRzCmxvb2tpbmcgZm9yIGluZm9ybWF0aW9uIG9uIHdo
YXQgZWFjaCBwaXhlbCBmb3JtYXQgbWlnaHQgbWVhbi4KCi0tIApWaWxsZSBTeXJqw6Rsw6QKSW50
ZWwgT1RDCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
