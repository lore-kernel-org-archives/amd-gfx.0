From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] drm: introduce DRIVER_FORCE_AUTH
Date: Wed, 3 Jul 2019 15:51:51 +0100
Message-ID: <CACvgo53TPuEVsyfeA5MfWdNEvVm=36+0dmqtYtWgM8Cc6q8Tcg@mail.gmail.com>
References: <744310ce-4546-4406-ad8d-49af0f06cd49@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <744310ce-4546-4406-ad8d-49af0f06cd49-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gV2VkLCAzIEp1bCAyMDE5IGF0IDE1OjMzLCBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPiB3cm90ZToKPiBBbSAwMy4wNy4yMDE5IDE2OjAwIHNjaHJpZWIgRW1p
bCBWZWxpa292IDxlbWlsLmwudmVsaWtvdkBnbWFpbC5jb20+Ogo+Cj4gT24gV2VkLCAzIEp1bCAy
MDE5IGF0IDE0OjQ4LCBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29t
PiB3cm90ZToKPiA+Cj4gPiBXZWxsIHRoaXMgaXMgc3RpbGwgYSBOQUsuCj4gPgo+ID4gQXMgc3Rh
dGVkIHByZXZpb3VzbHkgcGxlYXNlIGp1c3QgZG9uJ3QgcmVtb3ZlIERSTV9BVVRIIGFuZCBrZWVw
IHRoZSBmdW5jdGlvbmFsaXR5IGFzIGl0IGlzLgo+ID4KPiBBRkFJQ1Qgbm9ib2R5IHdhcyBpbiBm
YXZvdXIgb2YgeW91ciBzdWdnZXN0aW9uIHRvIHJlbW92ZSBEUk1fQVVUSCBmcm9tCj4gdGhlIGhh
bmRsZSB0by9mcm9tIGZkIGlvY2x0cy4KPiBUaHVzIHRoaXMgc2VlbXMgbGlrZSB0aGUgc2Vjb25k
IGJlc3Qgb3B0aW9uLgo+Cj4KPiBXZWxsIGp1c3Qga2VlcCBpdC4gQXMgSSBzYWlkIHBsZWFzZSBk
b24ndCBjaGFuZ2UgYW55dGhpbmcgaGVyZS4KPgo+IERyb3BwaW5nIERSTV9BVVRIIGZyb20gdGhl
IGRyaXZlciBJT0NUTHMgd2FzIHN1ZmZpY2llbnQgdG8gd29yayBhcm91bmQgdGhlIHByb2JsZW1z
IGF0IGhhbmQgZmFyIGFzIEkga25vdy4KPgpXZSBhbHNvIG5lZWQgdGhlIERSTV9BVVRIIGZvciBo
YW5kbGUgdG8vZnJvbSBmZCBvbmVzLiBNZXNhIGRyaXZlcnMgdXNlCnRob3NlIGlvY3Rscy4KCi1F
bWlsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
