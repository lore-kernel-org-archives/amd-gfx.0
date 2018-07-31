From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amd/display: add missing void parameter to
 dc_create_transfer_func
Date: Tue, 31 Jul 2018 11:42:54 +0100
Message-ID: <20180731104254.14683-1-colin.king@canonical.com>
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
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KCkFkZCBhIG1p
c3Npbmcgdm9pZCBwYXJhbWV0ZXIgdG8gZnVuY3Rpb24gZGNfY3JlYXRlX3RyYW5zZmVyX2Z1bmMs
IGZpeGVzCnNwYXJzZSB3YXJuaW5nOgoKd2FybmluZzogbm9uLUFOU0kgZnVuY3Rpb24gZGVjbGFy
YXRpb24gb2YgZnVuY3Rpb24gJ2RjX2NyZWF0ZV90cmFuc2Zlcl9mdW5jJwoKU2lnbmVkLW9mZi1i
eTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19zdXJmYWNlLmMgfCAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19zdXJmYWNlLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19zdXJmYWNlLmMKaW5kZXggODE1ZGZiNTAwODli
Li44ZmIzYWVmZDE5NWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9jb3JlL2RjX3N1cmZhY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Y29yZS9kY19zdXJmYWNlLmMKQEAgLTE5Miw3ICsxOTIsNyBAQCB2b2lkIGRjX3RyYW5zZmVyX2Z1
bmNfcmVsZWFzZShzdHJ1Y3QgZGNfdHJhbnNmZXJfZnVuYyAqdGYpCiAJa3JlZl9wdXQoJnRmLT5y
ZWZjb3VudCwgZGNfdHJhbnNmZXJfZnVuY19mcmVlKTsKIH0KIAotc3RydWN0IGRjX3RyYW5zZmVy
X2Z1bmMgKmRjX2NyZWF0ZV90cmFuc2Zlcl9mdW5jKCkKK3N0cnVjdCBkY190cmFuc2Zlcl9mdW5j
ICpkY19jcmVhdGVfdHJhbnNmZXJfZnVuYyh2b2lkKQogewogCXN0cnVjdCBkY190cmFuc2Zlcl9m
dW5jICp0ZiA9IGt2emFsbG9jKHNpemVvZigqdGYpLCBHRlBfS0VSTkVMKTsKIAotLSAKMi4xNy4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2
ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
