From: Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>
Subject: Re: [PATCH 2/3] drm: Add basic helper to allow precise pageflip
 timestamps in vrr.
Date: Wed, 13 Feb 2019 09:55:47 +0000
Message-ID: <155005174695.11832.14626201304826541281@skylake-alporthouse-com>
References: <20190211032225.9488-1-mario.kleiner.de@gmail.com>
 <20190211032225.9488-3-mario.kleiner.de@gmail.com>
 <20190211083540.GR23159@phenom.ffwll.local>
 <41354dd1-e3fe-58cc-9c10-1a8cd05b2a40@amd.com>
 <CAKMK7uHERMMLJyu3uMP2k+atZAtUdOazzqA2R9tM05yJvk2FdA@mail.gmail.com>
 <CAEsyxyiT-k5LecWs1=Zyj9J=GPjbQFQSPzYQpDxFzjwwRvFS-A@mail.gmail.com>
 <20190213095055.GF23159@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190213095055.GF23159-dv86pmgwkMBes7Z6vYuT8azUEOm+Xw19@public.gmane.org>
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
To: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "michel-otUistvHUpPR7s880joybQ@public.gmane.org" <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>

UXVvdGluZyBEYW5pZWwgVmV0dGVyICgyMDE5LTAyLTEzIDA5OjUwOjU1KQo+IE9uIFR1ZSwgRmVi
IDEyLCAyMDE5IGF0IDEwOjMyOjMxUE0gKzAxMDAsIE1hcmlvIEtsZWluZXIgd3JvdGU6Cj4gPiBJ
IHRoaW5rIGFsbCBrbXMgZHJpdmVycyB0cnkgdG8gY2FsbCBkcm1fY3J0Y19oYW5kbGVfdmJsYW5r
KCkgYXQgc3RhcnQKPiA+IG9mIHZibGFuayB0byBnaXZlIE1lc2EgdGhlIG1vc3QgdGltZSBmb3Ig
ZnJvbnRidWZmZXIgcmVuZGVyaW5nIGZvcgo+ID4gY2xhc3NpYyBYLiBCdXQgdmJsYW5rIGV2ZW50
cyBhcmUgYWxzbyB1c2VkIGZvciBzY2hlZHVsaW5nIGJ1ZmZlcnN3YXBzCj4gPiBvciBvdGhlciBz
dHVmZiBmb3IgcmVkaXJlY3RlZCB3aW5kb3dlZCByZW5kZXJpbmcsIG9yIHZpYSBhcGkncyBsaWtl
Cj4gPiBPTUxfc3luY19jb250cm9scyBnbFhXYWl0Rm9yTXNjT01MLCBzbyB0aGVyZSBtaWdodCBi
ZSBvdGhlciB0aGluZ3MKPiA+IGFmZmVjdGVkIGJ5IGEgbW9yZSBkZWxheWVkIHZibGFuayBoYW5k
bGluZy4KPiAKPiBUaGUgZnJvbnRidWZmZXIgcmVuZGVyaW5nIGlzIHZlcnkgbXVjaCBYIGRyaXZl
ciBzcGVjaWZpYywgYW5kIEkgdGhpbmsKPiAtYW1kZ3B1L3JhZGVvbiBpcyB0aGUgb25seSBvbmUg
dGhhdCByZXF1aXJlcyB0aGlzLiBObyBpOTE1IGRyaXZlciBldmVyCj4gdXNlZCB0aGUgdmJsYW5r
IGludGVycnVwdCB0byBzY2hlZHVsZSBmcm9udGJ1ZmZlciBibGl0cywgd2UgdXNlIHNvbWUKPiBD
Uy1zaWRlIHN0YWxscy4KCkZ3aXcsIHRoZSBQcmVzZW50IG1pZGxheWVyIGRvZXMgdXNlIHZibGFu
ayBzY2hlZHVsaW5nIGZvciBpbnBsYWNlIGNvcHkKdXBkYXRlcy4gTm90IHRoYXQgSSB3aXNoIHRv
IGVuY291cmFnZSBhbnlvbmUgdG8gdXNlIGZyb250YnVmZmVyCnJlbmRlcmluZy4KLUNocmlzCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
