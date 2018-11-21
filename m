From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu/vce_v3_0.c: Remove duplicate header
Date: Wed, 21 Nov 2018 15:05:34 -0500
Message-ID: <CADnq5_PVK+zfpLEh2rL3Cs_bC8OuNXDOAfSr=gt8aHHykRiWcg@mail.gmail.com>
References: <20181121071103.GA2622@hp-pavilion-15-notebook-pc-brajeswar>
 <13613dd2-dfef-7a8e-4c27-5b5bed336a89@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <13613dd2-dfef-7a8e-4c27-5b5bed336a89-5C7GfCeVMHo@public.gmane.org>
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
To: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Sabyasachi Gupta <sabyasachi.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, Souptick Joarder <jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, brajeswar.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, "Deucher, Alexander" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

QXBwbGllZC4gIHRoYW5rcyEKT24gV2VkLCBOb3YgMjEsIDIwMTggYXQgMzoxNiBBTSBaaGFuZywg
SmVycnkoSnVud2VpKQo8SmVycnkuWmhhbmdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBPbiAxMS8yMS8x
OCAzOjExIFBNLCBCcmFqZXN3YXIgR2hvc2ggd3JvdGU6Cj4gPiBSZW1vdmUgZ2NhL2dmeF84XzBf
ZC5oIHdoaWNoIGlzIGluY2x1ZGVkIG1vcmUgdGhhbiBvbmNlCj4gPgo+ID4gU2lnbmVkLW9mZi1i
eTogQnJhamVzd2FyIEdob3NoIDxicmFqZXN3YXIubGludXhAZ21haWwuY29tPgo+IFJldmlld2Vk
LWJ5OiBKdW53ZWkgWmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+Cj4KPiA+IC0tLQo+ID4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2VfdjNfMC5jIHwgMSAtCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y2Vf
djNfMC5jCj4gPiBpbmRleCA2ZGJkMzk3MzAwNzAuLjRlNDI4OWEwNmE1MyAxMDA2NDQKPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMKPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMKPiA+IEBAIC0zNyw3ICszNyw2IEBACj4g
PiAgICNpbmNsdWRlICJnY2EvZ2Z4XzhfMF9kLmgiCj4gPiAgICNpbmNsdWRlICJzbXUvc211Xzdf
MV8yX2QuaCIKPiA+ICAgI2luY2x1ZGUgInNtdS9zbXVfN18xXzJfc2hfbWFzay5oIgo+ID4gLSNp
bmNsdWRlICJnY2EvZ2Z4XzhfMF9kLmgiCj4gPiAgICNpbmNsdWRlICJnY2EvZ2Z4XzhfMF9zaF9t
YXNrLmgiCj4gPiAgICNpbmNsdWRlICJpdnNyY2lkL2l2c3JjaWRfdmlzbGFuZHMzMC5oIgo+ID4K
Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1k
LWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
