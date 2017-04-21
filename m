From: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] drm: fourcc byteorder: brings header file comments in
 line with reality.
Date: Fri, 21 Apr 2017 18:14:31 +0200
Message-ID: <1492791271.25675.57.camel@redhat.com>
References: <20170421075825.6307-1-kraxel@redhat.com>
 <20170421092530.GE30290@intel.com> <1492768218.25675.33.camel@redhat.com>
 <20170421110804.GH30290@intel.com>
 <f1b0ae60-b20e-ad52-7fbf-32f2c045f5fc@amd.com>
 <1492780323.25675.45.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1492780323.25675.45.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Michel =?ISO-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

ICBIaSwKCj4gPiBNeSBwZXJzb25hbCBvcGluaW9uIGlzIHRoYXQgZm9ybWF0cyBpbiBkcm1fZm91
cmNjLmggc2hvdWxkIGJlIAo+ID4gaW5kZXBlbmRlbnQgb2YgdGhlIENQVSBieXRlIG9yZGVyIGFu
ZCB0aGUgZnVuY3Rpb24gCj4gPiBkcm1fbW9kZV9sZWdhY3lfZmJfZm9ybWF0KCkgYW5kIGRyaXZl
cnMgZGVwZW5kaW5nIG9uIHRoYXQgaW5jb3JyZWN0IAo+ID4gYXNzdW1wdGlvbiBiZSBmaXhlZCBp
bnN0ZWFkLgo+IAo+IFRoZSBwcm9ibGVtIGlzIHRoaXMgaXNuJ3QgYSBrZXJuZWwtaW50ZXJuYWwg
dGhpbmcgYW55IG1vcmUuICBXaXRoIHRoZQo+IGFkZGl0aW9uIG9mIHRoZSBBRERGQjIgaW9jdGwg
dGhlIGZvdXJjYyBjb2RlcyBiZWNhbWUgcGFydCBvZiB0aGUKPiBrZXJuZWwvdXNlcnNwYWNlIGFi
aSAuLi4KCk9rLCBhZGRlZCBzb21lIHByaW50aydzIHRvIHRoZSBBRERGQiBhbmQgQURERkIyIGNv
ZGUgcGF0aHMgYW5kIHRlc3RlZCBhCmJpdC4gIEFwcGFyZW50bHkgcHJldHR5IG11Y2ggYWxsIHVz
ZXJzcGFjZSBzdGlsbCB1c2VzIHRoZSBBRERGQiBpb2N0bC4KeG9yZyAobW9kZXNldHRpbmcgZHJp
dmVyKSBkb2VzLiAgZ25vbWUtc2hlbGwgaW4gd2F5bGFuZCBtb2RlIGRvZXMuClNlZW1zIHRoZSBi
aWcgdHJhbnNpdGlvbiB0byBBRERGQjIgZGlkbid0IGhhcHBlbiB5ZXQuCgpJIGd1ZXNzIHRoYXQg
bWFrZXMgY2hhbmdpbmcgZHJtX21vZGVfbGVnYWN5X2ZiX2Zvcm1hdCArIGRyaXZlcnMgYQpyZWFz
b25hYmxlIG9wdGlvbiAuLi4KCmNoZWVycywKICBHZXJkCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
