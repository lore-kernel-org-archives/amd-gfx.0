From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/7] drm/amdgpu: update the shadow PD together with the
 real one
Date: Thu, 29 Sep 2016 12:51:14 -0400
Message-ID: <CADnq5_NPbBn8fxp7beYxAtdVDihciTL_yNRAwCi60d2t2P5uuA@mail.gmail.com>
References: <1475135557-11537-1-git-send-email-deathsimple@vodafone.de>
 <1475135557-11537-2-git-send-email-deathsimple@vodafone.de>
 <57ECDC65.40203@amd.com> <5ad68770-f356-33b6-a3d0-7cec66c56ca3@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5ad68770-f356-33b6-a3d0-7cec66c56ca3-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
Cc: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gVGh1LCBTZXAgMjksIDIwMTYgYXQgODoxMCBBTSwgQ2hyaXN0aWFuIEvDtm5pZwo8ZGVhdGhz
aW1wbGVAdm9kYWZvbmUuZGU+IHdyb3RlOgo+IEFtIDI5LjA5LjIwMTYgdW0gMTE6MTggc2Nocmll
YiB6aG91Y20xOgo+Pgo+Pgo+Pgo+PiBPbiAyMDE25bm0MDnmnIgyOeaXpSAxNTo1MiwgQ2hyaXN0
aWFuIEvDtm5pZyB3cm90ZToKPj4+Cj4+PiAtICAgIGlmIChjb3VudCkKPj4+ICsgICAgaWYgKGNv
dW50KSB7Cj4+PiArICAgICAgICBpZiAodm0tPnBhZ2VfZGlyZWN0b3J5LXNoYWRvdykKPj4KPj4g
Rm9yZ2V0IGNvbXBpbGUgZml4IHRvIGFtZW5kPwo+Cj4KPiBVcHMsIG5vIHRoYXQgYWN0dWFsbHkg
Y29tcGlsZXMgYmVjYXVzZSB3ZSBoYXZlIGEgbG9jYWwgdmFyaWFibGUgbmFtZWQKPiAic2hhZG93
IiAoYW5kIGJ5IGNvaW5jaWRlbnQgYWN0dWFsbHkgZG9lcyB3aGF0IGl0IHNob3VsZCBkbykuCj4K
PiBBbnl3YXkgY2xlYXJseSBhIHR5cG8uIENhbiBJIGdldCB5b3VyIHJiIGZvciB0aGUgc2VyaWVz
PwoKV2l0aCB0aGF0IGZpeGVkLCB0aGlzIHBhdGNoIGlzOgpSZXZpZXdlZC1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFu
Lgo+Cj4KPj4KPj4gUmVnYXJkcywKPj4gRGF2aWQgWmhvdQo+Pj4KPj4+ICsgYW1kZ3B1X3ZtX2Rv
X3NldF9wdGVzKCZwYXJhbXMsIGxhc3Rfc2hhZG93LCBsYXN0X3B0LAo+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgY291bnQsIGluY3IsIEFNREdQVV9QVEVfVkFMSUQpOwo+Pgo+Pgo+PiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4
IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPgo+Cj4KPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZngg
bWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
