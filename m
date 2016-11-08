From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Attach exclusive fence to prime exported
 bo's. (v3)
Date: Tue, 8 Nov 2016 11:13:31 +0100
Message-ID: <3af56579-e19e-2a1c-1ce2-447e1b7e3ea8@vodafone.de>
References: <1478486854-30715-1-git-send-email-mario.kleiner.de@gmail.com>
 <aec496f1-9a5d-d7c5-1f6f-bfce991b510e@daenzer.net>
 <b646067a-71ee-71b8-744c-96b2e96db0b8@vodafone.de>
 <2969084b-e63c-a852-c17c-fe7ac9110153@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2969084b-e63c-a852-c17c-fe7ac9110153-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

QW0gMDcuMTEuMjAxNiB1bSAyMDoyMCBzY2hyaWViIE1hcmlvIEtsZWluZXI6Cj4gT24gMTEvMDcv
MjAxNiAwODo1NSBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMDcuMTEuMjAxNiB1
bSAwNDoyOSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+PiBBbHNvLCBJIHRoaW5rIHdlIHNob3Vs
ZCBzZXQgYm8tPnByaW1lX2V4cG9ydGVkIChwcmltZV9zaGFyZWQ/KSBpbgo+PiBhbWRncHVfZ2Vt
X3ByaW1lX2ltcG9ydF9zZ190YWJsZSBhcyB3ZWxsLCBzbyB0aGF0IHdlJ2xsIGFsc28gc2V0Cj4+
IGV4Y2x1c2l2ZSBmZW5jZXMgb24gQk9zIGltcG9ydGVkIGZyb20gb3RoZXIgR1BVcy4KPj4gWWVz
LCByZWFsbHkgZ29vZCBpZGVhLgo+Pgo+Cj4gT2suIEkgZ3Vlc3Mgd2UgZG9uJ3QgbmVlZCB0byB3
YWl0IGZvciBmZW5jZXMgdGhlcmUgYmVmb3JlIHNldHRpbmcgdGhlIAo+IGZsYWcvY291bnRlciwg
YXMgd2UgY2FuJ3QgaGF2ZSBkb25lIGFueXRoaW5nIHlldCB3aXRoIHRoZSBibyBqdXN0IAo+IGNy
ZWF0ZWQgZnJvbSB0aGUgaW1wb3J0ZWQgc2dfdGFibGU/CgpDb3JyZWN0LCB3YWl0aW5nIGF0IHRo
aXMgcG9pbnQgc2hvdWxkbid0IGJlIG5lY2Vzc2FyeS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
