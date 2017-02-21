From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH xf86-video-ati 3/3] present: Wait for screen pixmap BO
 idle before setting modes for unflip
Date: Tue, 21 Feb 2017 16:08:54 -0500
Message-ID: <CADnq5_OiG-NXBhRJ-Nc+J=DuFTUCAkhLbB3J9fq8THBkhGcR3Q@mail.gmail.com>
References: <20170221090340.10647-1-michel@daenzer.net>
 <20170221090340.10647-4-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170221090340.10647-4-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

T24gVHVlLCBGZWIgMjEsIDIwMTcgYXQgNDowMyBBTSwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBk
YWVuemVyLm5ldD4gd3JvdGU6Cj4gRnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVy
QGFtZC5jb20+Cj4KPiBUbyBtYWtlIHN1cmUgdGhlIHNjcmVlbiBwaXhtYXAgY29udGVudHMgYXJl
IHVwIHRvIGRhdGUgd2hlbiBpdCBzdGFydHMKPiBiZWluZyBzY2FubmVkIG91dC4KPgo+IFNpZ25l
ZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgoKU2VyaWVz
IGlzOgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
PgoKPiAtLS0KPiAgc3JjL3JhZGVvbl9wcmVzZW50LmMgfCAyICsrCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9zcmMvcmFkZW9uX3ByZXNlbnQuYyBi
L3NyYy9yYWRlb25fcHJlc2VudC5jCj4gaW5kZXggYjM2ZTI5YjE5Li4xYjBkZGNiODIgMTAwNjQ0
Cj4gLS0tIGEvc3JjL3JhZGVvbl9wcmVzZW50LmMKPiArKysgYi9zcmMvcmFkZW9uX3ByZXNlbnQu
Ywo+IEBAIC00MDQsNiArNDA0LDggQEAgbW9kZXNldDoKPiAgICAgIG9sZF9mYl9pZCA9IGluZm8t
PmRybW1vZGUuZmJfaWQ7Cj4gICAgICBpbmZvLT5kcm1tb2RlLmZiX2lkID0gMDsKPgo+ICsgICAg
cmFkZW9uX2NzX2ZsdXNoX2luZGlyZWN0KHNjcm4pOwo+ICsgICAgcmFkZW9uX2JvX3dhaXQoaW5m
by0+ZnJvbnRfYm8pOwo+ICAgICAgZm9yIChpID0gMDsgaSA8IGNvbmZpZy0+bnVtX2NydGM7IGkr
Kykgewo+ICAgICAgICAgeGY4NkNydGNQdHIgY3J0YyA9IGNvbmZpZy0+Y3J0Y1tpXTsKPiAgICAg
ICAgIGRybW1vZGVfY3J0Y19wcml2YXRlX3B0ciBkcm1tb2RlX2NydGMgPSBjcnRjLT5kcml2ZXJf
cHJpdmF0ZTsKPiAtLQo+IDIuMTEuMAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
