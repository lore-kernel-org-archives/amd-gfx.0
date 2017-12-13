From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 2/3] drm/amd/amdgpu: init allow_reserved_eviction and resv
 when create a new bo
Date: Wed, 13 Dec 2017 11:03:19 +0100
Message-ID: <91121ff7-1413-b86d-8f98-8023c20c6b89@daenzer.net>
References: <1513142278-4294-1-git-send-email-Hongbo.He@amd.com>
 <1513142278-4294-2-git-send-email-Hongbo.He@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1513142278-4294-2-git-send-email-Hongbo.He@amd.com>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Roger He <Hongbo.He@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxNy0xMi0xMyAwNjoxNyBBTSwgUm9nZXIgSGUgd3JvdGU6Cj4gQ2hhbmdlLUlkOiBJMGM2
NTcxYzJhNjRlNmM1YmRhZDgwY2NiY2NjYjQwZWJhMWMyMGI0ZQo+IFNpZ25lZC1vZmYtYnk6IFJv
Z2VyIEhlIDxIb25nYm8uSGVAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X29iamVjdC5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X29iamVjdC5jCj4gaW5kZXggZGMwYThiZS4uN2M3ZjU2ZjUgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gQEAgLTMyNyw3ICszMjcsNyBAQCBz
dGF0aWMgaW50IGFtZGdwdV9ib19kb19jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
Cj4gIAkJCSAgICAgICB1aW50NjRfdCBpbml0X3ZhbHVlLAo+ICAJCQkgICAgICAgc3RydWN0IGFt
ZGdwdV9ibyAqKmJvX3B0cikKPiAgewo+IC0Jc3RydWN0IHR0bV9vcGVyYXRpb25fY3R4IGN0eCA9
IHsgIWtlcm5lbCwgZmFsc2UgfTsKPiArCXN0cnVjdCB0dG1fb3BlcmF0aW9uX2N0eCBjdHggPSB7
ICFrZXJuZWwsIGZhbHNlLCB0cnVlLCByZXN2IH07CgpQbGVhc2UgdXNlIG5hbWVkIGluaXRpYWxp
emVycywgdG8gbWFrZSBpdCBlYXNpZXIgdG8gdW5kZXJzdGFuZCB3aGljaApmaWVsZCBpcyBpbml0
aWFsaXplZCB0byB3aGljaCB2YWx1ZS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0
d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZl
bG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJp
LWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
