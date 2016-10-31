From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: cleanup amdgpu_cs_ioctl to make code
 logicality clear
Date: Mon, 31 Oct 2016 10:14:26 +0100
Message-ID: <34d30f03-b833-ce49-b50b-bf6b81f46886@vodafone.de>
References: <1477879680-21488-1-git-send-email-ray.huang@amd.com>
 <54bf14e1-8a3c-2710-df52-0f9d82f91a90@vodafone.de>
 <20161031085807.GA3927@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161031085807.GA3927@hr-amur2>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMzEuMTAuMjAxNiB1bSAwOTo1OCBzY2hyaWViIEh1YW5nIFJ1aToKPiBPbiBNb24sIE9jdCAz
MSwgMjAxNiBhdCAwMzo1Mzo1MlBNICswODAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBB
bSAzMS4xMC4yMDE2IHVtIDAzOjA4IHNjaHJpZWIgSHVhbmcgUnVpOgo+Pj4gU2lnbmVkLW9mZi1i
eTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPj4gTG9va3MgZ29vZCB0byBtZSwgcGF0
Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcKPj4gPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4uCj4+Cj4+IEJUVzogYW1kZ3B1X2NzX2hhbmRsZV9sb2NrdXAoKSBpcyBhIGxlZnRv
dmVyIGZyb20gcmFkZW9uIGFuZCBjYW4gYmUKPj4gcmVtb3ZlZC4gV291bGQgYmUgbmljZSBpZiB5
b3UgY2FuIHRha2UgY2FyZSBvZiB0aGlzIGFzIHdlbGwuCj4+Cj4gU3VyZS4gYW1kZ3B1X2NzX2hh
bmRsZV9sb2NrdXAgYWN0dWFsbHkgd2lsbCB0cmlnZ2VyIGEgZ3B1IHJlc2V0IHdoZW4gciA9PQo+
IC1FREVBRExLLiBJJ20gbm90IHZlcnkgY2xlYXIgd2l0aCB3aHkgd2UgbmVlZG4ndCBncHUgcmVz
ZXQgb24gdGhhdCBjYXNlCj4geWV0LCBjb3VsZCB5b3UgZXhwbGFpbj8KCk9uIHJhZGVvbiB0aGUg
ZmVuY2Ugd2FpdCBmdW5jdGlvbiByZXR1cm5lZCAtRURFQURMSyB3aGVuIGl0IGRldGVjdGVkIAp0
aGF0IHRoZSBoYXJkd2FyZSBpcyBsb2NrZWQgdXAuCgpJbiB0aGUgQ1MgYW5kIEdFTSBJT0NUTHMg
d2UgdGhlbiBjYXRjaCB0aGlzIGVycm9yLCByZXNldGVkIHRoZSBoYXJkd2FyZSAKYW5kIHRyaWVk
IGFnYWluLgoKU2luY2Ugd2UgbmV2ZXIgcmV0dXJuIC1FREVBRExLIGFueSBtb3JlIHdlIGNhbiBq
dXN0IGRyb3AgdGhlIGhhbmRsaW5nIApmb3IgdGhpcy4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4K
PiBUaGFua3MsCj4gUnVpCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
