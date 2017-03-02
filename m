From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH xf86-video-ati] Don't call radeon_cs_flush_indirect &
 radeon_bo_wait in drmmode_copy_fb
Date: Thu, 2 Mar 2017 09:19:47 -0500
Message-ID: <CADnq5_MrBvkhW=VjE8dXia1J3UfXi38iHgeRr7Fbj=ipcyraJw@mail.gmail.com>
References: <20170302072359.5152-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170302072359.5152-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVGh1LCBNYXIgMiwgMjAxNyBhdCAyOjIzIEFNLCBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRh
ZW56ZXIubmV0PiB3cm90ZToKPiBGcm9tOiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJA
YW1kLmNvbT4KPgo+IFJBREVPTldpbmRvd0V4cG9zdXJlc19vbmVzaG90IHRha2VzIGNhcmUgb2Yg
aXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1k
LmNvbT4KClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+Cgo+IC0tLQo+ICBzcmMvZHJtbW9kZV9kaXNwbGF5LmMgfCAzIC0tLQo+ICAxIGZpbGUgY2hh
bmdlZCwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9zcmMvZHJtbW9kZV9kaXNwbGF5
LmMgYi9zcmMvZHJtbW9kZV9kaXNwbGF5LmMKPiBpbmRleCBhNzkwNGEzOTYuLmFiMTE1ODNhNiAx
MDA2NDQKPiAtLS0gYS9zcmMvZHJtbW9kZV9kaXNwbGF5LmMKPiArKysgYi9zcmMvZHJtbW9kZV9k
aXNwbGF5LmMKPiBAQCAtNDkwLDkgKzQ5MCw2IEBAIHZvaWQgZHJtbW9kZV9jb3B5X2ZiKFNjcm5J
bmZvUHRyIHBTY3JuLCBkcm1tb2RlX3B0ciBkcm1tb2RlKQo+Cj4gICAgICAgICBGcmVlU2NyYXRj
aEdDKGdjKTsKPgo+IC0gICAgICAgcmFkZW9uX2NzX2ZsdXNoX2luZGlyZWN0KHBTY3JuKTsKPiAt
ICAgICAgIHJhZGVvbl9ib193YWl0KGluZm8tPmZyb250X2JvKTsKPiAtCj4gICAgICAgICBwU2Ny
ZWVuLT5jYW5Eb0JHTm9uZVJvb3QgPSBUUlVFOwo+ICAgICAgICAgZGVzdHJveV9waXhtYXBfZm9y
X2ZiY29uKHBTY3JuKTsKPiAgICAgICAgIHJldHVybjsKPiAtLQo+IDIuMTEuMAo+Cj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
