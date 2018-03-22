From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 00/23] drm: Eliminate plane->fb/crtc usage for atomic
 drivers
Date: Thu, 22 Mar 2018 20:49:12 +0200
Message-ID: <20180322184912.GM5453@intel.com>
References: <20180322152313.6561-1-ville.syrjala@linux.intel.com>
 <b92fe986-295c-fecb-dca1-82cb9bf7b7b1@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b92fe986-295c-fecb-dca1-82cb9bf7b7b1-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
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
To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Seung-Woo Kim <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, VMware Graphics <linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Vincent Abriou <vincent.abriou-qxv4g6HH51o@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gVGh1LCBNYXIgMjIsIDIwMTggYXQgMDU6NTE6MzVQTSArMDEwMCwgTm9yYWxmIFRyw7hubmVz
IHdyb3RlOgo+IHRpbnlkcm0gaXMgYWxzbyB1c2luZyBwbGFuZS0+ZmI6Cj4gCj4gJCBncmVwIC1y
ICJwbGFuZVwuZmIiIGRyaXZlcnMvZ3B1L2RybS90aW55ZHJtLwo+IGRyaXZlcnMvZ3B1L2RybS90
aW55ZHJtL3JlcGFwZXIuYzrCoMKgwqDCoMKgIGlmICh0ZGV2LT5waXBlLnBsYW5lLmZiICE9IGZi
KQo+IGRyaXZlcnMvZ3B1L2RybS90aW55ZHJtL21pcGktZGJpLmM6wqDCoMKgwqAgaWYgKHRkZXYt
PnBpcGUucGxhbmUuZmIgIT0gZmIpCj4gZHJpdmVycy9ncHUvZHJtL3Rpbnlkcm0vbWlwaS1kYmku
YzrCoMKgwqDCoCBzdHJ1Y3QgZHJtX2ZyYW1lYnVmZmVyICpmYiA9IAo+IG1pcGktPnRpbnlkcm0u
cGlwZS5wbGFuZS5mYjsKCk9oIGRlYXIsIGFuZCBuYXR1cmFsbHkgaXQncyB0aGUgbW9zdCBhbm5v
eWluZyBvbmUgb2YgdGhlIGJ1bmNoLiBTbyB3ZQp3YW50IHRvIHRha2UgdGhlIHBsYW5lIGxvY2sg
aW4gdGhlIGZiLmRpcnR5KCkgaG9vayB0byBsb29rIGF0IHRoZSBmYiwKYnV0IG1pcGktZGJpLmMg
Y2FsbHMgdGhhdCBkaXJlY3RseSBmcm9tIHRoZSBib3dlbHMgb2YgaXRzCi5hdG9taWNfZW5hYmxl
KCkgaG9vay4gU28gdGhhdCB3b3VsZCBkZWFkbG9jayBwcmV0dHkgbmVhdGx5IGlmIHRoZQpjb21t
aXQgaGFwcGVucyB3aGlsZSBhbHJlYWR5IGhvbGRpbmcgdGhlIGxvY2suCgpTbyB3ZSdkIGVpdGhl
ciBuZWVkIHRvIHBsdW1iIGFuIGFjcXVpcmUgY29udGV4dCBpbnRvIGZiLmRpcnR5KCksCm9yIG1h
eWJlIGhhdmUgdGlueWRybSBwcm92aWRlIGEgbG93ZXIgbGV2ZWwgbG9ja2xlc3MgZGlydHkoKSBo
b29rCnRoYXQgZ2V0cyBjYWxsZWQgYnkgYm90aCAodGhlcmUgYXJlIGp1c3QgdG9vIG1hbnkgbGF5
ZXJzIGluIHRoaXMKcGFydGljdWxhciBjYWtlIHRvIGltbWVkaWF0ZWx5IHNlZSB3aGVyZSBzdWNo
IGEgaG9vayB3b3VsZCBiZSBiZXN0CnBsYWNlZCkuIE9yIG1heWJlIHRoZXJlJ3Mgc29tZSBvdGhl
ciBzb2x1dGlvbiBJIGRpZG4ndCB0aGluayBvZi4KCkxvb2tpbmcgYXQgdGhpcyBJJ20gYWxzbyBs
ZWZ0IHdvbmRlcmluZyBob3cgdGhpcyBpcyBzdXBwb3NlZApoYW5kbGUgZmIuZGlydHkoKSBnZXR0
aW5nIGNhbGxlZCBjb25jdXJyZW50bHkgd2l0aCBhIG1vZGVzZXQuClRoZSBkaXJ0eV9tdXRleCBv
bmx5IHNlZW1zIHRvIG9mZmVyIGFueSBwcm90ZWN0aW9uIGZvcgpmYi5kaXJ0eSgpIGFnYWluc3Qg
YW5vdGhlciBmYi5kaXJ0eSgpLi4uCgotLSAKVmlsbGUgU3lyasOkbMOkCkludGVsIE9UQwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
