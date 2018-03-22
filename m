From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/23] drm: Eliminate plane->fb/crtc usage for atomic
 drivers
Date: Thu, 22 Mar 2018 18:34:19 +0000
Message-ID: <CACvgo52O9ALUm8MqM69SDaUF_spw2nkJ0tr8UCJnB9t4GbkVFw@mail.gmail.com>
References: <20180322152313.6561-1-ville.syrjala@linux.intel.com>
 <CACvgo53B4zLLUqw9y18skpjacmjt-iAYBcG19HkmE=jFwcb4+w@mail.gmail.com>
 <a0d3ec32-be68-c96e-607c-0af4a97a3dd6@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a0d3ec32-be68-c96e-607c-0af4a97a3dd6-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Seung-Woo Kim <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "open list:VIRTIO GPU DRIVER" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Vincent Abriou <vincent.abriou-qxv4g6HH51o@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, VMware Graphics <linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, ML dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Ville Syrjala <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

T24gMjIgTWFyY2ggMjAxOCBhdCAxODowMywgSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5k
QGFtZC5jb20+IHdyb3RlOgo+IE9uIDIwMTgtMDMtMjIgMDE6NTQgUE0sIEVtaWwgVmVsaWtvdiB3
cm90ZToKPj4gSGkgVmlsbGUsCj4+Cj4+IE9uIDIyIE1hcmNoIDIwMTggYXQgMTU6MjIsIFZpbGxl
IFN5cmphbGEgPHZpbGxlLnN5cmphbGFAbGludXguaW50ZWwuY29tPiB3cm90ZToKPj4+IEZyb206
IFZpbGxlIFN5cmrDpGzDpCA8dmlsbGUuc3lyamFsYUBsaW51eC5pbnRlbC5jb20+Cj4+Pgo+Pj4g
SSByZWFsbHkganVzdCB3YW50ZWQgdG8gZml4IGk5MTUgdG8gcmUtZW5hYmxlIGl0cyBwbGFuZXMg
YWZlciBsb2FkCj4+PiBkZXRlY3Rpb24gKGEgdHdvIGxpbmUgcGF0Y2gpLiBUaGlzIGlzIHdoYXQg
SSBhY3R1YWxseSBlbmRlZCB1cCB3aXRoCj4+PiBhZnRlciBJIHJhbiBpbnRvIGEgZnJhbWVidWZm
ZXIgcmVmY291bnQgbGVhayB3aXRoIHNhaWQgdHdvIGxpbmUgcGF0Y2guCj4+Pgo+Pj4gSSd2ZSB0
ZXN0ZWQgdGhpcyBvbiBhIGZldyBpOTE1IGJveGVzIGFuZCBzbyBmYXIgaXQncyBsb29raW5nCj4+
PiBnb29kLiBFdmVyeXRoaW5nIGVsc2UgaXMganVzdCBjb21waWxlIHRlc3RlZC4KPj4+Cj4+IE1v
c3RseSB0aGlua2luZyBvdXQgbG91ZDoKPj4KPj4gV29uZGVyaW5nIGlmIG9uZSBjYW5ub3Qgc29t
ZWhvdyAocmUpbW92ZSBwbGFuZS0+ZmIvY3J0YyBhbHRvZ2V0aGVyLgo+PiBPdGhlcndpc2UgZHJp
dmVycyB3aWxsIHJlaW50cm9kdWNlIHNpbWlsYXIgY29kZSwgZGVzcGl0ZSB0aGUgV0FSTnMgYW5k
Cj4+IGJlZWZ5IGRvY3VtZW50YXRpb24gOi1cCj4KPiBXb3VsZG4ndCB0aGF0IHJlcXVpcmUgYW4g
YXRvbWljIGNvbnZlcnNpb24gb2YgYWxsIHJlbWFpbmluZyBkcml2ZXJzPwo+ClRoYXQgb3IgbWF5
YmUgbW92ZSBpbnRvIHBsYW5lLT5sZWdhY3ktPntmYixjcnRjfS4gRmVlbCBmcmVlIHRvIHN3YXAK
J2xlZ2FjeScgd2l0aCBmbGFzaGllciBuYW1lLgoKSG1tIGJhY2sgaW4gMjAxNSB3ZSBoYWQgYSBH
U29DIHRoYXQgdXBkYXRlZCBCT0NIUyBhbmQgQ0lSUlVTIGRyaXZlcnMsCmJ1dCB0aGV5IG5ldmVy
IGdvdCBtZXJnZWQuCkRvbid0IHJlY2FsbCB0aGUgZGV0YWlscyAtIGZyb20gbWVtb3J5IHRoZSBj
b252ZXJzaW9uIHNlZW1lZCBmaW5lLCBidXQKdGhlcmUgd2FzIGVpdGhlciBzaG9ydGFnZSBvbiBy
ZXZpZXcvb3RoZXIuCgpNaWdodCBiZSB3b3J0aCByZXZpdmluZyB0aGF0Li4uIHJlZ2FyZGxlc3Mg
aXQncyBnZXR0aW5nIGEgYml0IG9mZi10b3BpYy4KLUVtaWwKClsxXSBodHRwczovL3d3dy5nb29n
bGUtbWVsYW5nZS5jb20vYXJjaGl2ZS9nc29jLzIwMTUvb3Jncy94b3JnL3Byb2plY3RzL2pvaG5o
dW50ZXIuaHRtbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
