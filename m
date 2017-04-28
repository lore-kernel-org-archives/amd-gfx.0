From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/amdgpu: Refactor flip into prepare submit and
 submit. (v2)"
Date: Fri, 28 Apr 2017 15:59:25 +0900
Message-ID: <64d1457a-8edb-b4bd-8b22-c8cad1bc53d9@daenzer.net>
References: <20170427081838.2424-1-michel@daenzer.net>
 <4e89bf8d-1620-e0e8-a331-9e2d53341635@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4e89bf8d-1620-e0e8-a331-9e2d53341635-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjcvMDQvMTcgMDc6MDQgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjcuMDQu
MjAxNyB1bSAxMDoxOCBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+PiBGcm9tOiBNaWNoZWwgRMOk
bnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KPj4KPj4gVGhpcyByZXZlcnRzIGNvbW1pdCBj
YjM0MWEzMTlmN2U2NmY4NzlkNjlhZjkyOWMzZGFkZmMxYThmMzFlLgo+Pgo+PiBUaGUgcHVycG9z
ZSBvZiB0aGUgcmVmYWN0b3Igd2FzIGZvciBhbWRncHVfY3J0Y19wcmVwYXJlL3N1Ym1pdF9mbGlw
IHRvCj4+IGJlIHVzZWQgYnkgdGhlIERDIGNvZGUsIGJ1dCB0aGF0J3Mgbm8gbG9uZ2VyIHRoZSBj
YXNlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJA
YW1kLmNvbT4KClsuLi5dCgo+PiArcGZsaXBfY2xlYW51cDoKPj4gKyAgICBpZiAodW5saWtlbHko
YW1kZ3B1X2JvX3Jlc2VydmUobmV3X2FibywgZmFsc2UpICE9IDApKSB7Cj4gCj4gV2VsbCBoZXJl
IHdlIGV4cGxpY2l0bHkgc2hvdWxkbid0IHVzZSBhbiBpbnRlcnJ1cHRpYmxlIHdhaXQsIG90aGVy
d2lzZQo+IHdlIHdvdWxkIGtlZXAgdGhlIEJPIHBpbm5lZC4KCk1ha2VzIHNlbnNlLCBidXQgdGhp
cyBwYXRjaCBqdXN0IHJldmVydHMgYW5vdGhlciBjb21taXQgYW5kIG1vdmVzIHRoaXMKY29kZSB1
bmNoYW5nZWQuIEknbGwgc2VuZCBhIGZvbGxvdy11cCBwYXRjaCB3aGljaCBmaXhlcyB0aGlzIChw
b3NzaWJseQphbHNvIGluIG90aGVyIGVycm9yIHBhdGhzKS4KCgotLSAKRWFydGhsaW5nIE1pY2hl
bCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNv
bQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVz
YSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
