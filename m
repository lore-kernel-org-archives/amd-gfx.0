From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: Delete a redundant memory setting in
 vega20_set_default_od8_setttings()
Date: Mon, 17 Jun 2019 11:06:14 -0400
Message-ID: <CADnq5_MKRU6-iCJZWwpR8z+mmdkgVh_STJtVJCiSTec21e+oqA@mail.gmail.com>
References: <de3f6a5e-8ac4-bc8e-0d0c-3a4a5db283e9@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <de3f6a5e-8ac4-bc8e-0d0c-3a4a5db283e9-S0/GAf8tV78@public.gmane.org>
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
To: Markus Elfring <Markus.Elfring-S0/GAf8tV78@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>, Rex Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

QXBwbGllZCB0aGlzIGFuZCB0aGUgZGMgcGF0Y2guCgpUaGFua3MhCgpBbGV4CgpPbiBNb24sIEp1
biAxNywgMjAxOSBhdCAxMDowNyBBTSBNYXJrdXMgRWxmcmluZyA8TWFya3VzLkVsZnJpbmdAd2Vi
LmRlPiB3cm90ZToKPgo+IEZyb206IE1hcmt1cyBFbGZyaW5nIDxlbGZyaW5nQHVzZXJzLnNvdXJj
ZWZvcmdlLm5ldD4KPiBEYXRlOiBNb24sIDE3IEp1biAyMDE5IDE0OjI0OjE0ICswMjAwCj4KPiBU
aGUgbWVtb3J5IHdhcyBzZXQgdG8gemVybyBhbHJlYWR5IGJ5IGEgY2FsbCBvZiB0aGUgZnVuY3Rp
b24g4oCca3phbGxvY+KAnS4KPiBUaHVzIHJlbW92ZSBhbiBleHRyYSBjYWxsIG9mIHRoZSBmdW5j
dGlvbiDigJxtZW1zZXTigJ0gZm9yIHRoaXMgcHVycG9zZS4KPgo+IFRoaXMgaXNzdWUgd2FzIGRl
dGVjdGVkIGJ5IHVzaW5nIHRoZSBDb2NjaW5lbGxlIHNvZnR3YXJlLgo+Cj4gU2lnbmVkLW9mZi1i
eTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0Pgo+IC0tLQo+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS92ZWdhMjBfcHB0LmMgfCAxIC0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS92ZWdhMjBfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS92ZWdhMjBfcHB0LmMKPiBpbmRleCA0YWE4ZjVhNjljNGMuLjYyNDk3YWQ2NmEzOSAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS92ZWdhMjBfcHB0LmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS92ZWdhMjBfcHB0LmMKPiBAQCAtMTI5
NSw3ICsxMjk1LDYgQEAgc3RhdGljIGludCB2ZWdhMjBfc2V0X2RlZmF1bHRfb2Q4X3NldHR0aW5n
cyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKPiAgICAgICAgIGlmICghdGFibGVfY29udGV4dC0+
b2Q4X3NldHRpbmdzKQo+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKPgo+IC0gICAg
ICAgbWVtc2V0KHRhYmxlX2NvbnRleHQtPm9kOF9zZXR0aW5ncywgMCwgc2l6ZW9mKHN0cnVjdCB2
ZWdhMjBfb2Q4X3NldHRpbmdzKSk7Cj4gICAgICAgICBvZDhfc2V0dGluZ3MgPSAoc3RydWN0IHZl
Z2EyMF9vZDhfc2V0dGluZ3MgKil0YWJsZV9jb250ZXh0LT5vZDhfc2V0dGluZ3M7Cj4KPiAgICAg
ICAgIGlmIChzbXVfZmVhdHVyZV9pc19lbmFibGVkKHNtdSwgRkVBVFVSRV9EUE1fU09DQ0xLX0JJ
VCkpIHsKPiAtLQo+IDIuMjIuMAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
