From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 5/6] drm/amdgpu: use expolicit limit fro VRAM<->GTT moves
Date: Tue, 13 Sep 2016 10:32:47 +0900
Message-ID: <cb1aa76a-36d1-5c9f-271a-bd87d8afbe21@daenzer.net>
References: <1473691152-1693-1-git-send-email-deathsimple@vodafone.de>
 <1473691152-1693-5-git-send-email-deathsimple@vodafone.de>
 <CADnq5_O4RmFuHR4pBumsHnW=sfEmgnXg_HJQnPcqWV_KW4TeNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_O4RmFuHR4pBumsHnW=sfEmgnXg_HJQnPcqWV_KW4TeNA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTMvMDkvMTYgMDY6MDUgQU0sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBPbiBNb24sIFNlcCAx
MiwgMjAxNiBhdCAxMDozOSBBTSwgQ2hyaXN0aWFuIEvDtm5pZwo+IDxkZWF0aHNpbXBsZUB2b2Rh
Zm9uZS5kZT4gd3JvdGU6Cj4+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KPj4KPj4gVXNlIGFuIGV4cGxpY2l0IGxpbWl0IHdoZW4gbW92aW5nIHRoaW5n
cyBhcm91bmQgdG8KPj4gZm9yY2UgYWRkcmVzcyBzcGFjZSBhbGxvY2F0aW9uLgo+Pgo+PiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4g
Cj4gVHlwbyBpbiB0aGUgcGF0Y2ggdGl0bGU6Cj4gcy9leHBvbGljaXQvZXhwbGljaXQvCgphbmQK
CnMvZnJvL2Zvci8KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNp
YXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
