From: Daniel Stone <daniel-rLtY4a/8tF1rovVCs/uTlw@public.gmane.org>
Subject: Re: RFC for a render API to support adaptive sync and VRR
Date: Sat, 21 Apr 2018 11:30:00 +0100
Message-ID: <CAPj87rOgShQ1P0OP=0apgZ10oyXHT68JOP+o2XWpctQnnkmM_g@mail.gmail.com>
References: <c79421ce-9408-5cd6-5de3-0fa521146e4b@amd.com>
 <435ebd04-0435-5a6a-9f1e-e4c4fc629aa9@amd.com>
 <20180409214554.GB13967@intel.com>
 <1e8d1857-faba-85da-0136-ea7c29ec1b84@amd.com>
 <b75e31f7-ce59-de97-5445-cb4c03ff7336@daenzer.net> <87o9ihyxl1.fsf@keithp.com>
 <CAKMK7uFMKEe24-cFuNx8N=JZsCG2qCZHn3orE5Aqyc8mXnuu2A@mail.gmail.com>
 <20180420203240.GA9472@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180420203240.GA9472-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
To: Manasi Navare <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Keith Packard <keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Nicolai_H=C3=A4hnle?= <nicolai.haehnle-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer-5C7GfCeVMHo@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

SGksCgpPbiAyMCBBcHJpbCAyMDE4IGF0IDIxOjMyLCBNYW5hc2kgTmF2YXJlIDxtYW5hc2kuZC5u
YXZhcmVAaW50ZWwuY29tPiB3cm90ZToKPiBPbiBXZWQsIEFwciAxOCwgMjAxOCBhdCAwOTozOTow
MkFNICswMjAwLCBEYW5pZWwgVmV0dGVyIHdyb3RlOgo+PiBPbiBXZWQsIEFwciAxOCwgMjAxOCBh
dCA1OjU4IEFNLCBLZWl0aCBQYWNrYXJkIDxrZWl0aHBAa2VpdGhwLmNvbT4gd3JvdGU6Cj4+ID4g
SSdkIGFsc28gZW5jb3VyYWdlIHVzaW5nIGEgc2luZ2xlIHVuaXQgZm9yIGFsbCBvZiB0aGVzZSB2
YWx1ZXMsCj4+ID4gcHJlZmVyYWJseSBuYW5vc2Vjb25kcy4gQWJzb2x1dGUgdGltZXMgc2hvdWxk
IGFsbCBiZSByZWZlcmVuY2VkIHRvCj4+ID4gQ0xPQ0tfTU9OT1RPTklDLgo+Pgo+PiArMSBvbiBl
dmVyeXRoaW5nIEtlaXRoIHNhaWQuIEkgZ290IHNvbWVob3cgZHJhZ2dlZCBpbiBraHIgdmsKPj4g
ZGlzY3Vzc2lvbnMgYXJvdW5kIHByZXZlbnRpbmcgbWljcm8tc3R1dHRlcmluZywgYW5kIGNvbnNl
bnN1cyBzZWVtcyB0bwo+PiBiZSB0aGF0IHRpbWVzdGFtcHMgZm9yIHNjaGVkdWxpbmcgZnJhbWVz
IGlzIHRoZSB3YXkgdG8gZ28sIG1vc3QgbGlrZWx5Cj4+IGFic29sdXRlIG9uZXMgKG5vdCBldmVy
eXRoaW5nIGlzIHJ1bm5pbmcgTGludXggdW5mb3J0dW5hdGVseSwgc28gY2FuJ3QKPj4gZ28gb3V0
cmlnaHQgYW5kIGNsYWltIGl0J3MgZ3VhcmFudGVlZCB0byBiZSBDTE9DS19NT05PVE9OSUMpLgo+
Cj4gQW5kIHllcyBJIGFsc28gZ290IGNvbnNlbnN1cyBmcm9tIE1lc2EgYW5kIG1lZGlhIGZvbGtz
IGFib3V0IHVzaW5nIHRoZQo+IGFic29sdXRlIHRpbWVzdGFtcCBmb3Igc2NoZWR1bGluZyB0aGUg
ZnJhbWVzIGFuZCB0aGVuIHRoZSBkcml2ZXIgd2lsbAo+IG1vZGlmeSB0aGUgdmJsYW5rIGxvZ2lj
IHRvICJwcmVzZW50IG5vIGVhcmxpZXIgdGhhbiB0aGUgdGltZXN0YW1wIgoKV2hpbHN0IHdlJ3Jl
IGFsbCBwaWxpbmcgaW4sIGhlcmUncyBhbm90aGVyIEFPTC4gV2UgZGlkbid0IHlldAppbXBsZW1l
bnQgdGhpcyBmb3IgV2F5bGFuZCBiZWNhdXNlIG9mIHRoZSBmdW4gaW52b2x2ZWQgaW4gYWRkaW5n
IGEKRklGTyBtb2RlIHRvIGEgdmVyeSBtYWlsYm94IHdpbmRvdyBzeXN0ZW0sIGJ1dCBhdCBzb21l
IHBvaW50IHdlJ2xsCmhhdmUgdG8gc3VjayBpdCB1cCBhbmQgcHVzaCBpdC4KCkNoZWVycywKRGFu
aWVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
