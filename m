From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 00/14] drm/amdgpu/si: Make SI DPM workable
Date: Tue, 30 Aug 2016 23:57:00 +0800
Message-ID: <20160830155659.GA10345@hr-amur2>
References: <1472557811-8015-1-git-send-email-ray.huang@amd.com>
 <9298c36a-caef-3b43-285b-d118134a73e6@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9298c36a-caef-3b43-285b-d118134a73e6-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
Cc: "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Yu,
 Hui" <Hui.Yu-5C7GfCeVMHo@public.gmane.org>

T24gVHVlLCBBdWcgMzAsIDIwMTYgYXQgMDg6MzA6NTdQTSArMDgwMCwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBGb3IgcGF0Y2ggIzQ6Cj4gPiBkcm0vYW1kZ3B1OiByZW1vdmUgdXNlbGVzcyBm
dW5jdGlvbnMgb2Ygc2kgZHBtCj4gTWF5YmUgY2FsbCB0aGF0ICJyZW1vdmUgdW51c2VkIGZ1bmN0
aW9uIGZvcndhcmQgZGVmaW5lIi4KPiAKPiBBbmQgaW4gZ2VuZXJhbCBwYXRjaGVzIHNob3VsZCBh
dCBsZWFzdCBoYXZlIGEgY29tbWl0IG1lc3NhZ2UgYW5kIG5vdCAKPiBqdXN0IHN1YmplY3QuIEEg
c2ltcGxlIG9uZSBsaW5lciBsaWtlICJUaGUgZnVuY3Rpb25zIGRvbid0IGV4aXN0cyBhbnkgCj4g
bW9yZS4iIHNob3VsZCBiZSBzdWZmaWNpZW50IGluIHRoaXMgY2FzZS4KPiAKCkkgc2VlLCB5b3Un
cmUgcmlnaHQuICJ1bnVzZWQgZnVuY3Rpb24iIGlzIGJldHRlciwgSSB3aWxsIHVwZGF0ZSBpdCBh
dCBWMi4KCj4gUGF0Y2ggIzEwOgo+IAo+IFdlbGwgd2UgcHJvYmFibHkgc2hvdWxkbid0IGNhbGwg
dGhvc2UgZnVuY3Rpb25zIHJ2NzcwXyogYW55IG1vcmUuCj4gCgpZZXAsIEkgd291bGQgbGlrZSB0
byByZW1vdmUgdGhhdCBmdW5jdGlvbi4gVXNlICJhZGV2LT5tYy52cmFtX3R5cGUgPT0KQU1ER1BV
X1ZSQU1fVFlQRV9HRERSNSIgaW5zdGVhZCBvZiBtZW1fZ2RkcjUgZmxhZy4KCj4gQXBhcnQgZnJv
bSB0aGF0IHRoZSBwYXRjaGVzIGxvb2sgZ29vZCB0byBtZSwgYnV0IHNpbmNlIEknbSBjbGVhcmx5
IG5vdCAKPiB0aGUgRFBNIGV4cGVydCB0aGV5IGFyZSBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyAKPiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KPiAKClRoYW5rIHlvdSwKUnVpCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
