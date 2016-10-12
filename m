From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/6] drm/amdgpu/powerplay: add an implementation for
 get_vce_clock_table
Date: Wed, 12 Oct 2016 17:11:48 -0400
Message-ID: <CADnq5_OT26ScfS8kvBPyzapFi+-=O8BMy59U286LWBLvXPgyag@mail.gmail.com>
References: <1475864905-21269-1-git-send-email-alexander.deucher@amd.com>
 <1475864905-21269-5-git-send-email-alexander.deucher@amd.com>
 <CADnq5_MFT8M8VRu17gOcZjjRCK9Z-c3mG7=V46BQhYZXMKMetA@mail.gmail.com>
 <CY4PR12MB16871A098341B047DBA0DEADFBDD0@CY4PR12MB1687.namprd12.prod.outlook.com>
 <e8cdcd80-3df3-940f-32b5-9116e5d15fa6@vodafone.de>
 <CY4PR12MB168795F3CD0C3B58ED38828DFBDD0@CY4PR12MB1687.namprd12.prod.outlook.com>
 <4117134e-ff2f-808d-4354-3e51c2410724@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4117134e-ff2f-808d-4354-3e51c2410724-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Boyuan" <Boyuan.Zhang-5C7GfCeVMHo@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Fang,
 Peter" <Peter.Fang-5C7GfCeVMHo@public.gmane.org>

T24gV2VkLCBPY3QgMTIsIDIwMTYgYXQgNTo1NiBBTSwgQ2hyaXN0aWFuIEvDtm5pZwo8ZGVhdGhz
aW1wbGVAdm9kYWZvbmUuZGU+IHdyb3RlOgo+IEhpIFJleCwKPgo+IFNvIGFtZF92Y2Vfc3RhdGUg
aXMgb3VyIGhhcmR3YXJlIHJlcHJlc2VudGF0aW9uIGFuZAo+IGRybV9hbWRncHVfaW5mb192Y2Vf
Y2xvY2tfdGFibGUgaXMgdGhlIElPQ1RMIGludGVyZmFjZSBzdHJ1Y3R1cmU/IElzIHRoZXJlIGEK
PiByZWFzb24gZm9yIG5vdCB1c2luZyBkcm1fYW1kZ3B1X2luZm9fdmNlX2Nsb2NrX3RhYmxlIGRp
cmVjdGx5IGluIHRoZSBodwo+IG1hbmFnZXIsIGV4Y2VwdCB0aGF0IHdlIGRvbid0IHdhbnQgdG8g
aW5jbHVkZSB0aGUgSU9DVEwgaW50ZXJmYWNlIGhlcmU/Cj4KPiBDYXVzZSB0aGF0IHdvdWxkIGF0
IGxlYXN0IGJlIGEgYml0IGF3a3dhcmQsIHRoaXMgaXMgYW4gZXh0cmEgYWJzdHJhY3Rpb24KPiBs
YXllciB3ZSB1c3VhbGx5IHRyeSB0byBhdm9pZCB1cHN0cmVhbS4KPgo+IEknbSBmaW5lIHdpdGgg
dGhpcyBhcHByb2FjaCBmb3IgdGhpcyB1c2UgY2FzZSwgYnV0IHdoZW4gd2UgZ2V0IG1vcmUgYW5k
IG1vcmUKPiBwb3dlciBtYW5hZ2VtZW50IGV4cG9zZWQgdG8gdXNlcnNwYWNlIHRoaXMgY291bGQg
cmFpc2Ugb2JqZWN0aW9ucyBjYXVzZSB0aGlzCj4gZXNzZW50aWFsbHkgbWVhbnMgd2UgbmVlZCB0
byBkdXBsaWNhdGUgYWxsIGludGVybmFsIHBvd2VyIG1hbmFnZW1lbnQKPiBzdHJ1Y3R1cmVzIGZv
ciB0aGUgcHVibGljIGludGVyZmFjZSBhZ2Fpbi4KCkl0J3Mgb25seSBuZWVkZWQgZm9yIGEgc3Vi
c2V0IG9mIGFzaWNzIChzb21lIENJIGFuZCBWSSBwYXJ0cykuCkV2ZXJ5dGhpbmcgZWxzZSBnZXRz
IGhhbmRsZWQgaW4gdGhlIGZpcm13YXJlIHNpbWlsYXIgdG8gVVZEIERQTS4KCkFsZXgKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
