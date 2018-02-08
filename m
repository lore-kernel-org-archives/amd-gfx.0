From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add new device to use atpx quirk
Date: Thu, 8 Feb 2018 11:27:37 -0500
Message-ID: <CADnq5_NG3zpRXk-s3jdUWif01rzwrV92eFEx=J_NqnEHraxY_A@mail.gmail.com>
References: <20180208094601.26215-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180208094601.26215-1-kai.heng.feng@canonical.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVGh1LCBGZWIgOCwgMjAxOCBhdCA0OjQ2IEFNLCBLYWktSGVuZyBGZW5nCjxrYWkuaGVuZy5m
ZW5nQGNhbm9uaWNhbC5jb20+IHdyb3RlOgo+IFRoZSBhZmZlY3RlZCBzeXN0ZW0gKDB4MDgxMykg
aXMgcHJldHR5IHNpbWlsYXIgdG8gYW5vdGhlciBvbmUgKDB4MDgxMiksCj4gaXQgYWxzbyBuZWVk
cyB0byB1c2UgQVRQWCBwb3dlciBjb250cm9sLgo+Cj4gU2lnbmVkLW9mZi1ieTogS2FpLUhlbmcg
RmVuZyA8a2FpLmhlbmcuZmVuZ0BjYW5vbmljYWwuY29tPgoKQXBwbGllZC4gIHRoYW5rcyEKCkFs
ZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hdHB4X2hhbmRs
ZXIuYyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYXRweF9oYW5kbGVyLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYXRweF9oYW5kbGVyLmMKPiBpbmRleCBl
MmMzYzVlYzQyZDEuLmM1MzA5NWIzYjBmYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYXRweF9oYW5kbGVyLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYXRweF9oYW5kbGVyLmMKPiBAQCAtNTY4LDYgKzU2OCw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X3B4X3F1aXJrIGFtZGdwdV9weF9xdWlya19saXN0W10g
PSB7Cj4gICAgICAgICAvKiBIRyBfUFIzIGRvZXNuJ3Qgc2VlbSB0byB3b3JrIG9uIHRoaXMgQStB
IHdlc3RvbiBib2FyZCAqLwo+ICAgICAgICAgeyAweDEwMDIsIDB4NjkwMCwgMHgxMDAyLCAweDAx
MjQsIEFNREdQVV9QWF9RVUlSS19GT1JDRV9BVFBYIH0sCj4gICAgICAgICB7IDB4MTAwMiwgMHg2
OTAwLCAweDEwMjgsIDB4MDgxMiwgQU1ER1BVX1BYX1FVSVJLX0ZPUkNFX0FUUFggfSwKPiArICAg
ICAgIHsgMHgxMDAyLCAweDY5MDAsIDB4MTAyOCwgMHgwODEzLCBBTURHUFVfUFhfUVVJUktfRk9S
Q0VfQVRQWCB9LAo+ICAgICAgICAgeyAwLCAwLCAwLCAwLCAwIH0sCj4gIH07Cj4KPiAtLQo+IDIu
MTUuMQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
