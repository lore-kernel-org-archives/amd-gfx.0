From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 09/10] drm/amdgpu: create GDS, GWS and OA in system domain
Date: Wed, 29 May 2019 14:27:01 +0200
Message-ID: <20190529122702.13035-9-christian.koenig@amd.com>
References: <20190529122702.13035-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190529122702.13035-1-christian.koenig@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW5kIG9ubHkgbW92ZSB0aGVtIGluIG9uIHZhbGlkYXRpb24uIFRoaXMgYWxsb3dzIGZvciBiZXR0
ZXIgY29udHJvbAp3aGVuIG11bHRpcGxlIHByb2Nlc3NlcyBhcmUgZmlnaHRpbmcgb3ZlciB0aG9z
ZSByZXNvdXJjZXMuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29i
amVjdC5jIHwgNiArKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
b2JqZWN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKaW5k
ZXggOTNiMmM1YTQ4YTcxLi4zMDQ5MzQyOTg1MWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfb2JqZWN0LmMKQEAgLTQ5NSw3ICs0OTUsMTEgQEAgc3RhdGljIGludCBhbWRn
cHVfYm9fZG9fY3JlYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogI2VuZGlmCiAKIAli
by0+dGJvLmJkZXYgPSAmYWRldi0+bW1hbi5iZGV2OwotCWFtZGdwdV9ib19wbGFjZW1lbnRfZnJv
bV9kb21haW4oYm8sIGJwLT5kb21haW4pOworCWlmIChicC0+ZG9tYWluICYgKEFNREdQVV9HRU1f
RE9NQUlOX0dXUyB8IEFNREdQVV9HRU1fRE9NQUlOX09BIHwKKwkJCSAgQU1ER1BVX0dFTV9ET01B
SU5fR0RTKSkKKwkJYW1kZ3B1X2JvX3BsYWNlbWVudF9mcm9tX2RvbWFpbihibywgQU1ER1BVX0dF
TV9ET01BSU5fQ1BVKTsKKwllbHNlCisJCWFtZGdwdV9ib19wbGFjZW1lbnRfZnJvbV9kb21haW4o
Ym8sIGJwLT5kb21haW4pOwogCWlmIChicC0+dHlwZSA9PSB0dG1fYm9fdHlwZV9rZXJuZWwpCiAJ
CWJvLT50Ym8ucHJpb3JpdHkgPSAxOwogCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRl
dmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
