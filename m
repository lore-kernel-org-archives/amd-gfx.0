From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/ttm: partial revert "cleanup ttm_tt_(unbind|destroy)"
 v2
Date: Wed, 27 Jul 2016 11:26:00 +0900
Message-ID: <95d462b5-7c20-2f40-c406-48f5aece0817@daenzer.net>
References: <1469193013-11482-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469193013-11482-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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

T24gMjIuMDcuMjAxNiAyMjoxMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBGcm9tOiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gCj4gV2Ugc3RpbGwgbmVl
ZCB0byB1bmJpbmQgZXhwbGljaXRlbHkgZHVyaW5nIGEgbW92ZS4KClRoaXMgY2hhbmdlIGZpeGVk
IGEgaGFuZyBmb3IgbWUgd2hlbiBydW5uaW5nIHRoZSBwaWdsaXQgdGVzdAptYXgtdGV4dHVyZS1z
aXplIHdpdGggdGhlIHJhZGVvbiBkcml2ZXIgb24gS2F2ZXJpLgoKSG93ZXZlciwgdGhlcmUncyBz
dGlsbCBhIHNpbWlsYXIgaGFuZyBsZWZ0IHdoZW4gbGV0dGluZyB0aGUgcGlnbGl0IHRlc3QKdGV4
M2QtbWF4c2l6ZSBydW4gY29uY3VycmVudGx5IHdpdGggb3RoZXIgdGVzdHMgKHJ1bm5pbmcgdGV4
M2QtbWF4c2l6ZQphbG9uZSBkb2Vzbid0IGhhbmcsIGJ1dCBmYWlscyBkdWUgdG8gcnVubmluZyBv
dXQgb2YgR1BVIG1lbW9yeTsgdGhhdCdzIGEKcmVjZW50IHJhZGVvbnNpIHJlZ3Jlc3Npb24pLiBU
aGVyZSBhcmUKCiBbVFRNXSBCdWZmZXIgZXZpY3Rpb24gZmFpbGVkCgptZXNzYWdlcyBpbiBkbWVz
ZyBzaG9ydGx5IGJlZm9yZSB0aGUgaGFuZy4KCkkgaGF2ZW4ndCBzZWVuIHN1Y2ggaGFuZ3Mgd2l0
aCBvbGRlciBrZXJuZWxzLiBBbnkgaWRlYXMgb2ZmaGFuZCB3aGF0IHRoZQpwcm9ibGVtIGNvdWxk
IGJlPyBJZiBub3QsIEknbGwgdHJ5IGJpc2VjdGluZy4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBE
w6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpM
aWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBh
bmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
