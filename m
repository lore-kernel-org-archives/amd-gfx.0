From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: move the amdgpu_fbdev_set_suspend() further up
Date: Mon, 23 Jul 2018 12:42:47 +0200
Message-ID: <9a89f900-ee09-aaf3-1bd4-dadf7fba0a56@daenzer.net>
References: <1532340381-28557-1-git-send-email-shirish.s@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1532340381-28557-1-git-send-email-shirish.s-5C7GfCeVMHo@public.gmane.org>
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
To: Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>, alexander.deucher-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wNy0yMyAxMjowNiBQTSwgU2hpcmlzaCBTIHdyb3RlOgo+IFRoaXMgcGF0Y2ggbW92
ZXMgYW1kZ3B1X2ZiZGV2X3NldF9zdXNwZW5kKCkgdG8gdGhlIGJlZ2lubmluZyAKPiBvZiBzdXNw
ZW5kIHNlcXVlbmNlLgoKV291bGQgYmUgbmljZSB0byBoYXZlIHNvbWUgcmF0aW9uYWxlLCBlLmcu
OgoKIFRoaXMgaXMgdG8gYXZvaWQgZmJjb24gdHJ5aW5nIHRvIHdyaXRlIHRvIHRoZSBHUFUncyBt
ZW1vcnkgd2hlbiB0aGUgR1BVCiBpcyBhbHJlYWR5IHBvd2VyZWQgZG93bi4KCgpPdGhlciB0aGFu
IHRoYXQgbG9va3MgZ3JlYXQsIHRoYW5rcy4gV2l0aCBhIHJhdGlvbmFsZSBhZGRlZCB0byB0aGUK
Y29tbWl0IGxvZywKClJldmlld2VkLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJA
YW1kLmNvbT4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAg
ICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
