From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [PATCH libdrm] libdrm/amdgpu: add interface for kernel semaphores
Date: Tue, 14 Mar 2017 18:54:05 +0100
Message-ID: <CAKMK7uFN3qZ28RHkhemDkw4waPmgbmohOZGpv9MexbUj-AD_8w@mail.gmail.com>
References: <20170314005054.7487-1-airlied@gmail.com>
 <20170314005054.7487-2-airlied@gmail.com>
 <58C74ECE.3090703@amd.com>
 <CAPM=9tzegdtiyEmbW+PqmVeQ+bXrNtrdKXuE3kB0dPMKnMir+Q@mail.gmail.com>
 <58C763E0.1@amd.com> <20170314085456.rthxyeuffdz3ex4p@phenom.ffwll.local>
 <0d1620f3-c77b-d731-6a9a-8db9fca289cc@vodafone.de> <58C7C032.7060706@amd.com>
 <8dea3303-480d-c29a-22ec-42adf3dab4ce@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8dea3303-480d-c29a-22ec-42adf3dab4ce-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

T24gVHVlLCBNYXIgMTQsIDIwMTcgYXQgNjo0NSBQTSwgSGFycnkgV2VudGxhbmQgPGhhcnJ5Lndl
bnRsYW5kQGFtZC5jb20+IHdyb3RlOgo+Pj4gImludGVybmFsIHRlYW1zIHNpbXBseSBkbyBub3Qg
aGF2ZSBkZXNpZ24gYXV0aG9yaXR5IG9uIHN0dWZmIGxpa2UgdGhhdCIKPj4+Cj4+PiBDYW4gSSBw
cmludCB0aGF0IG9uIGEgdC1zaGlydCBhbmQgc3RhcnQgdG8gc2VsbCBpdD8KPj4KPj4gSSBndWVz
cyB5b3UgY2Fubm90IGRyZXNzIGl0IHRvIGdvIHRvIG9mZmljZS4uOikKPj4KPgo+IEknZCB3ZWFy
IGl0IHRvIHRoZSBvZmZpY2UuCj4KPiBodHRwczovL3d3dy5jdXN0b21pbmsuY29tL2xhYj9jaWQ9
aGtwMC0wMGF5LTZ2amcKCkNhbiB3ZSBoYXZlIGEgcGljdHVyZSBvZiB0aGUgZW50aXJlIGFtZCB0
ZWFtIHdlYXJpbmcgdGhlc2U/IDotKQoKQW55d2F5LCBJIGFwcHJvdmUuCi1EYW5pZWwKLS0gCkRh
bmllbCBWZXR0ZXIKU29mdHdhcmUgRW5naW5lZXIsIEludGVsIENvcnBvcmF0aW9uCis0MSAoMCkg
NzkgMzY1IDU3IDQ4IC0gaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
