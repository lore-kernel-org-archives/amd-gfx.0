From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] drm: fix missing mutex unlock before return
Date: Mon, 7 Aug 2017 15:47:30 -0400
Message-ID: <CADnq5_M_z23vmgnDnx5rSeJW=z+MaYFrrpsSeXpv3913FNZxzw@mail.gmail.com>
References: <1502116512-14264-1-git-send-email-Monk.Liu@amd.com>
 <3fa1478e-4701-343c-0288-e8c41eb1f2c4@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3fa1478e-4701-343c-0288-e8c41eb1f2c4-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

T24gTW9uLCBBdWcgNywgMjAxNyBhdCAxMDo0NiBBTSwgQ2hyaXN0aWFuIEvDtm5pZwo8ZGVhdGhz
aW1wbGVAdm9kYWZvbmUuZGU+IHdyb3RlOgo+IEFtIDA3LjA4LjIwMTcgdW0gMTY6MzUgc2Nocmll
YiBNb25rIExpdToKPj4KPj4gRnJvbTogTW9uayBMaXUgPG1vbmsubGl1QGFtZC5jb20+Cj4+Cj4+
IENoYW5nZS1JZDogSTM3N2RkZTk3NjY0OGQ1M2JjOWEzYTJkNWJhMjk0YzI4NDkxMGIxMDkKPj4g
U2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPG1vbmsubGl1QGFtZC5jb20+Cj4KPgo+IFJldmlld2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGZvciB0aGlz
IG9uZS4KCkFwcGxpZWQgdXBzdHJlYW0uICB0aGFua3MhCgpBbGV4Cgo+Cj4+IC0tLQo+PiAgIGFt
ZGdwdS9hbWRncHVfYm8uYyB8IDEgKwo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQo+Pgo+PiBkaWZmIC0tZ2l0IGEvYW1kZ3B1L2FtZGdwdV9iby5jIGIvYW1kZ3B1L2FtZGdwdV9i
by5jCj4+IGluZGV4IGVjOTk0ODguLjA3ZWI3NDMgMTAwNjQ0Cj4+IC0tLSBhL2FtZGdwdS9hbWRn
cHVfYm8uYwo+PiArKysgYi9hbWRncHUvYW1kZ3B1X2JvLmMKPj4gQEAgLTI5Nyw2ICsyOTcsNyBA
QCBpbnQgYW1kZ3B1X2JvX2ltcG9ydChhbWRncHVfZGV2aWNlX2hhbmRsZSBkZXYsCj4+ICAgICAg
ICAgICAgICAgICAvKiBHZXQgYSBLTVMgaGFuZGxlLiAqLwo+PiAgICAgICAgICAgICAgICAgciA9
IGRybVByaW1lRkRUb0hhbmRsZShkZXYtPmZkLCBzaGFyZWRfaGFuZGxlLCAmaGFuZGxlKTsKPj4g
ICAgICAgICAgICAgICAgIGlmIChyKSB7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHB0aHJl
YWRfbXV0ZXhfdW5sb2NrKCZkZXYtPmJvX3RhYmxlX211dGV4KTsKPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIHI7Cj4+ICAgICAgICAgICAgICAgICB9Cj4+Cj4KPgo+Cj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
