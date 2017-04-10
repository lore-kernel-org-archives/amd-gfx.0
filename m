From: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RfC PATCH] drm: fourcc byteorder: brings header file comments
 in line with reality.
Date: Mon, 10 Apr 2017 16:17:27 +0200
Message-ID: <1491833847.30990.77.camel@redhat.com>
References: <20170410101202.19229-1-kraxel@redhat.com>
 <20170410161214.305f5daf@eldfell>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170410161214.305f5daf@eldfell>
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
Cc: Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

ICBIaSwKCj4gd2hpY2ggc29mdHdhcmUgaGF2ZSB5b3UgdXNlZCBhcyByZXByZXNlbnRhdGl2ZSBv
ZiAicmVhbGl0eSI/CgpwcGM2NCAoYmlnIGVuZGlhbikgdmlydHVhbCBtYWNoaW5lLCBydW5uaW5n
IHdpdGggcWVtdSBzdGR2Z2EgJiBib2Nocy1kcm0KZHJpdmVyLiAgWG9yZyB3aXRoIG1vZGVzZXR0
aW5nIGRyaXZlciB1c2VzIERSTV9GT1JNQVRfWFJHQjg4ODggKG9uZSBhbmQKb25seSBmb3JtYXQg
c3VwcG9ydGVkIGJ5IGJvY2hzLWRybSksIGFuZCB3ZSBoYXZlIHRvIGludGVycHJldCB0aGF0IGlu
CmJpZ2VuZGlhbiBieXRlIG9yZGVyIG9uIHRoZSBob3N0IHNpZGUgdG8gZ2V0IGEgY29ycmVjdCBk
aXNwbGF5LgoKRGlkbid0IHRyeSB3YXlsYW5kLiAgQ2FuIGRvLCBidXQgd2lsbCB0YWtlIGEgd2hp
bGUuICBEb24ndCBoYXZlIGEKd2F5bGFuZC1jYXBhYmxlIGd1ZXN0IGluc3RhbGwgYXQgaGFuZCwg
YW5kIGluc3RhbGxpbmcgb25lIHRha2VzIGEgd2hpbGUKYmVjYXVzZSBJIGRvbid0IGhhdmUgYSBw
aHlzaWNhbCBwc2VyaWVzIGFuZCBlbXVsYXRpb24gaXMgc2xvb29vd3cuCgo+IFRvIHNvbHZlIHRo
YXQgcHJvYmxlbSwgd2Ugd291bGQgbGlrZSB0byBrbm93IGlmIGFueXRoaW5nIGV4aXN0aW5nIHdv
dWxkCj4gYnJlYWsgZm9yIGVhY2ggcG9zc2libGUgc29sdXRpb24sIGJ1dCBubyBkZXZlbG9wZXJz
IHVzaW5nIEJFIGhhdmUgcmVhbGx5Cj4gdHVybmVkIHVwLgoKVGhhdCBpcyBwYXJ0IG9mIHRoZSBw
cm9ibGVtLgpBbmQgZXZlbiBwcGMgaXMgbW92aW5nIHRvIGxpdHRsZSBlbmRpYW4gdGhlc2UgZGF5
cyAuLi4KCmNoZWVycywKICBHZXJkCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
