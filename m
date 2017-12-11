From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: set gtt size according to system memory
 size only
Date: Mon, 11 Dec 2017 12:29:08 +0100
Message-ID: <8c70faa2-ee3e-296b-5c61-ede3ac6396f0@daenzer.net>
References: <1511946723-27200-1-git-send-email-Hongbo.He@amd.com>
 <090b426c-0635-3c59-8a69-315c7f430b59@daenzer.net>
 <7b138de2-70eb-62ef-e61a-8933d77af124@amd.com>
 <915d1570-856e-09ae-63b1-5e3d2b937edc@daenzer.net>
 <MWHPR1201MB0127DE9F4391624C09F625F1FD370@MWHPR1201MB0127.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR1201MB0127DE9F4391624C09F625F1FD370-3iK1xFAIwjq9imrIu4W8xGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "He, Roger" <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxNy0xMi0xMSAwMzo0OSBBTSwgSGUsIFJvZ2VyIHdyb3RlOgo+PiBGcm9tOiBNaWNoZWwg
RMOkbnplciBbbWFpbHRvOm1pY2hlbEBkYWVuemVyLm5ldF0gT24gMjAxNy0xMi0wNyAwNzowNwo+
PiBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IAo+Pj4gSSB0aGluayBJIGtub3cgd2hh
dCBpcyBnb2luZyBvbiBoZXJlLiBUaGUgbWF4LXRleHR1cmUtc2l6ZSBrZWVwcwo+Pj4gIGluY3Jl
YXNpbmcgdGhlIHRleHR1cmUgc2l6ZSBhcyBsb25nIGFzIGl0IGRvZXNuJ3QgZmFpbHMgdG8KPj4+
IGFsbG9jYXRlIG9uZS4KPj4+IAo+Pj4gU28gdGhlICJPdXQgb2Yga2VybmVsIG1lbW9yeSIgbWVz
c2FnZSBpcyBhY3R1YWxseSB0aGUgZGVzaXJlZAo+Pj4gZWZmZWN0IChidXQgd2Ugc2hvdWxkIHBy
b2JhYmx5IHJlbW92ZSB0aGUgbWVzc2FnZSkuCj4+PiAKPj4+IFRoZSBwcmljZSBxdWVzdGlvbiBp
cyB3aGF0IGhhcHBlbnMgYWZ0ZXIgdGhhdD8gVGhvc2UgY29kZSBwYXRocwo+Pj4gYXJlIHByb2Jh
Ymx5IG5vdCB2ZXJ5IHdlbGwgdGVzdGVkLgo+PiAKPj4gSSdtIGF0dGFjaGluZyBhbGwgdGhlIHJl
bGF0ZWQgZG1lc2cgb3V0cHV0IEkndmUgY2FwdHVyZWQuCj4+IEJhc2ljYWxseSwgYmVzdCBjYXNl
IGlzIHRoZSBPT00gcmVhcGVyIGtpbGxpbmcgcGlnbGl0LCB3b3JzdCBjYXNlCj4+IGlzIG5vIHJl
c3BvbnNlIHRvIFNTSCA9PiBoYXJkIHJlYm9vdC4KCkJUVywgZXZlbiB3aGVuIHRoZSBtYWNoaW5l
IHN0YXlzIHJlc3BvbnNpdmUgdmlhIFNTSCwgdGhlIEdQVSBoYW5ncy4KCgo+PiBVbnRpbCB0aGlz
IGJlY29tZXMgbW9yZSByb2J1c3QsIHRoaXMgY2hhbmdlIHNob3VsZCBwcm9iYWJseSBiZQo+PiBy
ZXZlcnRlZC4KPiAKPiBJIGhhdmUgbm90IGdvdCBhbnkgdmFsdWFibGUgaW5mbyBmcm9tIGVycm9y
IGxvZy4gUGxlYXNlIHJldmVydCBpdCBub3cKPiBhcyBxdWljayBzb2x1dGlvbiwgbGF0ZXIgbGV0
IG1lIGNoZWNrIHRoZSByZWFzb24uCgpJJ20gYnVzeSB3aXRoIG90aGVyIHN0dWZmLCBjYW4geW91
IHJldmVydCBpdD8KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNp
YXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
