From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] gpu: drm: amdgpu: Replace mdelay with msleep in
 cik_pcie_gen3_enable()
Date: Tue, 24 Jul 2018 16:49:33 -0400
Message-ID: <CADnq5_MWJhQfqYL7KOnx5O+WfgZT01PhvPpROMj2_CeCCaA+iQ@mail.gmail.com>
References: <20180723142956.3718-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180723142956.3718-1-baijiaju1990-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Jia-Ju Bai <baijiaju1990-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Wentland, Harry" <harry.wentland-5C7GfCeVMHo@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gTW9uLCBKdWwgMjMsIDIwMTggYXQgMTA6MjkgQU0sIEppYS1KdSBCYWkgPGJhaWppYWp1MTk5
MEBnbWFpbC5jb20+IHdyb3RlOgo+IGNpa19wY2llX2dlbjNfZW5hYmxlKCkgaXMgb25seSBjYWxs
ZWQgYnkgY2lrX2NvbW1vbl9od19pbml0KCksIHdoaWNoIGlzCj4gbmV2ZXIgY2FsbGVkIGluIGF0
b21pYyBjb250ZXh0Lgo+IGNpa19wY2llX2dlbjNfZW5hYmxlKCkgY2FsbHMgbWRlbGF5KCkgdG8g
YnVzaWx5IHdhaXQsIHdoaWNoIGlzIG5vdAo+IG5lY2Vzc2FyeS4KPiBtZGVsYXkoKSBjYW4gYmUg
cmVwbGFjZWQgd2l0aCBtc2xlZXAoKS4KPgo+IFRoaXMgaXMgZm91bmQgYnkgYSBzdGF0aWMgYW5h
bHlzaXMgdG9vbCBuYW1lZCBEQ05TIHdyaXR0ZW4gYnkgbXlzZWxmLgo+Cj4gU2lnbmVkLW9mZi1i
eTogSmlhLUp1IEJhaSA8YmFpamlhanUxOTkwQGdtYWlsLmNvbT4KCkFwcGxpZWQuICB0aGFua3Mh
CgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWsuYyB8IDIgKy0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9jaWsuYwo+IGluZGV4IDBkZjIyMDMwZTcxMy4uNWI3ZmFiMmMyMDA4IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npay5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrLmMKPiBAQCAtMTQ3Niw3ICsxNDc2LDcgQEAgc3Rh
dGljIHZvaWQgY2lrX3BjaWVfZ2VuM19lbmFibGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0bXAgfD0gUENJRV9MQ19DTlRMNF9f
TENfUkVET19FUV9NQVNLOwo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgV1JFRzMy
X1BDSUUoaXhQQ0lFX0xDX0NOVEw0LCB0bXApOwo+Cj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBtZGVsYXkoMTAwKTsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1z
bGVlcCgxMDApOwo+Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBsaW5rY3Rs
ICovCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwY2lfcmVhZF9jb25maWdfd29y
ZChyb290LCBicmlkZ2VfcG9zICsgUENJX0VYUF9MTktDVEwsICZ0bXAxNik7Cj4gLS0KPiAyLjE3
LjAKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
