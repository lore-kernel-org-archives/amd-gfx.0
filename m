From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: allocate gart memory when it's required
Date: Tue, 26 Jun 2018 09:42:01 +0200
Message-ID: <87a2a6dc-e07c-d41f-0691-afa48d0f7925@daenzer.net>
References: <1529992843-649-1-git-send-email-Jerry.Zhang@amd.com>
 <1529992843-649-2-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1529992843-649-2-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wNi0yNiAwODowMCBBTSwgSnVud2VpIFpoYW5nIHdyb3RlOgo+IEluc3RlYWQgb2Yg
Y2FsbGluZyBnYXJ0IG1lbW9yeSBvbiBldmVyeSBibyBwaW4sCj4gYWxsb2NhdGVzIGl0IG9uIGRl
bWFuZAo+IAo+IFNpZ25lZC1vZmYtYnk6IEp1bndlaSBaaGFuZyA8SmVycnkuWmhhbmdAYW1kLmNv
bT4KPiAKPiBbLi4uXQo+ICAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rpc3BsYXkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
aXNwbGF5LmMKPiBpbmRleCAwMzZiNmY3Li4wZDFjNGJlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jCj4gQEAgLTE5NCw2ICsxOTQsMTIgQEAgaW50
IGFtZGdwdV9kaXNwbGF5X2NydGNfcGFnZV9mbGlwX3RhcmdldChzdHJ1Y3QgZHJtX2NydGMgKmNy
dGMsCj4gIAkJZ290byB1bnJlc2VydmU7Cj4gIAl9Cj4gIAo+ICsJciA9IGFtZGdwdV90dG1fYWxs
b2NfZ2FydCgmbmV3X2Fiby0+dGJvKTsKPiArCWlmICh1bmxpa2VseShyICE9IDApKSB7Cj4gKwkJ
RFJNX0VSUk9SKCIlcCBiaW5kIGZhaWxlZFxuIiwgbmV3X2Fibyk7Cj4gKwkJZ290byB1bnJlc2Vy
dmU7Cj4gKwl9CgpUaGUgZXJyb3IgY2FzZSBoZXJlIGFsc28gbmVlZHMgdG8gdW5waW4gdGhlIEJP
LCBvdGhlcndpc2Ugd2UgbGVhayB0aGUKcGluLiBJIHN1c3BlY3QgdGhlIHNhbWUgaXNzdWUgYXBw
bGllcyB0byBhdCBsZWFzdCBzb21lIG9mIHRoZSBvdGhlcgpwbGFjZXMgbW9kaWZpZWQgYnkgdGhp
cyBwYXRjaC4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAg
ICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
