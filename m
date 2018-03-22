From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 00/23] drm: Eliminate plane->fb/crtc usage for atomic
 drivers
Date: Thu, 22 Mar 2018 14:03:25 -0400
Message-ID: <a0d3ec32-be68-c96e-607c-0af4a97a3dd6@amd.com>
References: <20180322152313.6561-1-ville.syrjala@linux.intel.com>
 <CACvgo53B4zLLUqw9y18skpjacmjt-iAYBcG19HkmE=jFwcb4+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CACvgo53B4zLLUqw9y18skpjacmjt-iAYBcG19HkmE=jFwcb4+w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
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
To: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ville Syrjala <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Seung-Woo Kim <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "open list:VIRTIO GPU DRIVER" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Vincent Abriou <vincent.abriou-qxv4g6HH51o@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, VMware Graphics <linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

T24gMjAxOC0wMy0yMiAwMTo1NCBQTSwgRW1pbCBWZWxpa292IHdyb3RlOgo+IEhpIFZpbGxlLAo+
IAo+IE9uIDIyIE1hcmNoIDIwMTggYXQgMTU6MjIsIFZpbGxlIFN5cmphbGEgPHZpbGxlLnN5cmph
bGFAbGludXguaW50ZWwuY29tPiB3cm90ZToKPj4gRnJvbTogVmlsbGUgU3lyasOkbMOkIDx2aWxs
ZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4KPj4KPj4gSSByZWFsbHkganVzdCB3YW50ZWQgdG8g
Zml4IGk5MTUgdG8gcmUtZW5hYmxlIGl0cyBwbGFuZXMgYWZlciBsb2FkCj4+IGRldGVjdGlvbiAo
YSB0d28gbGluZSBwYXRjaCkuIFRoaXMgaXMgd2hhdCBJIGFjdHVhbGx5IGVuZGVkIHVwIHdpdGgK
Pj4gYWZ0ZXIgSSByYW4gaW50byBhIGZyYW1lYnVmZmVyIHJlZmNvdW50IGxlYWsgd2l0aCBzYWlk
IHR3byBsaW5lIHBhdGNoLgo+Pgo+PiBJJ3ZlIHRlc3RlZCB0aGlzIG9uIGEgZmV3IGk5MTUgYm94
ZXMgYW5kIHNvIGZhciBpdCdzIGxvb2tpbmcKPj4gZ29vZC4gRXZlcnl0aGluZyBlbHNlIGlzIGp1
c3QgY29tcGlsZSB0ZXN0ZWQuCj4+Cj4gTW9zdGx5IHRoaW5raW5nIG91dCBsb3VkOgo+IAo+IFdv
bmRlcmluZyBpZiBvbmUgY2Fubm90IHNvbWVob3cgKHJlKW1vdmUgcGxhbmUtPmZiL2NydGMgYWx0
b2dldGhlci4KPiBPdGhlcndpc2UgZHJpdmVycyB3aWxsIHJlaW50cm9kdWNlIHNpbWlsYXIgY29k
ZSwgZGVzcGl0ZSB0aGUgV0FSTnMgYW5kCj4gYmVlZnkgZG9jdW1lbnRhdGlvbiA6LVwKCldvdWxk
bid0IHRoYXQgcmVxdWlyZSBhbiBhdG9taWMgY29udmVyc2lvbiBvZiBhbGwgcmVtYWluaW5nIGRy
aXZlcnM/CgpIYXJyeQoKPiAKPiBIVEgKPiBFbWlsCj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
