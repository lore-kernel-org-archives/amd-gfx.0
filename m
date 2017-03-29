From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 4/6] drm/amd/amdgpu: Pin bos from imported dma-bufs to GTT.
Date: Wed, 29 Mar 2017 18:07:59 +0900
Message-ID: <195054e4-cd93-0866-083a-eddafa3400e5@daenzer.net>
References: <20170329002720.11445-1-raof@ubuntu.com>
 <20170329002720.11445-5-raof@ubuntu.com>
 <5e5813f0-2efb-cb00-5a87-8894068ec5fc@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <5e5813f0-2efb-cb00-5a87-8894068ec5fc@vodafone.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>, raof@ubuntu.com
Cc: amd-gfx@lists.freedesktop.org, Christopher James Halse Rogers <christopher.halse.rogers@canonical.com>, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMjkvMDMvMTcgMDQ6MTQgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMjkuMDMu
MjAxNyB1bSAwMjoyNyBzY2hyaWViIHJhb2ZAdWJ1bnR1LmNvbToKPj4gRnJvbTogQ2hyaXN0b3Bo
ZXIgSmFtZXMgSGFsc2UgUm9nZXJzCj4+IDxjaHJpc3RvcGhlci5oYWxzZS5yb2dlcnNAY2Fub25p
Y2FsLmNvbT4KPj4KPj4gQXR0ZW1wdGluZyB0byBtaWdyYXRlIHRoZSBibyB3aWxsIGJyZWFrIHRo
ZSBzaGFyaW5nIG9mIHRoZSBidWZmZXIuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waGVy
IEphbWVzIEhhbHNlIFJvZ2Vycwo+PiA8Y2hyaXN0b3BoZXIuaGFsc2Uucm9nZXJzQGNhbm9uaWNh
bC5jb20+Cj4+IENDOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IAo+IE5BSyBvbiB0
aGlzIG9uZSBhbmQgdGhlIHJhZGVvbiB2ZXJzaW9uLgo+IAo+IFdlIGNhbid0IG1pZ3JhdGUgdGhl
IGJ1ZmZlcnMgdG8gVlJBTSwgYnV0IHdlIHNob3VsZG4ndCBwaW4gaXQgZWl0aGVyCj4gY2F1c2Ug
dGhhdCB3aWxsIGxvY2sgZG93biB0aGUgR1RUIHNwYWNlIHVzZWQgZm9yIGl0LgoKQWgsIGdvb2Qg
cG9pbnQsIGRpZG4ndCB0aGluayBvZiB0aGF0LgoKCj4gSW5zdGVhZCB5b3Ugc2hvdWxkIG1vZGlm
eSBhbWRncHVfYm9fcGluKCkgYW5kIGZhaWwgaWYgYW55Ym9keSB0cmllcyB0bwo+IG1pZ3JhdGUg
YSBCTyB3aGljaCBoYXMgcHJpbWVfc2hhcmVkX2NvdW50ICE9IDAgdG8gVlJBTSAoeW91IG1pZ3Ro
IG5lZWQKPiB0byBhZGQgdGhpcyBmb3IgcmFkZW9uKS4KClRoaXMgd291bGQgYWxzbyBuZWVkIHRv
IGJlIGNoZWNrZWQgaW4gdGhlIEFNREdQVV9HRU1fT1BfU0VUX1BMQUNFTUVOVApjYXNlIG9mIGFt
ZGdwdV9nZW1fb3BfaW9jdGwsIG90aGVyd2lzZSB1c2Vyc3BhY2UgY2FuIGNoYW5nZQpwcmVmZXJl
ZF9kb21haW5zIHRvIEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0sIGFuZCB1c2luZyB0aGUgQk8gZm9y
IEdQVQpvcGVyYXRpb25zIG1heSBtb3ZlIGl0IHRvIFZSQU0uCgpPciBtYXliZSB0aGVyZSdzIGEg
Y2VudHJhbCBwbGFjZSB3aGljaCBjYW4gY2F0Y2ggYm90aCBvZiB0aGVzZSBjYXNlcwooYW5kIGFu
eSBvdGhlcnMpLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8
ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lh
c3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxp
bmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
