From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 11/12] drm/ttm: Fix 'buf' pointer update in
 ttm_bo_vm_access_kmap()
Date: Fri, 26 Jan 2018 14:20:30 -0500
Message-ID: <97665aaf-f52a-174a-7b19-4f2cc0be8926@amd.com>
References: <20180126182911.20761-1-tom.stdenis@amd.com>
 <20180126182911.20761-12-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180126182911.20761-12-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wMS0yNiAwMToyOSBQTSwgVG9tIFN0IERlbmlzIHdyb3RlOgo+IFNpZ25lZC1vZmYt
Ynk6IFRvbSBTdCBEZW5pcyA8dG9tLnN0ZGVuaXNAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9n
cHUvZHJtL3R0bS90dG1fYm9fdm0uYyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192bS5jIGIv
ZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYwo+IGluZGV4IDA3YjIyZjA0Yjk2OS4uNjMx
MWY4YTQ4MWVhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192bS5jCj4gQEAgLTM0NSw2ICszNDUs
NyBAQCBzdGF0aWMgaW50IHR0bV9ib192bV9hY2Nlc3Nfa21hcChzdHJ1Y3QgdHRtX2J1ZmZlcl9v
YmplY3QgKmJvLAo+ICAJCXBhZ2UrKzsKPiAgCQlieXRlc19sZWZ0IC09IGJ5dGVzOwo+ICAJCW9m
ZnNldCA9IDA7Cj4gKwkJYnVmICs9IGJ5dGVzOwoKSSdkIHB1dCB0aGlzIHJpZ2h0IGJlZm9yZSB0
aGUgYnl0ZXNfbGVmdCAtPSBieXRlcy4KCkFsc28sIGJ1ZiBpcyBhIHZvaWQgKi4gVGhhdCBtYWtl
cyBwb2ludGVyIGFyaXRobWV0aWMgb24gaXQgc29tZXdoYXQKdW5kZWZpbmVkLiBGcm9tIHdoYXQg
SSBjYW4gZmluZCwgR0NDIHN1cHBvcnRzIGl0IGFzIGFuIGV4dGVuc2lvbi4gU2VlCmFsc28KaHR0
cHM6Ly9zdGFja292ZXJmbG93LmNvbS9xdWVzdGlvbnMvMzUyMzE0NS9wb2ludGVyLWFyaXRobWV0
aWMtZm9yLXZvaWQtcG9pbnRlci1pbi1jLgoKSWYgaXQgY29tcGlsZXMgd2l0aG91dCBhIHdhcm5p
bmcsIEkgZ3Vlc3MgaXQncyBPSyBhcyBpcy4KClJlZ2FyZHMsCsKgIEZlbGl4Cgo+ICAJfSB3aGls
ZSAoYnl0ZXNfbGVmdCk7Cj4gIAo+ICAJcmV0dXJuIGxlbjsKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
