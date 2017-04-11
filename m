From: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RfC PATCH] drm: fourcc byteorder: brings header file comments
 in line with reality.
Date: Tue, 11 Apr 2017 13:23:53 +0200
Message-ID: <1491909833.30990.93.camel@redhat.com>
References: <20170410101202.19229-1-kraxel@redhat.com>
 <20170410161214.305f5daf@eldfell> <1491833847.30990.77.camel@redhat.com>
 <20170410180941.43922e25@eldfell>
 <CAKb7UvhbgSGwx-2EsrQrHmghzYqO9AhRQ10bDWKfdcXHc3fJeQ@mail.gmail.com>
 <20170411103101.0497fe08@eldfell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170411103101.0497fe08@eldfell>
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
To: Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

ICBIaSwKCj4gPiBKdXN0IGxldCBrbm93IHdoYXQgeW91IG5lZWQgdGVzdGVkLCBJIHNob3VsZCBi
ZSBhYmxlIHRvIHR1cm4gaXQgYXJvdW5kCj4gPiB3aXRoaW4gYSBjb3VwbGUgb2YgZGF5cy4KPiAK
PiBUaGF0J3MgcGFydCBvZiBteSBwcm9ibGVtLiBJIGRvbid0IHJlYWxseSBrbm93IHdoYXQgc2hv
dWxkIGJlIHRlc3RlZC4KPiBXaGF0IGRvIHBlb3BsZSBkbyB3aXRoIHRoZWlyIEJFIG1hY2hpbmVz
IHRoYXQgd2Ugc2hvdWxkIGF2b2lkIGJyZWFraW5nPwoKRm9yIHRoZSB2aXJ0dWFsIG1hY2hpbmUg
dXNlIGNhc2UgdGhlIGJhciBpcyBwcmV0dHkgbG93LCBpdCdzIG1vc3RseQphYm91dCBhIGdyYXBo
aWNhbCBzZXJ2ZXIgY29uc29sZS4gIEFuYWNvbmRhIGluc3RhbGxlci4gIEdub21lIGRlc2t0b3AK
d2l0aCBicm93c2VyIGFuZCBzdGFuZGFyZCB4b3JnICh4dGVybSkgKyBndGsgYXBwcy4gIE5vIGhl
YXZ5IE9wZW5HTApzdHVmZi4gIE5vIGhhcmR3YXJlIGFjY2VsZXJhdGlvbiwgc28gaWYgb3Blbmds
IGlzIHVzZWQgdGhlbiBpdCdsbCBiZQpsbHZtcGlwZS4KClJpZ2h0IG5vdyBYb3JnIGlzIGltcG9y
dGFudC4gIE5vdCBzdXJlIHdoZW5ldmVyIHdheWxhbmQgZXZlciB3aWxsIGJlLApwb3NzaWJseSB0
aGUgcHBjNjQgLT4gcHBjNjRsZSBzd2l0Y2ggZ29lcyBmYXN0ZXIgdGhhbiB0aGUgeG9yZyAtPgp3
YXlsYW5kIHN3aXRjaC4KCmNoZWVycywKICBHZXJkCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
