From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: increase the size of HQD EOP buffers
Date: Thu, 18 Oct 2018 15:57:50 -0400
Message-ID: <CADnq5_N1DvJfEaCh_xJzjZF=uSnHDBq7k9prT2Smw+hkves74w@mail.gmail.com>
References: <20181005210144.13999-1-maraeo@gmail.com>
 <20181005210144.13999-2-maraeo@gmail.com>
 <CADnq5_M-uz+ABbZpm1-SFS26f1Q8T-w00FwXiMxj9HeAx8PhQw@mail.gmail.com>
 <CAAxE2A7Jv_FJ5_YPpn7O1g2LhMkOiSPh9nvuih3FRfdXfAvp=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A7Jv_FJ5_YPpn7O1g2LhMkOiSPh9nvuih3FRfdXfAvp=A@mail.gmail.com>
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
To: Marek Olsak <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVGh1LCBPY3QgMTgsIDIwMTggYXQgMzo0NyBQTSBNYXJlayBPbMWhw6FrIDxtYXJhZW9AZ21h
aWwuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgT2N0IDksIDIwMTggYXQgMTI6MTcgUE0gQWxleCBE
ZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+Pgo+PiBPbiBGcmksIE9jdCA1
LCAyMDE4IGF0IDU6MDEgUE0gTWFyZWsgT2zFocOhayA8bWFyYWVvQGdtYWlsLmNvbT4gd3JvdGU6
Cj4+ID4KPj4gPiBGcm9tOiBNYXJlayBPbMWhw6FrIDxtYXJlay5vbHNha0BhbWQuY29tPgo+PiA+
Cj4+ID4gU2lnbmVkLW9mZi1ieTogTWFyZWsgT2zFocOhayA8bWFyZWsub2xzYWtAYW1kLmNvbT4K
Pj4gPiAtLS0KPj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYyB8IDIg
Ky0KPj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyB8IDIgKy0KPj4K
Pj4gQW55IHJlYXNvbiBub3QgdG8gYnVtcCB0aGUgc2l6ZSBmb3IgZ2Z4NyBhcyB3ZWxsPwo+Cj4K
PiBObywgSSBqdXN0IGRvbid0IGtub3cgaWYgZ2Z4NyBzdXBwb3J0cyB0aGUgc2FtZSBzaXplLgoK
TG9va3MgbGlrZSBpdCBkb2VzIG5vdC4gIGdmeDcgaXMgMl4xMSwgZ2Z4OCBpcyAyXjEyLiAgU2Vy
aWVzIGlzOgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
