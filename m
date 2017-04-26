From: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/6] drm: fourcc byteorder: add bigendian support to
 drm_mode_legacy_fb_format
Date: Wed, 26 Apr 2017 07:53:10 +0200
Message-ID: <1493185990.23739.7.camel@redhat.com>
References: <20170424062532.26722-1-kraxel@redhat.com>
 <20170424062532.26722-4-kraxel@redhat.com>
 <3b872a56-80b5-0c44-712f-a9517489eb24@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3b872a56-80b5-0c44-712f-a9517489eb24-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gRGksIDIwMTctMDQtMjUgYXQgMTI6MTggKzA5MDAsIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+
IE9uIDI0LzA0LzE3IDAzOjI1IFBNLCBHZXJkIEhvZmZtYW5uIHdyb3RlOgo+ID4gUmV0dXJuIGNv
cnJlY3QgZm91cmNjIGNvZGVzIG9uIGJpZ2VuZGlhbi4gIERyaXZlcnMgbXVzdCBiZSBhZGFwdGVk
IHRvCj4gPiB0aGlzIGNoYW5nZS4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogR2VyZCBIb2ZmbWFu
biA8a3JheGVsQHJlZGhhdC5jb20+Cj4gCj4gSnVzdCB0byByZWl0ZXJhdGUsIHRoaXMgd29uJ3Qg
d29yayBmb3IgdGhlIHJhZGVvbiBkcml2ZXIsIHdoaWNoIHByb2dyYW1zCj4gdGhlIEdQVSB0byB1
c2UgKGVmZmVjdGl2ZWx5LCBwZXIgdGhlIGN1cnJlbnQgZGVmaW5pdGlvbiB0aGF0IHRoZXNlIGFy
ZQo+IGxpdHRsZSBlbmRpYW4gR1BVIGZvcm1hdHMpIERSTV9GT1JNQVRfWFJHQjg4ODggd2l0aCBw
cmUtUjYwMCBhbmQKPiBEUk1fRk9STUFUX0JHUlg4ODg4IHdpdGggPj0gUjYwMC4KCkhtbSwgb2ss
IGhvdyBkb2VzIGJpZ2VuZGlhbiBmYmRldiBlbXVsYXRpb24gd29yayBvbiBwcmUtUjYwMCB0aGVu
PwoKPiA+ICsjaWZkZWYgX19CSUdfRU5ESUFOCj4gPiArCXN3aXRjaCAoYnBwKSB7Cj4gPiArCWNh
c2UgODoKPiA+ICsJCWZtdCA9IERSTV9GT1JNQVRfQzg7Cj4gPiArCQlicmVhazsKPiA+ICsJY2Fz
ZSAyNDoKPiA+ICsJCWZtdCA9IERSTV9GT1JNQVRfQkdSODg4Owo+ID4gKwkJYnJlYWs7Cj4gCj4g
QlRXLCBlbmRpYW5uZXNzIGFzIGEgY29uY2VwdCBjYW5ub3QgYXBwbHkgdG8gOCBvciAyNCBicHAg
Zm9ybWF0cy4KCkkgY291bGQgbW92ZSB0aGUgOCBicHAgY2FzZSBvdXQgb2YgdGhlICNpZmRlZiBz
b21laG93LCBidXQgY29kZQpyZWFkYWJpbGl0eSB3aWxsIHN1ZmZlciB0aGVuIEkgdGhpbmsgLi4u
CgpGb3IgMjQgd2UgaGF2ZSBkaWZmZXJlbnQgYnl0ZSBvcmRlcmluZ3MsIGJ1dCB5ZXMsIHlvdSBj
YW4ndCBzd2l0Y2ggZnJvbQpvbmUgdG8gdGhlIG90aGVyIHdpdGggYnl0ZXN3YXBwaW5nLiAgUHJv
YmFibHkgb25lIG9mIHRoZSByZWFzb25zIHdoeQp0aGlzIGZvcm1hdCBpcyBwcmV0dHkgbXVjaCBv
dXQgb2YgZmFzaGlvbiB0aGVzZSBkYXlzIC4uLgoKY2hlZXJzLAogIEdlcmQKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
