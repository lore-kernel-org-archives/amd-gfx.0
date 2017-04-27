From: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/6] drm: fourcc byteorder: add bigendian support to
 drm_mode_legacy_fb_format
Date: Thu, 27 Apr 2017 08:45:50 +0200
Message-ID: <1493275550.31995.31.camel@redhat.com>
References: <20170424062532.26722-1-kraxel@redhat.com>
 <20170424062532.26722-4-kraxel@redhat.com>
 <3b872a56-80b5-0c44-712f-a9517489eb24@daenzer.net>
 <1493185990.23739.7.camel@redhat.com>
 <8f91cc58-16dc-5899-66b6-06d430a18801@daenzer.net>
 <1493208671.23739.19.camel@redhat.com>
 <6bd62182-0de5-a8a7-78c3-029fc73ecc91@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <6bd62182-0de5-a8a7-78c3-029fc73ecc91-otUistvHUpPR7s880joybQ@public.gmane.org>
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

ICBIaSwKCj4gPiBUaGF0IGlzIGRvbmUgdXNpbmcgdGhlIFJBREVPTl9USUxJTkdfU1dBUF97MTYs
MzJ9QklUIGZsYWcgbWVudGlvbmVkIGluCj4gPiBhbm90aGVyIHRocmVhZD8KPiAKPiBSaWdodC4K
PiAKPiAKPiA+IFdoYXQgYWJvdXQgZHVtYiBib3M/ICBZb3UndmUgbWVudGlvbmVkIHRoZSBzd2Fw
IGZsYWcgaXNuJ3QgdXNlZCBmb3IKPiA+IHRob3NlLiAgV2hpY2ggaW1wbGllcyB0aGV5IGFyZSBp
biBsaXR0bGUgZW5kaWFuIGJ5dGUgb3JkZXIgKGJvdGggZ3B1IGFuZAo+ID4gY3B1IHZpZXcpLgo+
IAo+IFJpZ2h0LCBBRkFJQ1QgZnJvbSBsb29raW5nIGF0IHRoZSBjb2RlLgoKT2suCgpBbmQgSSBh
bHNvIGRvbid0IHNlZSBhbiBlYXN5IHdheSB0byBtYWtlIHRoZW0gYmlnIGVuZGlhbiAoY3B1IHZp
ZXcpCnVzaW5nIHN3YXBwaW5nIHdpdGggdGhlIGV4aXN0aW5nIGRybSBpbnRlcmZhY2VzLCBnaXZl
biB3ZSBhcHBseSBhIGZvcm1hdAp3aGVuIHdlIHB1dCB0aGUgYm8gaW50byB1c2UgYXMgZnJhbWVi
dWZmZXIsIG5vdCB3aGVuIGNyZWF0aW5nIGl0LiAgU28KdXNlcnNwYWNlIGNhbjogKDEpIGNyZWF0
ZSBkdW1iIGJvLCAoMikgbWFwIGJvLCAoMykgd3JpdGUgc29tZXRoaW5nIGJvLAooNCkgY3JlYXRl
IGZiICsgYXR0YWNoIHRvIGNydGMuICBBbmQgYXQgKDMpIHdlIGRvbid0IGtub3cgdGhlIGZvcm1h
dAp5ZXQsIHNvIHdlIGNhbid0IGNvbmZpZ3VyZSBzd2FwcGluZyBhY2NvcmRpbmdseS4KClNvIGp1
c3Qgbm90IHVzaW5nIHRoZSBzd2FwcGluZyBpbmRlZWQgbG9va3MgbGlrZSB0aGUgb25seSBzZW5z
aWJsZQpvcHRpb24uICBXaGljaCBpbiB0dXJuIGltcGxpZXMgdGhlcmUgaXMgbm8gQkdSQTg4ODgg
c3VwcG9ydCBmb3IgZHVtYgpib3MuICBIbW0sIEkgY2FuIHNlZSB0aGUgcHJvYmxlbS4gIFVzZXJz
cGFjZSBleHBlY3RhdGlvbiBhcHBlYXJzIHRvIGJlCnRoYXQgQURERkIgY29uZmlndXJlcyBhIG5h
dGl2ZSBlbmRpYW4gZnJhbWVidWZmZXIsIHdoaWNoIHRoZSBkcml2ZXIKc2ltcGx5IGNhbid0IGRv
IG9uIGJpZ2VuZGlhbi4KClNvLCB3aGF0IGNhbi9zaG91bGQgdGhlIGRyaXZlciBkbyBoZXJlPyAg
VGhyb3cgZXJyb3JzIGZvciBBRERGQiBhbmQKZm9yY2UgdXNlcnNwYWNlIHRvIHVzZSBBRERGQjI/
ICBGcm9tIGEgZGVzaWduIHBvaW50IG9mIHZpZXcgdGhlIGJlc3QKb3B0aW9uLCBidXQgaW4gdGhl
IG90aGVyIGhhbmQgSSBzdXNwZWN0IHRoYXQgY291bGQgYnJlYWsgdGhlIHhvcmcgcmFkZW9uCmRy
aXZlciAuLi4KCmNoZWVycywKICBHZXJkCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
