From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 01/12] drm/ttm: Fix 'buf' pointer update in
 ttm_bo_vm_access_kmap() (v2)
Date: Mon, 29 Jan 2018 15:31:51 +0100
Message-ID: <8aa2cc49-8935-cb59-9f2a-97d8ad422959@daenzer.net>
References: <20180129135513.22538-1-tom.stdenis@amd.com>
 <20180129135513.22538-2-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180129135513.22538-2-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wMS0yOSAwMjo1NSBQTSwgVG9tIFN0IERlbmlzIHdyb3RlOgo+IFRoZSBidWYgcG9p
bnRlciB3YXMgbm90IGJlaW5nIGluY3JlbWVudGVkIGluc2lkZSB0aGUgbG9vcAo+IG1lYW5pbmcg
dGhlIHNhbWUgYmxvY2sgb2YgZGF0YSB3b3VsZCBiZSByZWFkIG9yIHdyaXR0ZW4KPiByZXBlYXRl
ZGx5Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRvbSBTdCBEZW5pcyA8dG9tLnN0ZGVuaXNAYW1kLmNv
bT4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgoKUGxlYXNlIGFkZDoKCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkZpeGVzOiAwOWFj
NGZjYjNmMjUgKCJkcm0vdHRtOiBJbXBsZW1lbnQgdm1fb3BlcmF0aW9uc19zdHJ1Y3QuYWNjZXNz
IHYyIikKCnNvIHRoYXQgaXQnbGwgZ2V0IGJhY2twb3J0ZWQgdG8gdGhlIHJlbGV2YW50IHN0YWJs
ZSBicmFuY2hlcy4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNp
YXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
