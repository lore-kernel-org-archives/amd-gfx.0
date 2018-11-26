From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Remove duplicate header
Date: Mon, 26 Nov 2018 15:32:42 -0500
Message-ID: <CADnq5_OEj_6nryB6uf_LTL2OPcpQF1Ai9fCBbuDza6uADO8=oA@mail.gmail.com>
References: <20181123031831.GA2470@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181123031831.GA2470@hp-pavilion-15-notebook-pc-brajeswar>
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
To: brajeswar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Sabyasachi Gupta <sabyasachi.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Daenzer, Michel" <michel.daenzer-5C7GfCeVMHo@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

T24gRnJpLCBOb3YgMjMsIDIwMTggYXQgMjo0MSBBTSBCcmFqZXN3YXIgR2hvc2gKPGJyYWplc3dh
ci5saW51eEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gUmVtb3ZlIGRybS9kcm1fZmJfaGVscGVyLmgg
d2hpY2ggaXMgaW5jbHVkZWQgbW9yZSB0aGFuIG9uY2UKPgo+IFNpZ25lZC1vZmYtYnk6IEJyYWpl
c3dhciBHaG9zaCA8YnJhamVzd2FyLmxpbnV4QGdtYWlsLmNvbT4KCkFwcGxpZWQuICB0aGFua3Mh
CgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW9kZS5o
IHwgMSAtCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21vZGUuaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9tb2RlLmgKPiBpbmRleCBiOWU5ZThiMDJmYjcuLjFjYWMxMmEy
NmE0ZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW9k
ZS5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21vZGUuaAo+IEBA
IC0zOCw3ICszOCw2IEBACj4gICNpbmNsdWRlIDxkcm0vZHJtX2NydGNfaGVscGVyLmg+Cj4gICNp
bmNsdWRlIDxkcm0vZHJtX2ZiX2hlbHBlci5oPgo+ICAjaW5jbHVkZSA8ZHJtL2RybV9wbGFuZV9o
ZWxwZXIuaD4KPiAtI2luY2x1ZGUgPGRybS9kcm1fZmJfaGVscGVyLmg+Cj4gICNpbmNsdWRlIDxs
aW51eC9pMmMuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L2kyYy1hbGdvLWJpdC5oPgo+ICAjaW5jbHVk
ZSA8bGludXgvaHJ0aW1lci5oPgo+IC0tCj4gMi4xNy4xCj4KPiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
