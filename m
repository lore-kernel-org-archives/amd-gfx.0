From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/6] drm: fourcc byteorder: add bigendian support to
 drm_mode_legacy_fb_format
Date: Wed, 26 Apr 2017 11:00:09 +0900
Message-ID: <b306654e-ae14-99f5-d129-8fc1fb8cc05d@daenzer.net>
References: <20170424062532.26722-1-kraxel@redhat.com>
 <20170424062532.26722-4-kraxel@redhat.com>
 <3b872a56-80b5-0c44-712f-a9517489eb24@daenzer.net>
 <20170425095259.GK30290@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170425095259.GK30290-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

T24gMjUvMDQvMTcgMDY6NTIgUE0sIFZpbGxlIFN5cmrDpGzDpCB3cm90ZToKPiBPbiBUdWUsIEFw
ciAyNSwgMjAxNyBhdCAxMjoxODo1MlBNICswOTAwLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPj4g
T24gMjQvMDQvMTcgMDM6MjUgUE0sIEdlcmQgSG9mZm1hbm4gd3JvdGU6Cj4+PiArI2lmZGVmIF9f
QklHX0VORElBTgo+Pj4gKwlzd2l0Y2ggKGJwcCkgewo+Pj4gKwljYXNlIDg6Cj4+PiArCQlmbXQg
PSBEUk1fRk9STUFUX0M4Owo+Pj4gKwkJYnJlYWs7Cj4+PiArCWNhc2UgMjQ6Cj4+PiArCQlmbXQg
PSBEUk1fRk9STUFUX0JHUjg4ODsKPj4+ICsJCWJyZWFrOwo+Pgo+PiBCVFcsIGVuZGlhbm5lc3Mg
YXMgYSBjb25jZXB0IGNhbm5vdCBhcHBseSB0byA4IG9yIDI0IGJwcCBmb3JtYXRzLgo+IAo+IFRv
IDhicHAgbm8sIGJ1dCBpdCBjYW4gZWFzaWx5IGFwcGx5IHRvIDI0YnBwLgoKQW55IGJ5dGUgc3dh
cHBpbmcgcmlwcyBhcGFydCB0aGUgYnl0ZXMgb2YgYSAyNGJwcCBwaXhlbCwgc28gdGhvc2UKZm9y
bWF0cyBvbmx5IG1ha2Ugc2Vuc2UgYXMgc3RyYWlnaHQgYXJyYXkgZm9ybWF0cy4KCgotLSAKRWFy
dGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6
Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
