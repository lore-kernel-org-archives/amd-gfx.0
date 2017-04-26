From: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/6] drm: fourcc byteorder: add bigendian support to
 drm_mode_legacy_fb_format
Date: Wed, 26 Apr 2017 15:57:42 +0200
Message-ID: <1493215062.23739.34.camel@redhat.com>
References: <20170424062532.26722-1-kraxel@redhat.com>
 <20170424062532.26722-4-kraxel@redhat.com>
 <3b872a56-80b5-0c44-712f-a9517489eb24@daenzer.net>
 <1493185990.23739.7.camel@redhat.com>
 <20170426132801.lldz7uwwlp3euozy@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170426132801.lldz7uwwlp3euozy-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
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
To: Eric Engestrom <eric.engestrom-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Michel =?ISO-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

PiAJdWludDMyX3QgZHJtX21vZGVfbGVnYWN5X2ZiX2Zvcm1hdCh1aW50MzJfdCBicHAsIHVpbnQz
Ml90IGRlcHRoKQo+IAl7Cj4gCQl1aW50MzJfdCBmbXQ7Cj4gCSNpZmRlZiBfX0JJR19FTkRJQU4K
PiAJCWVudW0geyBMSVRUTEVfRU5ESUFOID0gMCB9Owo+IAkjZWxzZQo+IAkJZW51bSB7IExJVFRM
RV9FTkRJQU4gPSAxIH07Cj4gCSNlbmRpZgo+IAkvKiAuLi4gKi8KPiAKPiAodXNpbmcgYW4gZW51
bSBmb3IgY29tcGlsZS10aW1lIGNvbnN0bmVzcykKPiAKPiBhbmQgdGhlbgo+IAlmbXQgPSBEUk1f
Rk9STUFUX0FSR0I4ODg4Owo+IGJlY29tZXMKPiAJZm10ID0gTElUVExFX0VORElBTiA/IERSTV9G
T1JNQVRfQVJHQjg4ODggOiBEUk1fRk9STUFUX0JHUkE4ODg4Owo+IAo+IE1pZ2h0IGJlIGVhc2ll
ciB0byByZWFkIHRoYW4gZHVwbGljYXRpbmcgdGhlIHdob2xlIHN3aXRjaD8KCldlbGwsIHRoZXJl
IGFyZSBtb3JlIGRpZmZlcmVuY2VzLCBsaWtlIHJnYjU2NSBhbmQgeHJnYjIxMDEwMTAgbm90IGJl
aW5nCnN1cHBvcnRlZCBmb3IgYmlnZW5kaWFuLCBzbyBpdCBpc24ndCAqdGhhdCogc2ltcGxlLgoK
Y2hlZXJzLAogIEdlcmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
