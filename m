From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Subject: Re: [PATCH 4/6] drm/amd/amdgpu: Pin bos from imported dma-bufs to GTT.
Date: Wed, 29 Mar 2017 11:11:08 +0200
Message-ID: <7ef0dc46-c1bc-ca1b-864d-da2e63997f35@vodafone.de>
References: <20170329002720.11445-1-raof@ubuntu.com>
 <20170329002720.11445-5-raof@ubuntu.com>
 <5e5813f0-2efb-cb00-5a87-8894068ec5fc@vodafone.de>
 <195054e4-cd93-0866-083a-eddafa3400e5@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <195054e4-cd93-0866-083a-eddafa3400e5@daenzer.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, raof@ubuntu.com
Cc: dri-devel@lists.freedesktop.org, Christopher James Halse Rogers <christopher.halse.rogers@canonical.com>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjkuMDMuMjAxNyB1bSAxMTowNyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDI5LzAz
LzE3IDA0OjE0IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAyOS4wMy4yMDE3IHVt
IDAyOjI3IHNjaHJpZWIgcmFvZkB1YnVudHUuY29tOgo+Pj4gRnJvbTogQ2hyaXN0b3BoZXIgSmFt
ZXMgSGFsc2UgUm9nZXJzCj4+PiA8Y2hyaXN0b3BoZXIuaGFsc2Uucm9nZXJzQGNhbm9uaWNhbC5j
b20+Cj4+Pgo+Pj4gQXR0ZW1wdGluZyB0byBtaWdyYXRlIHRoZSBibyB3aWxsIGJyZWFrIHRoZSBz
aGFyaW5nIG9mIHRoZSBidWZmZXIuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZXIg
SmFtZXMgSGFsc2UgUm9nZXJzCj4+PiA8Y2hyaXN0b3BoZXIuaGFsc2Uucm9nZXJzQGNhbm9uaWNh
bC5jb20+Cj4+PiBDQzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gTkFLIG9uIHRo
aXMgb25lIGFuZCB0aGUgcmFkZW9uIHZlcnNpb24uCj4+Cj4+IFdlIGNhbid0IG1pZ3JhdGUgdGhl
IGJ1ZmZlcnMgdG8gVlJBTSwgYnV0IHdlIHNob3VsZG4ndCBwaW4gaXQgZWl0aGVyCj4+IGNhdXNl
IHRoYXQgd2lsbCBsb2NrIGRvd24gdGhlIEdUVCBzcGFjZSB1c2VkIGZvciBpdC4KPiBBaCwgZ29v
ZCBwb2ludCwgZGlkbid0IHRoaW5rIG9mIHRoYXQuCj4KPgo+PiBJbnN0ZWFkIHlvdSBzaG91bGQg
bW9kaWZ5IGFtZGdwdV9ib19waW4oKSBhbmQgZmFpbCBpZiBhbnlib2R5IHRyaWVzIHRvCj4+IG1p
Z3JhdGUgYSBCTyB3aGljaCBoYXMgcHJpbWVfc2hhcmVkX2NvdW50ICE9IDAgdG8gVlJBTSAoeW91
IG1pZ3RoIG5lZWQKPj4gdG8gYWRkIHRoaXMgZm9yIHJhZGVvbikuCj4gVGhpcyB3b3VsZCBhbHNv
IG5lZWQgdG8gYmUgY2hlY2tlZCBpbiB0aGUgQU1ER1BVX0dFTV9PUF9TRVRfUExBQ0VNRU5UCj4g
Y2FzZSBvZiBhbWRncHVfZ2VtX29wX2lvY3RsLCBvdGhlcndpc2UgdXNlcnNwYWNlIGNhbiBjaGFu
Z2UKPiBwcmVmZXJlZF9kb21haW5zIHRvIEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0sIGFuZCB1c2lu
ZyB0aGUgQk8gZm9yIEdQVQo+IG9wZXJhdGlvbnMgbWF5IG1vdmUgaXQgdG8gVlJBTS4KCkdvb2Qg
cG9pbnQgYXMgd2VsbCwgdGhhdCBpbmRlZWQgYWxzbyBuZWVkcyB0byBiZSBmb3JiaWRkZW4uCgo+
IE9yIG1heWJlIHRoZXJlJ3MgYSBjZW50cmFsIHBsYWNlIHdoaWNoIGNhbiBjYXRjaCBib3RoIG9m
IHRoZXNlIGNhc2VzCj4gKGFuZCBhbnkgb3RoZXJzKS4KCkF0IGxlYXN0IG9mIGhhbmQgSSBjYW4n
dCB0aGluayBvZiBhbnkuIEJ1dCBjYXRjaGluZyB0aG9zZSB0d28gY2FzZXMgCnNob3VsZCBiZSBz
dWZmaWNpZW50IGFzIGZhciBhcyBJIGNhbiBzZWUuCgpDaHJpc3RpYW4uCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0
CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
