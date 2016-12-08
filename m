From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/4] drm/amd/powerplay: introduce the cgs print helpers
Date: Thu, 8 Dec 2016 17:50:14 +0800
Message-ID: <20161208095013.GA11312@hr-amur2>
References: <1481174591-2187-1-git-send-email-ray.huang@amd.com>
 <9672b4c9-a905-8fef-9fa4-cd0cbe94a67b@amd.com>
 <20161208090246.GA10044@hr-amur2>
 <752e5cbf-0bcb-d42f-8542-6f7a788d9299@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <752e5cbf-0bcb-d42f-8542-6f7a788d9299-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Nath,
 Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVGh1LCBEZWMgMDgsIDIwMTYgYXQgMDU6Mjc6MzBQTSArMDgwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBBbSAwOC4xMi4yMDE2IHVtIDEwOjAyIHNjaHJpZWIgSHVhbmcgUnVpOgo+ID4g
T24gVGh1LCBEZWMgMDgsIDIwMTYgYXQgMDQ6NDE6MDRQTSArMDgwMCwgS29lbmlnLCBDaHJpc3Rp
YW4gd3JvdGU6Cj4gPj4gU29ycnksIGJ1dCB0aGF0IGp1c3Qgc291bmRzIGxpa2UgT1MgYWJzdHJh
Y3Rpb24gY29kZSB3aGljaCBpc24ndCBhbGxvd2VkLgo+ID4+Cj4gPj4gVGhlcmUgaXMgbm8gYmVu
ZWZpdCBleGNlcHQgcm91dGluZyBhbGwgbWVzc2FnZXMgdGhyb3VnaCBDR1Mgd2hpY2ggbWFrZXMK
PiA+PiB0aGluZ3MgbXVjaCBoYXJkZXIgdG8gZm9sbG93Lgo+ID4+Cj4gPiBUaGVyZSBpc24ndCBD
T1MgcGFydCBhdCBjdXJyZW50IGRyaXZlci4gQnV0IGl0IHNlZW1zIHRvIGJlIG5vdCBnb29kIHRv
Cj4gPiBpbnRyb2R1Y2UgQ09TIGp1c3QgZm9yIHByaW50cy4gQWN0dWFsbHksIG1vc3Qgb2YgZHJp
dmVycyBwcmVmZXIgdG8gdXNlCj4gPiBkZXZfKiBwcmludHMsIGFuZCBpdCdzIGFibGUgdG8gZHlu
YW1pYyBjb250cm9sIHRoZSBwcmludCBsZXZlbCB3aGVuIHdlCj4gPiBkZWJ1ZyBpdC4KPiAKPiBX
ZWxsIEknbSBub3Qgc3VyZSBpZiB5b3UgaGF2ZSB1bmRlcnN0b29kIHdoYXQgSSB3YW50ZWQgdG8g
c2F5Lgo+IAo+IFRoZSByZWFzb24gdGhhdCB0aGVyZSBpc24ndCBhbnkgQ09TIGFic3RyYWN0aW9u
IGlzIHRoYXQgaXQgaXNuJ3QgYWxsb3dlZCAKPiB1cHN0cmVhbS4KPiAKCk9LLCBJIHNlZS4KCj4g
VXNpbmcgdGhlIGRldl8qIHByaW50cyBpbiB0aGUgcG93ZXJwbGF5IGNvZGUgaXMgZmluZSwgYnV0
IGRvbid0IHVzZSB0aGUgCj4gQ0dTIG9yIGFueSBvdGhlciBhYnN0cmFjdGlvbiBsYXllciBmb3Ig
dGhlbS4KPiAKClBvd2VycGxheSBpcyBxdWl0ZSBpbmRlcGVuZGVudCBjb21wb25lbnQgd2l0aG91
dCBhbWRncHUgb2JqZWN0LCBpdCBpcwpoYXJkIHRvIHVzZSBkZXZfKiBwcmludHMgd2l0aG91dCBh
bnkgYWJzdHJhY3Rpb24gbGF5ZXIuCgpBbnl3YXksIGl0J3Mgc21hbGwgdXBkYXRlLCBJJ20gZmlu
ZSB0byBkcm9wIGl0LgoKVGhhbmtzLApSYXkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
