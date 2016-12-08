From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/4] drm/amd/powerplay: introduce the cgs print helpers
Date: Thu, 8 Dec 2016 15:04:13 +0200
Message-ID: <CANOLnOOqGWKw5XdR-d=3GRrqWQ45KT_NJymWQW39kb0RtfK5Qw@mail.gmail.com>
References: <1481174591-2187-1-git-send-email-ray.huang@amd.com>
 <9672b4c9-a905-8fef-9fa4-cd0cbe94a67b@amd.com>
 <20161208090246.GA10044@hr-amur2>
 <752e5cbf-0bcb-d42f-8542-6f7a788d9299@vodafone.de>
 <20161208095013.GA11312@hr-amur2>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161208095013.GA11312@hr-amur2>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Nath,
 Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVGh1LCBEZWMgOCwgMjAxNiBhdCAxMTo1MCBBTSwgSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1k
LmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBEZWMgMDgsIDIwMTYgYXQgMDU6Mjc6MzBQTSArMDgwMCwg
Q2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMDguMTIuMjAxNiB1bSAxMDowMiBzY2hyaWVi
IEh1YW5nIFJ1aToKPj4gPiBPbiBUaHUsIERlYyAwOCwgMjAxNiBhdCAwNDo0MTowNFBNICswODAw
LCBLb2VuaWcsIENocmlzdGlhbiB3cm90ZToKPj4gPj4gU29ycnksIGJ1dCB0aGF0IGp1c3Qgc291
bmRzIGxpa2UgT1MgYWJzdHJhY3Rpb24gY29kZSB3aGljaCBpc24ndCBhbGxvd2VkLgo+PiA+Pgo+
PiA+PiBUaGVyZSBpcyBubyBiZW5lZml0IGV4Y2VwdCByb3V0aW5nIGFsbCBtZXNzYWdlcyB0aHJv
dWdoIENHUyB3aGljaCBtYWtlcwo+PiA+PiB0aGluZ3MgbXVjaCBoYXJkZXIgdG8gZm9sbG93Lgo+
PiA+Pgo+PiA+IFRoZXJlIGlzbid0IENPUyBwYXJ0IGF0IGN1cnJlbnQgZHJpdmVyLiBCdXQgaXQg
c2VlbXMgdG8gYmUgbm90IGdvb2QgdG8KPj4gPiBpbnRyb2R1Y2UgQ09TIGp1c3QgZm9yIHByaW50
cy4gQWN0dWFsbHksIG1vc3Qgb2YgZHJpdmVycyBwcmVmZXIgdG8gdXNlCj4+ID4gZGV2XyogcHJp
bnRzLCBhbmQgaXQncyBhYmxlIHRvIGR5bmFtaWMgY29udHJvbCB0aGUgcHJpbnQgbGV2ZWwgd2hl
biB3ZQo+PiA+IGRlYnVnIGl0Lgo+Pgo+PiBXZWxsIEknbSBub3Qgc3VyZSBpZiB5b3UgaGF2ZSB1
bmRlcnN0b29kIHdoYXQgSSB3YW50ZWQgdG8gc2F5Lgo+Pgo+PiBUaGUgcmVhc29uIHRoYXQgdGhl
cmUgaXNuJ3QgYW55IENPUyBhYnN0cmFjdGlvbiBpcyB0aGF0IGl0IGlzbid0IGFsbG93ZWQKPj4g
dXBzdHJlYW0uCj4+Cj4KPiBPSywgSSBzZWUuCj4KPj4gVXNpbmcgdGhlIGRldl8qIHByaW50cyBp
biB0aGUgcG93ZXJwbGF5IGNvZGUgaXMgZmluZSwgYnV0IGRvbid0IHVzZSB0aGUKPj4gQ0dTIG9y
IGFueSBvdGhlciBhYnN0cmFjdGlvbiBsYXllciBmb3IgdGhlbS4KPj4KPgo+IFBvd2VycGxheSBp
cyBxdWl0ZSBpbmRlcGVuZGVudCBjb21wb25lbnQgd2l0aG91dCBhbWRncHUgb2JqZWN0LCBpdCBp
cwo+IGhhcmQgdG8gdXNlIGRldl8qIHByaW50cyB3aXRob3V0IGFueSBhYnN0cmFjdGlvbiBsYXll
ci4KCk1heWJlIHlvdSBjb3VsZCB1c2UgZGV2X3NldF9uYW1lKCkgd2l0aCBzb21ldGhpbmcgcG93
ZXJwbGF5IHJlbGF0ZWQgb24KcmVsZXZhbnQgZGV2aWNlcyBhbmQgdGhlbiBkZXZfKiB3aWxsIHBy
aW50IHdoYXQgeW91IHdhbnQ/CgpBbHRlcm5hdGl2ZWx5IHlvdSBjb3VsZCBkbwoKI2RlZmluZSBw
cl9mbXQoZm10KSAiW3Bvd2VycGxheV0gIiBmbXQKCmJlZm9yZSAjaW5jbHVkZSA8bGludXgvLi4u
PiBhbmQgdGhlbiBhbGwgcHJfKiBmdW5jdGlvbnMgd2lsbCBwcmVmaXgKdGhlaXIgbWVzc2FnZXMu
CgpHcmHFvnZ5ZGFzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
