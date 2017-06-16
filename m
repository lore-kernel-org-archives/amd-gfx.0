From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Optimize mutex usage (v2)
Date: Fri, 16 Jun 2017 14:45:50 +0900
Message-ID: <e71050a2-3768-b4af-fcb8-08d2ab047f4a@daenzer.net>
References: <1497589410-17779-1-git-send-email-AlexBin.Xie@amd.com>
 <1497589410-17779-2-git-send-email-AlexBin.Xie@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1497589410-17779-2-git-send-email-AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTYvMDYvMTcgMDI6MDMgUE0sIEFsZXggWGllIHdyb3RlOgo+IFVzZSByd19zZW1hcGhvcmUg
aW5zdGVhZCBvZiBtdXRleCBmb3IgYm9fbGlzdHMuCj4gCj4gSW4gb3JpZ2luYWwgZnVuY3Rpb24g
YW1kZ3B1X2JvX2xpc3RfZ2V0LCB0aGUgd2FpdGluZwo+IGZvciByZXN1bHQtPmxvY2sgY2FuIGJl
IHF1aXRlIGxvbmcgd2hpbGUgbXV0ZXgKPiBib19saXN0X2xvY2sgd2FzIGhvbGRpbmcuIEl0IGNh
biBtYWtlIG90aGVyIHRhc2tzCj4gd2FpdGluZyBmb3IgYm9fbGlzdF9sb2NrIGZvciBsb25nIHBl
cmlvZCB0b28uCj4gQ2hhbmdlIGJvX2xpc3RfbG9jayB0byByd19zZW1hcGhvcmUgY2FuIGF2b2lk
IG1vc3Qgb2YKPiBzdWNoIGxvbmcgd2FpdGluZy4KPiAKPiBTZWNvbmRseSwgdGhpcyBwYXRjaCBh
bGxvd3Mgc2V2ZXJhbCB0YXNrcyhyZWFkZXJzIG9mIGlkcikKPiB0byBwcm9jZWVkIGF0IHRoZSBz
YW1lIHRpbWUuCj4gCj4gdjI6IHVzZSByY3UgYW5kIGtyZWYgKERhdmUgQWlybGllIGFuZCBDaHJp
c3RpYW4gS8O2bmlnKQoKQXQgbGVhc3QgdGhlIGZpcnN0IHR3byBwYXJhZ3JhcGhzIGFib3ZlIGFy
ZSBpbmFjY3VyYXRlIGFuZCBjb25mdXNpbmcgaW4KdjIuIFBsZWFzZSBtb2RpZnkgdGhlIGNvbW1p
dCBsb2cgdG8gcmVmbGVjdCB3aGF0IHRoZSBwYXRjaCBhY3R1YWxseSBkb2VzCm5vdy4KCgotLSAK
RWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0
dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
