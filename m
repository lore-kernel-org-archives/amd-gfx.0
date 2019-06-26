From: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: [PATCH 1/1] drm/ttm: return -EBUSY if waiting for busy BO fails
Date: Wed, 26 Jun 2019 06:40:16 +0000
Message-ID: <20190626063958.19941-1-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

UmV0dXJuaW5nIC1FQUdBSU4gcHJldmVudHMgdHRtX2JvX21lbV9zcGFjZSBmcm9tIHRyeWluZyBh
bHRlcm5hdGUNCnBsYWNlbWVudHMgYW5kIGNhbiBsZWFkIHRvIGxpdmUtbG9ja3MgaW4gYW1kZ3B1
X2NzLCByZXRyeWluZw0KaW5kZWZpbml0ZWx5IGFuZCBuZXZlciBzdWNjZWVkaW5nLg0KDQpGaXhl
czogY2ZjYzUyZTQ3N2U0ICgiZHJtL3R0bTogZml4IGJ1c3kgbWVtb3J5IHRvIGZhaWwgb3RoZXIg
dXNlciB2MTAiKQ0KQ0M6IENocmlzdGlhbiBLb2VuaWcgPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNv
bT4NClNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29t
Pg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyB8IDIgKy0NCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS90dG0vdHRtX2JvLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jDQpp
bmRleCBjN2RlNjY3ZDQ4MmEuLjU4YzQwM2VkYTA0ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1
L2RybS90dG0vdHRtX2JvLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMNCkBA
IC04MjcsNyArODI3LDcgQEAgc3RhdGljIGludCB0dG1fbWVtX2V2aWN0X3dhaXRfYnVzeShzdHJ1
Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJ1c3lfYm8sDQogCWlmICghcikNCiAJCXJlc2VydmF0aW9u
X29iamVjdF91bmxvY2soYnVzeV9iby0+cmVzdik7DQogDQotCXJldHVybiByID09IC1FREVBRExL
ID8gLUVBR0FJTiA6IHI7DQorCXJldHVybiByID09IC1FREVBRExLID8gLUVCVVNZIDogcjsNCiB9
DQogDQogc3RhdGljIGludCB0dG1fbWVtX2V2aWN0X2ZpcnN0KHN0cnVjdCB0dG1fYm9fZGV2aWNl
ICpiZGV2LA0KLS0gDQoyLjE3LjENCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vZHJpLWRldmVs
