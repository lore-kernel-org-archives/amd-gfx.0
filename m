From: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [AMDGPU][CIK] PRIME with DRI3 + stalls rendering
Date: Tue, 15 Nov 2016 03:25:04 -0500
Message-ID: <7436783.BjWzAA5TzI@segfault>
References: <8755034.yvhYdOUKRs@segfault>
 <472120da-9ec1-3963-484f-24add93f8eb6@daenzer.net>
 <1502264.CaXMU5SOfp@segfault>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1502264.CaXMU5SOfp@segfault>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

T24gTW9uZGF5LCBOb3ZlbWJlciAxNCwgMjAxNiAzOjQwOjE3IFBNIEVTVCBTaGF3biBTdGFyciB3
cm90ZToKPiBPbiBNb25kYXksIE5vdmVtYmVyIDE0LCAyMDE2IDEwOjQwOjE3IEFNIEVTVCBNaWNo
ZWwgRMOkbnplciB3cm90ZToKPiA+IE9uIDEzLzExLzE2IDA2OjU5IEFNLCBTaGF3biBTdGFyciB3
cm90ZToKPiA+ID4gSSdtIGN1cnJlbnRseSB0cnlpbmcgdGhlIG5ldyBmZW5jZSBwYXRjaGVzIHRo
YXQgcHJldmVudCB0ZWFyaW5nIGluIFBSSU1FCj4gPiA+IG9uCj4gPiA+IEJvbmFpcmUgQ0lLLCBp
dCB3b3JrcyB3aXRoIG5vIHRlYXJpbmcgd2l0aCBsYXRlc3QgcGF0Y2hlcyBmcm9tIE1hcmlvLAo+
ID4gPiBidXQKPiA+ID4gdGhlcmUgaXMgc2lnbmlmaWNhbnQgZnJhbWUgc3RhbGxzLCBldmVuIHRo
b3VnaCB0aGUgcGVyZm9ybWFuY2UgaXMgaGlnaGVyCj4gPiA+IHRoYW4gcnVubmluZyB0aGUgQU1E
R1BVIGFzIGRlZGljYXRlZC4KPiA+IAo+ID4gUGxlYXNlIGVsYWJvcmF0ZSBvbiB3aGF0ICJmcmFt
ZSBzdGFsbHMiIG1lYW5zIGV4YWN0bHkuCj4gCj4gSXQgbG9va3MgbGlrZSB2c3luYyBpc3N1ZXMs
IGV2ZW4gdGhvdWdoIGlmIEkgdHJ5IHZibGFua19tb2RlPSMgaXQgc3RpbGwKPiBzaG93cyBzdGFs
bGluZy4KPiAKPiBJJ2xsIGhhdmUgdG8gbWFrZSBhIHZpZGVvIHRvIHNob3cgdGhlIHJlc3VsdHMg
YW5kIHBvc3QgbGluayBoZXJlLgo+IAo+IFRoYW5rcywKPiBTaGF3bgoKU28sIEl0IHR1cm5zIG91
dCB0byBiZSBLREUgKEt3aW4pIGZhdWx0LCBpZiBJIHN0YXJ0IGEgR05PTUUgc2Vzc2lvbiwgYW5k
IHJ1biAKVmFsbGV5LCBubyBzdWNoIHN0YWxscy4gRXZlbiB0aG91Z2ggSSB0b2xkIEtXSU4gdG8g
ZGlzYWJsZSBWc3luYyBjb21wbGV0ZWx5IAphbmQgZGlzYWJsZSBjb21wb3NpdGUgb24gZnVsbCBz
Y3JlZW4gd2luZG93cy4gU2VlbXMgaXQgZG9lc24ndCB3b3JrIHJpZ2h0LgoKQ29uc2lkZXIgdGhl
IFBSSU1FIHBhdGNoZXMgd29ya2luZyBmb3IgbWUuCgpUaGFua3MsClNoYXduCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
