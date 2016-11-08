From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: access stolen VRAM directly on CZ
Date: Tue, 8 Nov 2016 16:29:56 +0900
Message-ID: <fd22b76d-1305-f448-763d-4fdb7f2f48e8@daenzer.net>
References: <1478510481-1768-1-git-send-email-deathsimple@vodafone.de>
 <1478510481-1768-2-git-send-email-deathsimple@vodafone.de>
 <CAPM=9twmcyE4fOzZXJexdfViNx32vkc39sciQ3Ha+7UhetJJKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPM=9twmcyE4fOzZXJexdfViNx32vkc39sciQ3Ha+7UhetJJKA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMDgvMTEvMTYgMDU6MzEgQU0sIERhdmUgQWlybGllIHdyb3RlOgo+IE9uIDcgTm92ZW1iZXIg
MjAxNiBhdCAxOToyMSwgQ2hyaXN0aWFuIEvDtm5pZyA8ZGVhdGhzaW1wbGVAdm9kYWZvbmUuZGU+
IHdyb3RlOgo+PiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Cj4+Cj4+IFdlIGRvbid0IG5lZWQgdG8gdXNlIHRoZSBQQ0kgQkFSIG9uIEFQVXMuIFRoaXMg
YWxsb3dzIHVzIHRvIGFjY2Vzcwo+PiB0aGUgZnVsbCBWUkFNIGRpcmVjdGx5IHdpdGhvdXQgYmVp
bmcgbGltaXRlZCBieSB0aGUgQkFSIHNpemUuCj4gCj4gSSdtIGZlZWxpbmcgY29oZXJlbmN5IGlz
c3VlcywgaGFzIHRoaXMgYXBwcm9hY2ggYmVlbiB2YWxpZGF0ZWQgd2l0aCB0aGUgaHcgdGVhbT8K
CkkgcmFpc2VkIHRoaXMgY29uY2VybiBpbnRlcm5hbGx5IGFzIHdlbGwsIGJ1dCB0aGUgcmVzcG9u
c2UgaW5kaWNhdGVkCnRoYXQgaXQgc2hvdWxkIGJlIGZpbmUuIEFwcGFyZW50bHkgeDg2IGRlZmlu
ZXMgdGhhdCB3cml0ZS1jb21iaW5lZAp3cml0ZXMgY29tcGxldGUgYmVmb3JlIGFueSBhY2Nlc3Mg
dG8gVUMgbWVtb3J5IChzdWNoIGFzIHdyaXRpbmcgdG8gYW4KTU1JTyByZWdpc3RlciBvciBkb29y
YmVsbCB0byBzdWJtaXQgYSBHUFUgb3BlcmF0aW9uKS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBE
w6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpM
aWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBh
bmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
