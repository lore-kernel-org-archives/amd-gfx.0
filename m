From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] [RFC] drm/radeon: clear WC flag when moving bo from vram
 to gtt
Date: Mon, 24 Apr 2017 19:06:43 +0900
Message-ID: <74a71905-eb46-0992-9093-cc0cbef2581b@daenzer.net>
References: <1493026928-30134-1-git-send-email-jisorce@oblong.com>
 <e602b898-ee7d-e744-5a08-0ab7d0f63d83@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e602b898-ee7d-e744-5a08-0ab7d0f63d83-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjQvMDQvMTcgMDY6NTEgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjQuMDQu
MjAxNyB1bSAxMTo0MiBzY2hyaWViIEp1bGllbiBJc29yY2U6Cj4+IEJ1dCByZS1hZGQgdGhlIGZs
YWcgaXMgdGhlIGJvIGlzIG1vdmVkIGJhY2sgdG8gdnJhbS4KPj4KPj4gVGhpcyBmaXhlcyAicmlu
ZyAwLzMgc3RhbGxlZCIgaXNzdWUgd2hpY2ggaGFwcGVucyB3aGVuIHRoZSBkcml2ZXIKPj4gZXZp
Y3RzIGJvIGZyb20gdnJhbSB0byBndHQsIGF0IGxlYXN0IG9uIFRBSElUSSBhbmQgQ0FQVkVSREUu
Cj4gCj4gSW50ZXJlc3RpbmcgZmluZCwgYnV0IE5BSyBvbiB0aGUgYXBwcm9hY2ggZm9yIGZpeGlu
ZyBpdC4KPiAKPiBJZiBXQyBtYXBwaW5ncyBkb24ndCB3b3JrIGZvciBUQUhJVEkgYW5kIENBUFZF
UkRFIHdlIG5lZWQgdG8gZmlndXJlIG91dAo+IHdoeSBvciBhdCBsZWFzdCBkaXNhYmxlIHRoZW0g
Zm9yIHRob3NlIGhhcmR3YXJlIGdlbmVyYXRpb25zIGluIGdlbmVyYWwuCj4gCj4gRGlzYWJsaW5n
IFdDIGZvciBCT3Mgc3dhcHBlZCBvdXQgZnJvbSBWUkFNIHdvbid0IGJ1eSB1cyBtdWNoIGlmIHRo
ZSBCTwo+IHdhcyBpbml0aWFsbHkgY3JlYXRlZCBpbiBHVFQgYW55d2F5LgoKTW9yZW92ZXIsIFJB
REVPTl9HRU1fR1RUX1dDIHNob3VsZG4ndCBoYXZlIGFueSBlZmZlY3QgYXQgYWxsIGZvciBhIEJP
CndoaWNoIGlzIGN1cnJlbnRseSBpbiBWUkFNLCBzbyBpdCdzIG5vdCBjbGVhciBob3cgdGhlIHBh
dGNoIG1ha2VzIGFueQpkaWZmZXJlbmNlLiBJIHN1c3BlY3QgaXQgbWlnaHQgYWNjaWRlbnRhbGx5
IGNhdXNlIFJBREVPTl9HRU1fR1RUX1dDIHRvCmJlIGlnbm9yZWQgYWx0b2dldGhlciBpbiByYWRl
b25fdm1fYm9fdXBkYXRlIGFuZC9vcgpyYWRlb25fdHRtX3BsYWNlbWVudF9mcm9tX2RvbWFpbi4K
CgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
