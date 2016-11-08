From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: disable the VRAM manager on special
 placements v2
Date: Tue, 8 Nov 2016 14:09:35 +0100
Message-ID: <508632be-2cfc-de34-4ad7-68fb518c9d68@vodafone.de>
References: <1478257213-1946-1-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1478257213-1946-1-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "Qu, Jim" <Jim.Qu-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>

QW0gMDQuMTEuMjAxNiB1bSAxMjowMCBzY2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4gRnJvbTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Cj4gVGhpcyBkaXNh
YmxlcyB0aGUgVlJBTSBtYW5hZ2VyIHdoZW4gYSBzcGVjaWFsIHBsYWNlbWVudCBpcyByZXF1ZXN0
ZWQsIG90aGVyd2lzZQo+IHdlIHBsYXkgcGluZy9wb25nIHdpdGggdGhlIGJ1ZmZlcnMgb24gZXZl
cnkgY29tbWFuZCBzdWJtaXNzaW9uLgo+Cj4gdjI6IG9ubHkgY2hlY2sgbHBmbgo+Cj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKQ291
bGQgYW55Ym9keSBnaXZlIGEgUmV2aWV3ZWQtYnkgZm9yIHRoaXM/IEkgdGhpbmsgdGhhdCBpcyBh
IHJhdGhlciAKaW1wb3J0YW50IHBlcmZvcm1hbmNlIGJ1ZyBmaXguCgpSZWdhcmRzLApDaHJpc3Rp
YW4uCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdy
LmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJh
bV9tZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cmFtX21nci5jCj4g
aW5kZXggMTgwZWVkN2MuLmQ3MTAyMjYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdnJhbV9tZ3IuYwo+IEBAIC0xMDgsNyArMTA4LDcgQEAgc3RhdGljIGludCBh
bWRncHVfdnJhbV9tZ3JfbmV3KHN0cnVjdCB0dG1fbWVtX3R5cGVfbWFuYWdlciAqbWFuLAo+ICAg
CQlscGZuID0gbWFuLT5zaXplOwo+ICAgCj4gICAJaWYgKGJvLT5mbGFncyAmIEFNREdQVV9HRU1f
Q1JFQVRFX1ZSQU1fQ09OVElHVU9VUyB8fAo+IC0JICAgIGFtZGdwdV92cmFtX3BhZ2Vfc3BsaXQg
PT0gLTEpIHsKPiArCSAgICBwbGFjZS0+bHBmbiB8fCBhbWRncHVfdnJhbV9wYWdlX3NwbGl0ID09
IC0xKSB7Cj4gICAJCXBhZ2VzX3Blcl9ub2RlID0gfjB1bDsKPiAgIAkJbnVtX25vZGVzID0gMTsK
PiAgIAl9IGVsc2UgewoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
