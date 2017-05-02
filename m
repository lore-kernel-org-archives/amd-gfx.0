From: Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] drm: fourcc byteorder: drop DRM_FORMAT_BIG_ENDIAN
Date: Tue, 02 May 2017 16:14:24 +0200
Message-ID: <1493734464.8581.105.camel@redhat.com>
References: <20170502133404.15354-1-kraxel@redhat.com>
 <20170502133404.15354-2-kraxel@redhat.com>
 <CACvgo52FeXVixjmRpv3xO=kRFTbmBu5vmyzAs=VF_v+nLAO=ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo52FeXVixjmRpv3xO=kRFTbmBu5vmyzAs=VF_v+nLAO=ag-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Michel =?ISO-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Pekka Paalanen <ppaalanen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sean Paul <seanpaul-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

PiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvZHJtL2RybV9mb3VyY2MuaCBiL2luY2x1ZGUv
dWFwaS9kcm0vZHJtX2ZvdXJjYy5oCj4gPiBpbmRleCA5OTVjOGY5YzY5Li4zMDViYzM0YmUwIDEw
MDY0NAo+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2RybS9kcm1fZm91cmNjLmgKPiA+ICsrKyBiL2lu
Y2x1ZGUvdWFwaS9kcm0vZHJtX2ZvdXJjYy5oCj4gPiBAQCAtMzMsOCArMzMsNiBAQCBleHRlcm4g
IkMiIHsKPiA+ICAjZGVmaW5lIGZvdXJjY19jb2RlKGEsIGIsIGMsIGQpICgoX191MzIpKGEpIHwg
KChfX3UzMikoYikgPDwgOCkgfCBcCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAoKF9fdTMyKShjKSA8PCAxNikgfCAoKF9fdTMyKShkKSA8PCAyNCkpCj4gPgo+ID4gLSNkZWZp
bmUgRFJNX0ZPUk1BVF9CSUdfRU5ESUFOICgxPDwzMSkgLyogZm9ybWF0IGlzIGJpZyBlbmRpYW4g
aW5zdGVhZCBvZiBsaXR0bGUgZW5kaWFuICovCj4gPiAtCj4gCj4gV2VzdG9uIHJlZmVyZW5jZXMg
RFJNX0ZPUk1BVF9CSUdfRU5ESUFOIHRodXMgdGhpcyBwYXRjaCB3aWxsIGxlYWQgdG8KPiBidWls
ZCBicmVha2FnZS4KCj4gUGVyc29uYWxseSBJIHdvdWxkIGxlYXZlIHRoZSBzeW1ib2wsIHNpbmNl
IGl0J3MgVUFQSSBhbmQgZG9jdW1lbnQgdGhhdAo+IHNob3VsZCBub3QgYmUgdXNlZC4KCkZhaXIg
ZW5vdWdoLiAgSSBjYW4gc3VyZWx5IGFkZCBhIGRlcHJlY2F0ZWQgY29tbWVudCBpbnN0ZWFkIG9m
IGp1c3QKZHJvcHBpbmcgaXQuCgpJJ20gd29uZGVyaW5nIGhvdyBpdCBpcyB1c2VkIHRob3VnaCwg
Z2l2ZW4gdGhhdCBub25lIG9mIHRoZSBkcml2ZXJzIGluCnRoZSBrZXJuZWwgYWN0dWFsbHkgIHN1
cHBvcnQgdGhpcyBmbGFnIC4uLgoKY2hlZXJzLAogIEdlcmQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
