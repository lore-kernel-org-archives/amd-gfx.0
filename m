From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: cleanup amdgpu_cs_ioctl to make code
 logicality clear
Date: Mon, 31 Oct 2016 17:21:38 +0800
Message-ID: <20161031092137.GB3927@hr-amur2>
References: <1477879680-21488-1-git-send-email-ray.huang@amd.com>
 <54bf14e1-8a3c-2710-df52-0f9d82f91a90@vodafone.de>
 <20161031085807.GA3927@hr-amur2>
 <34d30f03-b833-ce49-b50b-bf6b81f46886@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <34d30f03-b833-ce49-b50b-bf6b81f46886-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: Christian =?utf-8?B?S++/vW5pZw==?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCBPY3QgMzEsIDIwMTYgYXQgMDU6MTQ6MjZQTSArMDgwMCwgQ2hyaXN0aWFuIEvvv71u
aWcgd3JvdGU6Cj4gQW0gMzEuMTAuMjAxNiB1bSAwOTo1OCBzY2hyaWViIEh1YW5nIFJ1aToKPiA+
IE9uIE1vbiwgT2N0IDMxLCAyMDE2IGF0IDAzOjUzOjUyUE0gKzA4MDAsIENocmlzdGlhbiBLP25p
ZyB3cm90ZToKPiA+PiBBbSAzMS4xMC4yMDE2IHVtIDAzOjA4IHNjaHJpZWIgSHVhbmcgUnVpOgo+
ID4+PiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgo+ID4+IExv
b2tzIGdvb2QgdG8gbWUsIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gSz9uaWcKPiA+
PiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KPiA+Pgo+ID4+IEJUVzogYW1kZ3B1X2NzX2hh
bmRsZV9sb2NrdXAoKSBpcyBhIGxlZnRvdmVyIGZyb20gcmFkZW9uIGFuZCBjYW4gYmUKPiA+PiBy
ZW1vdmVkLiBXb3VsZCBiZSBuaWNlIGlmIHlvdSBjYW4gdGFrZSBjYXJlIG9mIHRoaXMgYXMgd2Vs
bC4KPiA+Pgo+ID4gU3VyZS4gYW1kZ3B1X2NzX2hhbmRsZV9sb2NrdXAgYWN0dWFsbHkgd2lsbCB0
cmlnZ2VyIGEgZ3B1IHJlc2V0IHdoZW4gciA9PQo+ID4gLUVERUFETEsuIEknbSBub3QgdmVyeSBj
bGVhciB3aXRoIHdoeSB3ZSBuZWVkbid0IGdwdSByZXNldCBvbiB0aGF0IGNhc2UKPiA+IHlldCwg
Y291bGQgeW91IGV4cGxhaW4/Cj4gCj4gT24gcmFkZW9uIHRoZSBmZW5jZSB3YWl0IGZ1bmN0aW9u
IHJldHVybmVkIC1FREVBRExLIHdoZW4gaXQgZGV0ZWN0ZWQgCj4gdGhhdCB0aGUgaGFyZHdhcmUg
aXMgbG9ja2VkIHVwLgo+IAo+IEluIHRoZSBDUyBhbmQgR0VNIElPQ1RMcyB3ZSB0aGVuIGNhdGNo
IHRoaXMgZXJyb3IsIHJlc2V0ZWQgdGhlIGhhcmR3YXJlIAo+IGFuZCB0cmllZCBhZ2Fpbi4KPiAK
PiBTaW5jZSB3ZSBuZXZlciByZXR1cm4gLUVERUFETEsgYW55IG1vcmUgd2UgY2FuIGp1c3QgZHJv
cCB0aGUgaGFuZGxpbmcgCj4gZm9yIHRoaXMuCj4gCgpZZXAsIEkgc2VlLiBUaGFua3MgdG8gY2xh
cmlmeSBpdC4KClRoYW5rcywKUnVpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
