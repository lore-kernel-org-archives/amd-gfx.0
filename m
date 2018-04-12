From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v4 1/2] drm/amdgpu/gmc: steal the appropriate amount of
 vram for fw hand-over
Date: Thu, 12 Apr 2018 17:09:40 +0800
Message-ID: <20180412090939.GA2630@hr-amur2>
References: <1523506110-14002-1-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_Nw0Cwh-pg9==CWLRC2E709b2S8LEWMd93Eo+ZRfZ7GCQ@mail.gmail.com>
 <5e42d9cf-2581-14e1-80fd-0378323617c5@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5e42d9cf-2581-14e1-80fd-0378323617c5-5C7GfCeVMHo@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Ranjbar,
 Ramin" <Ramin.Ranjbar-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVGh1LCBBcHIgMTIsIDIwMTggYXQgMTI6MjU6MDhQTSArMDgwMCwgR3JvZHpvdnNreSwgQW5k
cmV5IHdyb3RlOgo+IAo+IAo+IE9uIDA0LzEyLzIwMTggMTI6MTYgQU0sIEFsZXggRGV1Y2hlciB3
cm90ZToKPiA+IE9uIFRodSwgQXByIDEyLCAyMDE4IGF0IDEyOjA4IEFNLCBBbmRyZXkgR3JvZHpv
dnNreQo+ID4gPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+IHdyb3RlOgo+ID4+IEZyb206IEFs
ZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPgo+ID4+Cj4gPj4gU3RlYWwgOSBNQiBm
b3IgdmdhIGVtdWxhdGlvbiBhbmQgZmIgaWYgdmdhIGlzIGVuYWJsZWQsIG90aGVyd2lzZSwKPiA+
PiBzdGVhbCBlbm91Z2ggdG8gY292ZXIgdGhlIGN1cnJlbnQgZGlzcGxheSBzaXplIGFzIHNldCBi
eSB0aGUgdmJpb3MuCj4gPj4KPiA+PiBJZiBubyBtZW1vcnkgaXMgdXNlZCAoZS5nLiwgc2Vjb25k
YXJ5IG9yIGhlYWRsZXNzIGNhcmQpLCBza2lwCj4gPj4gc3RvbGVuIG1lbW9yeSByZXNlcnZlLgo+
ID4+Cj4gPj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgo+ID4gTG9va3MgbGlrZSB5b3UgdXNlZCB2MSByYXRoZXIgdGhhbiB2MiBvZiB0aGlz
IHBhdGNoOgo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNoLzIxNTU2
Ni8KPiA+Cj4gPiBBbGV4Cj4gCj4gVG8gbXVjaCBwYXRjaGVzIGNpcmNsaW5nIGFyb3VuZCwgTlAs
IHdpbGwgcmVzcGluIHRvbW9ycm93Lgo+IAoKTmV2ZXJtaW5kLCBndXkuIEkgd2lsbCB2ZXJpZnkg
dGhlbSBvbmNlIHlvdSBzZW5kIHRoZSBwYXRjaGVzIHRvbW9ycm93LiA6LSkKClRoYW5rcywKUmF5
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
