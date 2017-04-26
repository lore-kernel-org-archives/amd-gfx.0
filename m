From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 3/6] drm: fourcc byteorder: add bigendian support to
 drm_mode_legacy_fb_format
Date: Wed, 26 Apr 2017 17:30:40 +0300
Message-ID: <20170426143040.GW30290@intel.com>
References: <20170424062532.26722-1-kraxel@redhat.com>
 <20170424062532.26722-4-kraxel@redhat.com>
 <3b872a56-80b5-0c44-712f-a9517489eb24@daenzer.net>
 <20170425095259.GK30290@intel.com>
 <b306654e-ae14-99f5-d129-8fc1fb8cc05d@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b306654e-ae14-99f5-d129-8fc1fb8cc05d-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

T24gV2VkLCBBcHIgMjYsIDIwMTcgYXQgMTE6MDA6MDlBTSArMDkwMCwgTWljaGVsIETDpG56ZXIg
d3JvdGU6Cj4gT24gMjUvMDQvMTcgMDY6NTIgUE0sIFZpbGxlIFN5cmrDpGzDpCB3cm90ZToKPiA+
IE9uIFR1ZSwgQXByIDI1LCAyMDE3IGF0IDEyOjE4OjUyUE0gKzA5MDAsIE1pY2hlbCBEw6RuemVy
IHdyb3RlOgo+ID4+IE9uIDI0LzA0LzE3IDAzOjI1IFBNLCBHZXJkIEhvZmZtYW5uIHdyb3RlOgo+
ID4+PiArI2lmZGVmIF9fQklHX0VORElBTgo+ID4+PiArCXN3aXRjaCAoYnBwKSB7Cj4gPj4+ICsJ
Y2FzZSA4Ogo+ID4+PiArCQlmbXQgPSBEUk1fRk9STUFUX0M4Owo+ID4+PiArCQlicmVhazsKPiA+
Pj4gKwljYXNlIDI0Ogo+ID4+PiArCQlmbXQgPSBEUk1fRk9STUFUX0JHUjg4ODsKPiA+Pj4gKwkJ
YnJlYWs7Cj4gPj4KPiA+PiBCVFcsIGVuZGlhbm5lc3MgYXMgYSBjb25jZXB0IGNhbm5vdCBhcHBs
eSB0byA4IG9yIDI0IGJwcCBmb3JtYXRzLgo+ID4gCj4gPiBUbyA4YnBwIG5vLCBidXQgaXQgY2Fu
IGVhc2lseSBhcHBseSB0byAyNGJwcC4KPiAKPiBBbnkgYnl0ZSBzd2FwcGluZyByaXBzIGFwYXJ0
IHRoZSBieXRlcyBvZiBhIDI0YnBwIHBpeGVsLCBzbyB0aG9zZQo+IGZvcm1hdHMgb25seSBtYWtl
IHNlbnNlIGFzIHN0cmFpZ2h0IGFycmF5IGZvcm1hdHMuCgpJbiBteSBib29rIGxpdHRsZSBlbmRp
YW4ganVzdCBtZWFucyAibHNiIGlzIHN0b3JlZCBpbiB0aGUgbG93ZXN0Cm1lbW9yeSBhZGRyZXNz
Ii4gVGhlIGZhY3QgdGhhdCB5b3VyIENQVS9HUFUgY2FuJ3QgZG8gMyBieXRlIHN3YXBzCmlzIG5v
dCByZWxldmFudCBmb3IgdGhhdCBkZWZpbml0aW9uIElNTy4KCi0tIApWaWxsZSBTeXJqw6Rsw6QK
SW50ZWwgT1RDCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
