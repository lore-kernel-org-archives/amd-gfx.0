From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] drm/amdgpu: fix spelling mistake: "asssert" -> "assert"
Date: Thu, 22 Mar 2018 15:41:44 +0000
Message-ID: <20180322154144.31363-1-colin.king@canonical.com>
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
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KClRyaXZpYWwg
Zml4IHRvIHNwZWxsaW5nIG1pc3Rha2UgaW4gcHJfZXJyIGVycm9yIG1lc3NhZ2UgdGV4dAoKU2ln
bmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9teGdwdV9haS5jIHwgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L214Z3B1X2FpLmMKaW5kZXggOGZiOTMzYzYyY2Y1Li40OTMzNDg2NzI0NzUgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L214Z3B1X2FpLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvbXhncHVfYWkuYwpAQCAtMTI5LDcgKzEyOSw3IEBAIHN0YXRpYyB2
b2lkIHhncHVfYWlfbWFpbGJveF90cmFuc19tc2cgKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAogCQl4Z3B1X2FpX21haWxib3hfc2V0X3ZhbGlkKGFkZXYsIGZhbHNlKTsKIAkJdHJuID0geGdw
dV9haV9wZWVrX2FjayhhZGV2KTsKIAkJaWYgKHRybikgewotCQkJcHJfZXJyKCJ0cm49JXggQUNL
IHNob3VsZCBub3QgYXNzc2VydCEgd2FpdCBhZ2FpbiAhXG4iLCB0cm4pOworCQkJcHJfZXJyKCJ0
cm49JXggQUNLIHNob3VsZCBub3QgYXNzZXJ0ISB3YWl0IGFnYWluICFcbiIsIHRybik7CiAJCQlt
c2xlZXAoMSk7CiAJCX0KIAl9IHdoaWxlKHRybik7Ci0tIAoyLjE1LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QK
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
