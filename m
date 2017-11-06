From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH umr] Skip ahead if PDE entry is actually a PTE entry. (v2)
Date: Mon, 6 Nov 2017 19:34:39 +0100
Message-ID: <a9059d35-db2e-b8e3-7e1b-ea829950dc42@gmail.com>
References: <20171104171535.6620-1-tom.stdenis@amd.com>
 <0b642f55-e810-c1a4-f6b5-4644eba2f967@gmail.com>
 <33d2fd4b-6645-e4f4-629a-40f48a339477@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <33d2fd4b-6645-e4f4-629a-40f48a339477-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMDYuMTEuMjAxNyB1bSAxOToyOCBzY2hyaWViIFRvbSBTdCBEZW5pczoKPiBPbiAwNi8xMS8x
NyAwNTowMSBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMDQuMTEuMjAxNyB1bSAx
ODoxNSBzY2hyaWViIFRvbSBTdCBEZW5pczoKPj4+IFNpZ25lZC1vZmYtYnk6IFRvbSBTdCBEZW5p
cyA8dG9tLnN0ZGVuaXNAYW1kLmNvbT4KPj4KPj4gU3RpbGwgbm90IHBlcmZlY3QsIGJ1dCBnb29k
IGVub3VnaCBmb3Igbm93LiBQYXRjaCBpcyBUZXN0ZWQtYnk6IAo+PiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Lgo+Pgo+PiBJIHRoaW5rIHlvdSBuZWVkIHRvIHJl
d29yayB0aGUgVk0gd2Fsa2luZyBhIGJpdCwgY2F1c2Ugd2UgbmVlZCB0byAKPj4gc3VwcG9ydCB0
aGUgVCBiaXQgYXMgd2VsbCBpbiB0aGUgZnV0dXJlIGFuZCB5b3VyIGNvZGUgbWFrZSBhIGZldyAK
Pj4gYXNzdW1wdGlvbnMgd2hpY2ggZG9lc24ndCBhbGxvdyB0aGF0Lgo+Cj4gRG9lc24ndCB0aGUg
VCBiaXQgaW1wbHkgVj0wIHdoaWNoIG1lYW5zIHRoZSBwYWdlIGlzbid0IGJhY2tlZCBieSAKPiBt
ZW1vcnkuIMKgTm90IG11Y2ggdW1yIGNvdWxkIGRvIGFib3V0IHRoYXQgb3RoZXIgdGhhbiB0byBw
cmludCBvdXQgdGhlIAo+IFQgYml0LgoKTm8sIHRoZSBUIGJpdCBtZWFucyB0cmFuc2xhdGUgZnVy
dGhlci4gSW4gb3RoZXIgd29yZHMgaXQgaXMgdGhlIGNvdW50ZXIgCnBhcnQgb2YgdGhlIFAgYml0
IGFuZCBtZWFucyB0aGF0IGEgUFRFIHNob3VsZCBiZSBoYW5kbGVkIGFzIGEgUERFLgoKQnV0IGZv
ciB0aGlzIHRvIGhhdmUgbWVhbmluZyB5b3UgYWxzbyBuZWVkIHRvIGhhbmRsZSB0aGUgZnJhZ21l
bnQgc2l6ZSAKYXMgd2VsbCAoTm93IEkgaGF2ZSB5b3UgdG90YWxseSBjb25mdXNlZCwgaGF2ZW4n
dCBJPyA6KS4KCkNoZWVycywKQ2hyaXN0aWFuLgoKPgo+IFRvbQo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
