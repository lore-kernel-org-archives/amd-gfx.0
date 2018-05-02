From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amd/display: clean up assignment of amdgpu_crtc
Date: Wed,  2 May 2018 15:43:16 +0100
Message-ID: <20180502144316.32056-1-colin.king@canonical.com>
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
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KClRoZSBkZWNs
YXJhdGlvbiBvZiBwb2ludGVyIGFtZGdwdV9jcnRjIGhhcyBhIHJlZHVuZGFudCBhc3NpZ25tZW50
IHRvCmFtZGdwdV9jcnRjLiBDbGVhbiB0aGlzIHVwIGJ5IHJlbW92aW5nIGl0LgoKRGV0ZWN0ZWQg
YnkgQ292ZXJpdHlTY2FuLCBDSUQjMTQ2MDI5OSAoIkV2YWx1YXRpb24gb3JkZXIgdmlvbGF0aW9u
IikKClNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0u
YyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5j
CmluZGV4IDFkZDExNDIyNDZjMi4uMmJlYjg4MjFlMTllIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTM3NzMsNyArMzc3Myw3
IEBAIHN0YXRpYyB2b2lkIHJlbW92ZV9zdHJlYW0oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
CiBzdGF0aWMgaW50IGdldF9jdXJzb3JfcG9zaXRpb24oc3RydWN0IGRybV9wbGFuZSAqcGxhbmUs
IHN0cnVjdCBkcm1fY3J0YyAqY3J0YywKIAkJCSAgICAgICBzdHJ1Y3QgZGNfY3Vyc29yX3Bvc2l0
aW9uICpwb3NpdGlvbikKIHsKLQlzdHJ1Y3QgYW1kZ3B1X2NydGMgKmFtZGdwdV9jcnRjID0gYW1k
Z3B1X2NydGMgPSB0b19hbWRncHVfY3J0YyhjcnRjKTsKKwlzdHJ1Y3QgYW1kZ3B1X2NydGMgKmFt
ZGdwdV9jcnRjID0gdG9fYW1kZ3B1X2NydGMoY3J0Yyk7CiAJaW50IHgsIHk7CiAJaW50IHhvcmln
aW4gPSAwLCB5b3JpZ2luID0gMDsKIAotLSAKMi4xNy4wCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
