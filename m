From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] Propose new struct drm_mem_region
Date: Tue, 30 Jul 2019 16:30:57 +0200
Message-ID: <743ab99e-95cb-f6fa-6903-5556d5050f6d@daenzer.net>
References: <20190730003225.322-1-brian.welty@intel.com>
 <951e9e42-96bc-fc8d-0153-3ca7ac5f1e74@amd.com>
 <20190730093847.GP15868@phenom.ffwll.local>
 <ee600bcd-d880-7199-21d0-df6e51f5adfa@amd.com>
 <CAKMK7uHrGgn7FqSBD+qDYYHxyPLvv5OqzwLTACWuqbjANKFuQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAKMK7uHrGgn7FqSBD+qDYYHxyPLvv5OqzwLTACWuqbjANKFuQA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Brian Welty <brian.welty-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wNy0zMCAxMjo0NSBwLm0uLCBEYW5pZWwgVmV0dGVyIHdyb3RlOgo+IE9uIFR1ZSwg
SnVsIDMwLCAyMDE5IGF0IDEyOjI0IFBNIEtvZW5pZywgQ2hyaXN0aWFuCj4gPENocmlzdGlhbi5L
b2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4+IEFtIDMwLjA3LjE5IHVtIDExOjM4IHNjaHJpZWIgRGFu
aWVsIFZldHRlcjoKPj4+IE9uIFR1ZSwgSnVsIDMwLCAyMDE5IGF0IDA4OjQ1OjU3QU0gKzAwMDAs
IEtvZW5pZywgQ2hyaXN0aWFuIHdyb3RlOgo+IAo+Pj4+PiArI2RlZmluZSBEUk1fTUVNX1NZU1RF
TSAgICAgMAo+Pj4+PiArI2RlZmluZSBEUk1fTUVNX1NUT0xFTiAgICAgMQo+Pj4+IEkgdGhpbmsg
d2UgbmVlZCBhIGJldHRlciBuYW1pbmcgZm9yIHRoYXQuCj4+Pj4KPj4+PiBTVE9MRU4gc291bmRz
IHdheSB0byBtdWNoIGxpa2Ugc3RvbGVuIFZSQU0gZm9yIGludGVncmF0ZWQgR1BVcywgYnV0IGF0
Cj4+Pj4gbGVhc3QgZm9yIFRUTSB0aGlzIGlzIHRoZSBzeXN0ZW0gbWVtb3J5IGN1cnJlbnRseSBH
UFUgYWNjZXNzaWJsZS4KPj4+IFl1cCB0aGlzIGlzIHdyb25nLCBmb3IgaTkxNSB3ZSB1c2UgdGhp
cyBhcyBzdG9sZW4sIGZvciB0dG0gaXQncyB0aGUgZ3B1Cj4+PiB0cmFuc2xhdGlvbiB0YWJsZSB3
aW5kb3cgaW50byBzeXN0ZW0gbWVtb3J5LiBOb3QgdGhlIHNhbWUgdGhpbmcgYXQgYWxsLgo+Pgo+
PiBUaG91Z2h0IHNvLiBUaGUgY2xvc2VzdCBJIGhhdmUgaW4gbWluZCBpcyBHVFQsIGJ1dCBldmVy
eXRoaW5nIGVsc2Ugd29ya3MKPj4gYXMgd2VsbC4KPiAKPiBXb3VsZCB5b3VyIEdQVV9NQVBQRUQg
YWJvdmUgd29yayBmb3IgVFQ/IEkgdGhpbmsgd2UnbGwgYWxzbyBuZWVkCj4gU1RPTEVOLCBJJ20g
ZXZlbiBoZWFyaW5nIG5vaXNlcyB0aGF0IHRoZXJlJ3MgZ29pbmcgdG8gYmUgc3RvbGVuIGZvcgo+
IGRpc2NyZXRlIHZyYW0gZm9yIHVzIC4uLgoKQ291bGQgaTkxNSB1c2UgRFJNX01FTV9QUklWIGZv
ciBzdG9sZW4/IE9yIGlzIHRoZXJlIG90aGVyIGhhcmR3YXJlIHdpdGgKc29tZXRoaW5nIHNpbWls
YXI/CgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgIGh0dHBzOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAg
ICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
