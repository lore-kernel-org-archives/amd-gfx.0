From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix re-program vm invalidate eng address
 range for gfxhub on resume
Date: Wed, 17 May 2017 15:55:58 +0800
Message-ID: <20170517075557.GA31947@hr-amur2>
References: <1495006729-17310-1-git-send-email-ray.huang@amd.com>
 <591BFF33.2010303@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <591BFF33.2010303-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gV2VkLCBNYXkgMTcsIDIwMTcgYXQgMDM6NDM6NDdQTSArMDgwMCwgWmhvdSwgRGF2aWQoQ2h1
bk1pbmcpIHdyb3RlOgo+IEJ5IHRoaXMgY2hhbmdlLCBJIHN1Z2dlc3QgdG8gcmVtb3ZlIG1taHVi
L2dmeGh1Yl92MV8wX2lwX2Z1bmNzIGFuZCB0aGVpcgo+IElQIGJsb2NrLCB1bmlmeSB0aGVtIHRv
IGdtYyBpcCBibG9jaywgdGhpcyB3YXkgd2UgY2Fubm90IGxvc3Qgc2V0dGluZwo+IHdoZW4gcmVz
dW1lIGJhY2suCj4gCgpGcm9tIGh3IHNpZGUsIHdvIHdvbid0IGhhdmUgcmVhbCBnbWMgc2luY2Ug
dGhpcyBjaGlwLCBtbWh1YiBhbmQgZ2Z4aHViKGdjKQppbnN0ZWFkIG9mIGl0LiBNYXliZSB3ZSB3
b3VsZCBiZXR0ZXIgdG8gYWxpZ24gd2l0aCBodyBkZXNnaW4uCgpUaGFua3MsClJ1aQoKPiBSZWdh
cmRzLAo+IERhdmlkIFpob3UKPiAKPiBPbiAyMDE35bm0MDXmnIgxN+aXpSAxNTozOCwgSHVhbmcg
UnVpIHdyb3RlOgo+ID4gU2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNv
bT4KPiA+IC0tLQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjFfMC5j
IHwgMiArLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHVi
X3YxXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvCj4gYW1kZ3B1L2dmeGh1Yl92MV8wLmMKPiA+
IGluZGV4IDAwNTA3NWYuLjQxMzEzNTE0IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4aHViX3YxXzAuYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4aHViX3YxXzAuYwo+ID4gQEAgLTM2OCw3ICszNjgsNyBAQCBzdGF0aWMgaW50IGdm
eGh1Yl92MV8wX3N1c3BlbmQodm9pZCAqaGFuZGxlKQo+ID4gIAo+ID4gICBzdGF0aWMgaW50IGdm
eGh1Yl92MV8wX3Jlc3VtZSh2b2lkICpoYW5kbGUpCj4gPiAgIHsKPiA+IC0gICAgIHJldHVybiAw
Owo+ID4gKyAgICAgcmV0dXJuIGdmeGh1Yl92MV8wX2h3X2luaXQoaGFuZGxlKTsKPiA+ICAgfQo+
ID4gIAo+ID4gICBzdGF0aWMgYm9vbCBnZnhodWJfdjFfMF9pc19pZGxlKHZvaWQgKmhhbmRsZSkK
PiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
