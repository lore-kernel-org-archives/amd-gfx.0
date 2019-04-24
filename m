From: Lyude Paul <lyude-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/dp_mst: Expose build_mst_prop_path()
Date: Wed, 24 Apr 2019 16:55:38 -0400
Message-ID: <63513fd23340d12f31c9769b3454f771312f3096.camel@redhat.com>
References: <1555977388-14203-1-git-send-email-sunpeng.li@amd.com>
 <1555977388-14203-2-git-send-email-sunpeng.li@amd.com>
 <4575edc89d88122baf2cf8dd1e12ea34a69cbb7b.camel@redhat.com>
 <d45af824-bda7-a0d4-0a6d-b51c199c3412@amd.com>
 <20190424205221.GJ1747@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190424205221.GJ1747-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>
Cc: "Zuo, Jerry" <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gV2VkLCAyMDE5LTA0LTI0IGF0IDIzOjUyICswMzAwLCBWaWxsZSBTeXJqw6Rsw6Qgd3JvdGU6
Cj4gT24gV2VkLCBBcHIgMjQsIDIwMTkgYXQgMDg6NDA6MzBQTSArMDAwMCwgTGksIFN1biBwZW5n
IChMZW8pIHdyb3RlOgo+ID4gCj4gPiAKPiA+IE9uIDIwMTktMDQtMjQgMToyNiBwLm0uLCBMeXVk
ZSBQYXVsIHdyb3RlOgo+ID4gPiBDbG9zZXIsIGJ1dCBhcmUgd2Ugc3VyZSB3ZSB3YW50IHRvIHVz
ZSB0aGUgTVNUIHByb3AgcGF0aCBmb3IgdGhpcz8gV2h5Cj4gPiA+IG5vdCBhZGQKPiA+ID4gYSBz
eXNmcyBhdHRyaWJ1dGUgd2l0aCB0aGUgY29ycmVzcG9uZGluZyBEUk0gY29ubmVjdG9yIG5hbWUg
aW5zdGVhZAo+ID4gPiBzaW5jZSB0aGUKPiA+ID4gY29ubmVjdG9yIGl0c2VsZiB3aWxsIGhhdmUg
YSBwYXRoIHByb3BlcnR5LiBUaGF0IHdheSB3ZSBjYW4gYXNzb2NpYXRlCj4gPiA+IGF1eAo+ID4g
PiBkZXZpY2VzIGZvciBlRFAgYW5kIERQIGRldmljZXMgd2l0aCB0aGVpciBjb3JyZXNwb25kaW5n
IGNvbm5lY3RvcnMgYXMKPiA+ID4gd2VsbAo+ID4gCj4gPiBJIHRob3VnaHQgYWJvdXQgdGhhdCBh
cyB3ZWxsLCBidXQgSSBoaXQgYSB3YWxsIHdoZW4gdHJ5aW5nIHRvIGdldCB0aGUKPiA+IFNTVCBj
b25uZWN0b3IgZnJvbSB0aGUgYXV4IGRldmljZS4gUGVyaGFwcyB0aGVyZSdzIGEgc2ltcGxlciB3
YXkgdGhhdAo+ID4gSSdtIG92ZXJsb29raW5nPwo+ID4gCj4gPiBJdCdzIGVhc2llciBmb3IgTVNU
LCBzaW5jZSB0aGUgbXN0X3BvcnQgY2FuIGJlIG9idGFpbmVkIHZpYSBjb250YWluZXJfb2YKPiA+
IGRwX2F1eC4gcG9ydC0+Y29ubmVjdG9yIHdvdWxkIHRoZW4gZ2l2ZSB3aGF0IHdlIHdhbnQuCj4g
PiAKPiA+IEZvciBTU1QgdGhvdWdoLCBlYWNoIGRyaXZlciBjYWxscyBkcm1fYXV4X3JlZ2lzdGVy
KCkgd2l0aCBhbiBhdXggc3RydWN0Cj4gPiB0aGF0IHRoZXkndmUgaW5pdGlhbGl6ZWQuIEknbSBu
b3Qgc3VyZSBob3cgSSBjYW4gcmVsaWFibHkgZ2V0IHRoZQo+ID4gZHJtX2Nvbm5lY3RvciBmcm9t
IHRoYXQuCj4gCj4gT24gaTkxNSB0aGUgYXV4IGlzIGEgY2hpbGQgb2YgdGhlIGNvbm5lY3Rvciwg
c28gbm8gZXh0cmEKPiBhdHRyaWJ1dGVzL2xpbmtzIG5lZWRlZC4gTWF5YmUgb3RoZXIgZHJpdmVy
cyBzaG91bGQvY291bGQKPiBmb2xsb3cgIHRoYXQgYXBwb3JhY2ggYXMgd2VsbD8KCm9vbywgZ29v
ZCBwb2ludC4gWWVhaCB0aGF0IHNlZW1zIGxpa2UgaXQgd291bGQgYmUgd29ydGggYSBzaG90IHNp
bmNlIGl0J2QgYmUgYQpsaXR0bGUgbmljZXIgdGhlbiBqdXN0IGFkZGluZyBtb3JlIHN5c2ZzIGF0
dHJpYnV0ZXMuIEJ1dCBvdGhlcndpc2UgaWYgdGhhdApkb2Vzbid0IHdvcmssIGFkZGluZyBhIGNv
bm5lY3RvciBwYXJhbWV0ZXIgdG8gZHJtX2RwX2F1eF9yZWdpc3RlcigpIHNob3VsZCBiZQpmaW5l
LgoKPiAKLS0gCkNoZWVycywKCUx5dWRlIFBhdWwKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA==
