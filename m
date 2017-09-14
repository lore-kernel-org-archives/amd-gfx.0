From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: revert tile table update for oland
Date: Thu, 14 Sep 2017 19:57:37 +0200
Message-ID: <20170914195737.40463b07@endymion>
References: <20170911174356.31cb7ef3@endymion>
 <CAAxE2A7N_DjN0ooxnPi3To70S5q2ihF4jeO0SXvUbEOKz37Pew@mail.gmail.com>
 <CADnq5_Ns2c6xy6Tce9iuaqV5WLCEjD43fCVE-F43RK_tcCpubA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_Ns2c6xy6Tce9iuaqV5WLCEjD43fCVE-F43RK_tcCpubA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, Christian =?UTF-8?B?S8O2bmln?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gVGh1LCAxNCBTZXAgMjAxNyAxMjozMToyOSAtMDQwMCwgQWxleCBEZXVjaGVyIHdyb3RlOgo+
IE9uIFRodSwgU2VwIDE0LCAyMDE3IGF0IDEyOjIxIFBNLCBNYXJlayBPbMWhw6FrIDxtYXJhZW9A
Z21haWwuY29tPiB3cm90ZToKPiA+IFJldmlld2VkLWJ5OiBNYXJlayBPbMWhw6FrIDxtYXJlay5v
bHNha0BhbWQuY29tPiAgCj4gCj4gQXBwbGllZC4gIHRoYW5rcy4KPiAKPiBBbGV4CgpUaGFua3Mu
IEkgZm9yZ290IHRoZSB0YWcgYnV0IHRoaXMgaXMgb2J2aW91c2x5IGEgY2FuZGlkYXRlIGZvciBz
dGFibGUKdHJlZXMuIEkgaGF2ZSBwcmVwYXJlZCAgZGlmZmVyZW50IHZlcnNpb24gZm9yIG9sZGVy
IGtlcm5lbHMgYWxyZWFkeSwKSSdsbCBwb3N0IGl0IHRvIHN0YWJsZUAgYWZ0ZXIgdGhlIGZpeCBp
cyBtZXJnZWQgaW50byBMaW51cycgdHJlZS4KCi0tIApKZWFuIERlbHZhcmUKU1VTRSBMMyBTdXBw
b3J0Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
