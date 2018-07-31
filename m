From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/2] drm/amdgpu: Clean-up TTM BO ref-counting interface
Date: Tue, 31 Jul 2018 16:02:35 +0800
Message-ID: <20180731080233.GC19005@hr-amur2>
References: <20180731071236.3707-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180731071236.3707-1-tzimmermann-l3A5Bk7waGM@public.gmane.org>
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
To: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gVHVlLCBKdWwgMzEsIDIwMTggYXQgMDk6MTI6MzRBTSArMDIwMCwgVGhvbWFzIFppbW1lcm1h
bm4gd3JvdGU6Cj4gVGhpcyBwYXRjaHNldCByZXBsYWNlcyB0dG1fYm9fe3JlZmVyZW5jZS91bnJl
Zn0gd2l0aCB0dG1fYm9fe2dldCxwdXR9LAo+IHdoaWNoIGZvbGxvdyBMaW51eCcgY29udmVudGlv
bnMgZm9yIHJlZi1jb3VudGluZyBmdW5jdGlvbnMuCj4gCj4gdjI6Cj4gICogdXNlIHByZWZpeCBk
cm0vYW1kZ3B1CgpJIGd1ZXNzIENocml0aWFuIHdpbGwgaGVscCB0byBmaXggdGhlIHN1YmplY3Qg
cHJlZml4LCB5b3UgYWN0dWFsbHkgbmVlZG4ndApzZW5kIHRoZW0gYWdhaW4gOi0pCgpUaGFua3Ms
ClJheQoKPiAKPiBUaG9tYXMgWmltbWVybWFubiAoMik6Cj4gICBkcm0vYW1kZ3B1OiBSZXBsYWNl
IHR0bV9ib19yZWZlcmVuY2Ugd2l0aCB0dG1fYm9fZ2V0Cj4gICBkcm0vYW1kZ3B1OiBSZXBsYWNl
IHR0bV9ib191bnJlZiB3aXRoIHR0bV9ib19wdXQKPiAKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X29iamVjdC5jIHwgNyArKystLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gCj4gLS0KPiAyLjE4LjAKPiAKPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGlu
ZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
