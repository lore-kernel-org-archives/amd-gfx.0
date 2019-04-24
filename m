From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/dp_mst: Expose build_mst_prop_path()
Date: Wed, 24 Apr 2019 23:52:21 +0300
Message-ID: <20190424205221.GJ1747@intel.com>
References: <1555977388-14203-1-git-send-email-sunpeng.li@amd.com>
 <1555977388-14203-2-git-send-email-sunpeng.li@amd.com>
 <4575edc89d88122baf2cf8dd1e12ea34a69cbb7b.camel@redhat.com>
 <d45af824-bda7-a0d4-0a6d-b51c199c3412@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d45af824-bda7-a0d4-0a6d-b51c199c3412-5C7GfCeVMHo@public.gmane.org>
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
To: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>
Cc: "Zuo, Jerry" <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gV2VkLCBBcHIgMjQsIDIwMTkgYXQgMDg6NDA6MzBQTSArMDAwMCwgTGksIFN1biBwZW5nIChM
ZW8pIHdyb3RlOgo+IAo+IAo+IAo+IE9uIDIwMTktMDQtMjQgMToyNiBwLm0uLCBMeXVkZSBQYXVs
IHdyb3RlOgo+ID4gQ2xvc2VyLCBidXQgYXJlIHdlIHN1cmUgd2Ugd2FudCB0byB1c2UgdGhlIE1T
VCBwcm9wIHBhdGggZm9yIHRoaXM/IFdoeSBub3QgYWRkCj4gPiBhIHN5c2ZzIGF0dHJpYnV0ZSB3
aXRoIHRoZSBjb3JyZXNwb25kaW5nIERSTSBjb25uZWN0b3IgbmFtZSBpbnN0ZWFkIHNpbmNlIHRo
ZQo+ID4gY29ubmVjdG9yIGl0c2VsZiB3aWxsIGhhdmUgYSBwYXRoIHByb3BlcnR5LiBUaGF0IHdh
eSB3ZSBjYW4gYXNzb2NpYXRlIGF1eAo+ID4gZGV2aWNlcyBmb3IgZURQIGFuZCBEUCBkZXZpY2Vz
IHdpdGggdGhlaXIgY29ycmVzcG9uZGluZyBjb25uZWN0b3JzIGFzIHdlbGwKPiAKPiBJIHRob3Vn
aHQgYWJvdXQgdGhhdCBhcyB3ZWxsLCBidXQgSSBoaXQgYSB3YWxsIHdoZW4gdHJ5aW5nIHRvIGdl
dCB0aGUKPiBTU1QgY29ubmVjdG9yIGZyb20gdGhlIGF1eCBkZXZpY2UuIFBlcmhhcHMgdGhlcmUn
cyBhIHNpbXBsZXIgd2F5IHRoYXQKPiBJJ20gb3Zlcmxvb2tpbmc/Cj4gCj4gSXQncyBlYXNpZXIg
Zm9yIE1TVCwgc2luY2UgdGhlIG1zdF9wb3J0IGNhbiBiZSBvYnRhaW5lZCB2aWEgY29udGFpbmVy
X29mCj4gZHBfYXV4LiBwb3J0LT5jb25uZWN0b3Igd291bGQgdGhlbiBnaXZlIHdoYXQgd2Ugd2Fu
dC4KPiAKPiBGb3IgU1NUIHRob3VnaCwgZWFjaCBkcml2ZXIgY2FsbHMgZHJtX2F1eF9yZWdpc3Rl
cigpIHdpdGggYW4gYXV4IHN0cnVjdAo+IHRoYXQgdGhleSd2ZSBpbml0aWFsaXplZC4gSSdtIG5v
dCBzdXJlIGhvdyBJIGNhbiByZWxpYWJseSBnZXQgdGhlCj4gZHJtX2Nvbm5lY3RvciBmcm9tIHRo
YXQuCgpPbiBpOTE1IHRoZSBhdXggaXMgYSBjaGlsZCBvZiB0aGUgY29ubmVjdG9yLCBzbyBubyBl
eHRyYQphdHRyaWJ1dGVzL2xpbmtzIG5lZWRlZC4gTWF5YmUgb3RoZXIgZHJpdmVycyBzaG91bGQv
Y291bGQKZm9sbG93ICB0aGF0IGFwcG9yYWNoIGFzIHdlbGw/CgotLSAKVmlsbGUgU3lyasOkbMOk
CkludGVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
