From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] drm: fourcc byteorder: brings header file comments in
 line with reality.
Date: Sat, 22 Apr 2017 13:05:22 +0300
Message-ID: <20170422100522.GS30290@intel.com>
References: <20170421075825.6307-1-kraxel@redhat.com>
 <20170421092530.GE30290@intel.com>
 <1492768218.25675.33.camel@redhat.com>
 <20170421110804.GH30290@intel.com>
 <f1b0ae60-b20e-ad52-7fbf-32f2c045f5fc@amd.com>
 <1492780323.25675.45.camel@redhat.com>
 <1492791271.25675.57.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1492791271.25675.57.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>

T24gRnJpLCBBcHIgMjEsIDIwMTcgYXQgMDY6MTQ6MzFQTSArMDIwMCwgR2VyZCBIb2ZmbWFubiB3
cm90ZToKPiAgIEhpLAo+IAo+ID4gPiBNeSBwZXJzb25hbCBvcGluaW9uIGlzIHRoYXQgZm9ybWF0
cyBpbiBkcm1fZm91cmNjLmggc2hvdWxkIGJlIAo+ID4gPiBpbmRlcGVuZGVudCBvZiB0aGUgQ1BV
IGJ5dGUgb3JkZXIgYW5kIHRoZSBmdW5jdGlvbiAKPiA+ID4gZHJtX21vZGVfbGVnYWN5X2ZiX2Zv
cm1hdCgpIGFuZCBkcml2ZXJzIGRlcGVuZGluZyBvbiB0aGF0IGluY29ycmVjdCAKPiA+ID4gYXNz
dW1wdGlvbiBiZSBmaXhlZCBpbnN0ZWFkLgo+ID4gCj4gPiBUaGUgcHJvYmxlbSBpcyB0aGlzIGlz
bid0IGEga2VybmVsLWludGVybmFsIHRoaW5nIGFueSBtb3JlLiAgV2l0aCB0aGUKPiA+IGFkZGl0
aW9uIG9mIHRoZSBBRERGQjIgaW9jdGwgdGhlIGZvdXJjYyBjb2RlcyBiZWNhbWUgcGFydCBvZiB0
aGUKPiA+IGtlcm5lbC91c2Vyc3BhY2UgYWJpIC4uLgo+IAo+IE9rLCBhZGRlZCBzb21lIHByaW50
aydzIHRvIHRoZSBBRERGQiBhbmQgQURERkIyIGNvZGUgcGF0aHMgYW5kIHRlc3RlZCBhCj4gYml0
LiAgQXBwYXJlbnRseSBwcmV0dHkgbXVjaCBhbGwgdXNlcnNwYWNlIHN0aWxsIHVzZXMgdGhlIEFE
REZCIGlvY3RsLgo+IHhvcmcgKG1vZGVzZXR0aW5nIGRyaXZlcikgZG9lcy4gIGdub21lLXNoZWxs
IGluIHdheWxhbmQgbW9kZSBkb2VzLgo+IFNlZW1zIHRoZSBiaWcgdHJhbnNpdGlvbiB0byBBRERG
QjIgZGlkbid0IGhhcHBlbiB5ZXQuCj4gCj4gSSBndWVzcyB0aGF0IG1ha2VzIGNoYW5naW5nIGRy
bV9tb2RlX2xlZ2FjeV9mYl9mb3JtYXQgKyBkcml2ZXJzIGEKPiByZWFzb25hYmxlIG9wdGlvbiAu
Li4KClllYWgsIEkgY2FtZSB0byB0aGUgc2FtZSBjb25jbHVzaW9uIGFmdGVyIGNoYXR0aW5nIHdp
dGggc29tZQpmb2xrcyBvbiBpcmMuCgpTbyBteSBjdXJyZW50IGlkZWEgaXMgdGhhdCB3ZSBjaGFu
Z2UgYW55IGRyaXZlciB0aGF0IHdhbnRzIHRvIGZvbGxvdyB0aGUKQ1BVIGVuZGlhbm5lc3MgdG8g
ZGVjbGFyZSBzdXBwb3J0IGZvciBiaWcgZW5kaWFuIGZvcm1hdHMgaWYgdGhlIENQVSBpcwpiaWcg
ZW5kaWFuLiBQcmVzdW1hYmx5IHRoZXNlIGFyZSBtb3N0bHkgdGhlIHZpcnR1YWwgR1BVIGRyaXZl
cnMuCgpBZGRpdG9uYWxseSB3ZSdsbCBtYWtlIHRoZSBtYXBwaW5nIHBlcmZvcm1lZCBieSBkcm1f
bW9kZV9sZWdhY3lfZmJfZm9ybWF0KCkKZHJpdmVyIGNvbnRyb2xsZWQuIFRoYXQgd2F5IGRyaXZl
cnMgdGhhdCBnb3QgY2hhbmdlZCB0byBmb2xsb3cgQ1BVCmVuZGlhbm5lc3MgY2FuIHJldHVybiBh
IGZyYW1lYnVmZmVyIHRoYXQgbWF0Y2hlcyBDUFUgZW5kaWFubmVzcy4gQW5kCmRyaXZlcnMgdGhh
dCBleHBlY3QgdGhlIEdQVSBlbmRpYW5uZXNzIHRvIG5vdCBkZXBlbmQgb24gdGhlIENQVQplbmRp
YW5uZXNzIHdpbGwga2VlcCB3b3JraW5nIGFzIHRoZXkgZG8gbm93LiBUaGUgZG93bnNpZGUgaXMg
dGhhdCB1c2VycwpvZiB0aGUgbGVnYWN5IGFkZGZiIGlvY3RsIHdpbGwgbmVlZCB0byBtYWdpY2Fs
bHkga25vdyB3aGljaCBlbmRpYW5uZXNzCnRoZXkgd2lsbCBnZXQsIGJ1dCB0aGF0IGlzIGFwcGFy
ZW50bHkgYWxyZWFkeSB0aGUgY2FzZS4gQW5kIHVzZXJzIG9mCmFkZGZiMiB3aWxsIGtlZXAgb24g
c3BlY2lmeWluZyB0aGUgZW5kaWFubmVzcyBleHBsaWNpdGx5IHdpdGgKRFJNX0ZPUk1BVF9CSUdf
RU5ESUFOIHZzLiAwLgoKRG9lcyB0aGF0IHNvdW5kIGxpa2UgYSB3b3JrYWJsZSBzb2x1dGlvbj8K
Ci0tIApWaWxsZSBTeXJqw6Rsw6QKSW50ZWwgT1RDCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
