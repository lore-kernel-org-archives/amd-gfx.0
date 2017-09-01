From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Remove unused flip_flags from amdgpu_crtc
Date: Fri, 1 Sep 2017 10:24:51 +0900
Message-ID: <fcab3d22-a989-7687-2010-80f89c663d70@daenzer.net>
References: <20170901011935.5230-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170901011935.5230-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDEvMDkvMTcgMTA6MTkgQU0sIEhhcnJ5IFdlbnRsYW5kIHdyb3RlOgo+IE5vIG1vcmUgbmVl
ZCBzaW5jZSBBbmRyZXkncyBjaGFuZ2UgdG8gdXNlIGRybV9jcnRjJ3MgdmVyc2lvbgo+IAo+IFNp
Z25lZC1vZmYtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgo+IC0t
LQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW9kZS5oIHwgMSAtCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tb2RlLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfbW9kZS5oCj4gaW5kZXggY2IxNzM2NzhmN2RmLi4yNzgwYzg0ODkyYWMgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21vZGUuaAo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tb2RlLmgKPiBAQCAtNDQxLDcgKzQ0
MSw2IEBAIHN0cnVjdCBhbWRncHVfY3J0YyB7Cj4gIAllbnVtIGFtZGdwdV9pbnRlcnJ1cHRfc3Rh
dGUgdnN5bmNfdGltZXJfZW5hYmxlZDsKPiAgCj4gIAlpbnQgb3RnX2luc3Q7Cj4gLQl1aW50MzJf
dCBmbGlwX2ZsYWdzOwo+ICAJLyogQWZ0ZXIgU2V0IE1vZGUgc3RyZWFtIHdpbGwgYmUgbm9uLU5V
TEwgKi8KPiAgCWNvbnN0IHN0cnVjdCBkY19zdHJlYW0gKnN0cmVhbTsKPiAgCXN0cnVjdCBkcm1f
cGVuZGluZ192YmxhbmtfZXZlbnQgKmV2ZW50Owo+IAoKVGhhbmtzIGd1eXMsIHRoaXMgcGF0Y2gg
YW5kIHRoZSBwcmV2aW91cyBwYXRjaCA1MyBhcmUKClJldmlld2VkLWJ5OiBNaWNoZWwgRMOkbnpl
ciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVy
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBz
b2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBk
ZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
