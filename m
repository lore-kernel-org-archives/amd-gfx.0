From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drm/amdgpu: fix typo in amdgpu_debugfs_test_ib_init
Date: Wed, 21 Jun 2017 23:51:02 +0200
Message-ID: <20170621215121.3891272-1-arnd@arndb.de>
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
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Tom St Denis <tom.stdenis@amd.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org, Junwei Zhang <Jerry.Zhang@amd.com>, Ken Wang <Qingqing.Wang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Monk Liu <Monk.Liu@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

VGhlIGRlYnVnZnMgaW50ZXJmYWNlIGhhcyBjYWxscyBhIGZ1bmN0aW9uIHRoYXQgd2FzIGV2aWRl
bnRseQpkZWZpbmVkIHVuZGVyIHRoZSB3cm9uZyBuYW1lIGluIHNvbWUgY29uZmlndXJhdGlvbnM6
Cgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmM6NjQ6MTI6IGVycm9y
OiAnYW1kZ3B1X2RlYnVnZnNfdGVzdF9pYl9yaW5nX2luaXQnIHVzZWQgYnV0IG5ldmVyIGRlZmlu
ZWQgWy1XZXJyb3JdCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYzoz
ODAzOjEyOiBlcnJvcjogJ2FtZGdwdV9kZWJ1Z2ZzX3Rlc3RfaWJfaW5pdCcgZGVmaW5lZCBidXQg
bm90IHVzZWQgWy1XZXJyb3I9dW51c2VkLWZ1bmN0aW9uXQoKVGhpcyBmaXhlcyB0aGUgZnVuY3Rp
b24gbmFtZS4KCkZpeGVzOiA0ZjA5NTVmY2MwNTIgKCJkcm0vYW1kZ3B1OiBleHBvcnQgdGVzdCBp
YiBkZWJ1Z2ZzIGludGVyZmFjZSIpClNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRA
YXJuZGIuZGU+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCmluZGV4IDJlZTdjNTBj
NzBmOS4uNGE4ZmMxNTQ2N2NmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jCkBAIC0zODAwLDcgKzM4MDAsNyBAQCBpbnQgYW1kZ3B1X2RlYnVnZnNfaW5pdChz
dHJ1Y3QgZHJtX21pbm9yICptaW5vcikKIAlyZXR1cm4gMDsKIH0KICNlbHNlCi1zdGF0aWMgaW50
IGFtZGdwdV9kZWJ1Z2ZzX3Rlc3RfaWJfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikK
K3N0YXRpYyBpbnQgYW1kZ3B1X2RlYnVnZnNfdGVzdF9pYl9yaW5nX2luaXQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCiB7CiAJcmV0dXJuIDA7CiB9Ci0tIAoyLjkuMAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlz
dApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
