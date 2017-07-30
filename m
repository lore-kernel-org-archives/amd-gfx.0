From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] drm/amdgpu: Fix dce_v6_0_disable_dce warning
Date: Sun, 30 Jul 2017 13:26:14 +0200
Message-ID: <20170730132614.65f92378@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?UTF-8?B?S8O2?= =?UTF-8?B?bmln?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

SW5jbHVkZSBhIG1pc3NpbmcgaGVhZGVyIHRvIGdldCByaWQgb2YgdGhlIGZvbGxvd2luZyB3YXJu
aW5nOgoKZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3Y2XzAuYzo1MjE6Njogd2Fybmlu
Zzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciAnZGNlX3Y2XzBfZGlzYWJsZV9kY2UnIFstV21p
c3NpbmctcHJvdG90eXBlc10KIHZvaWQgZGNlX3Y2XzBfZGlzYWJsZV9kY2Uoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCiAgICAgIF4KClNpZ25lZC1vZmYtYnk6IEplYW4gRGVsdmFyZSA8amRl
bHZhcmVAc3VzZS5kZT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92Nl8wLmMgfCAgICAxICsKIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQoKLS0tIGxpbnV4LTQuMTIub3JpZy9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9kY2VfdjZfMC5jCTIwMTctMDctMzAgMTM6MTk6NTAuNTQ2NjAzMjE1ICsw
MjAwCisrKyBsaW51eC00LjEyL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92Nl8wLmMJ
MjAxNy0wNy0zMCAxMzoyMToyMC4wODM3MDQzODggKzAyMDAKQEAgLTQyLDYgKzQyLDcgQEAKICNp
bmNsdWRlICJkY2UvZGNlXzZfMF9kLmgiCiAjaW5jbHVkZSAiZGNlL2RjZV82XzBfc2hfbWFzay5o
IgogI2luY2x1ZGUgImdjYS9nZnhfN18yX2VudW0uaCIKKyNpbmNsdWRlICJkY2VfdjZfMC5oIgog
I2luY2x1ZGUgInNpX2VudW1zLmgiCiAKIHN0YXRpYyB2b2lkIGRjZV92Nl8wX3NldF9kaXNwbGF5
X2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKCgotLSAKSmVhbiBEZWx2YXJlClNV
U0UgTDMgU3VwcG9ydApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWwK
