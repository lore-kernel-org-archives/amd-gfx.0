From: Colin King <colin.king@canonical.com>
Subject: [PATCH][drm-next] drm/amdgpu: remove duplicate return statement
Date: Wed, 23 Aug 2017 14:17:40 +0100
Message-ID: <20170823131740.20930-1-colin.king@canonical.com>
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
To: Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KClJlbW92ZSBh
IHJlZHVuZGFudCBpZGVudGljYWwgcmV0dXJuIHN0YXRlbWVudCwgaXQgaGFzIG5vIHVzZS4KCkRl
dGVjdGVkIGJ5IENvdmVyaXR5U2NhbiwgQ0lEIzE0NTQ1ODYgKCJTdHJ1Y3R1cmFsbHkgZGVhZCBj
b2RlIikKClNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNh
bC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhf
djguYyB8IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjguYwppbmRleCBmYjZlNWRi
ZDVhMDMuLjMwOWYyNDE5YzZkOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjguYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfYW1ka2ZkX2dmeF92OC5jCkBAIC0xNTUsNyArMTU1LDYgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBrZmQya2dkX2NhbGxzIGtmZDJrZ2QgPSB7CiBzdHJ1Y3Qga2ZkMmtnZF9jYWxscyAq
YW1kZ3B1X2FtZGtmZF9nZnhfOF8wX2dldF9mdW5jdGlvbnModm9pZCkKIHsKIAlyZXR1cm4gKHN0
cnVjdCBrZmQya2dkX2NhbGxzICopJmtmZDJrZ2Q7Ci0JcmV0dXJuIChzdHJ1Y3Qga2ZkMmtnZF9j
YWxscyAqKSZrZmQya2dkOwogfQogCiBzdGF0aWMgaW5saW5lIHN0cnVjdCBhbWRncHVfZGV2aWNl
ICpnZXRfYW1kZ3B1X2RldmljZShzdHJ1Y3Qga2dkX2RldiAqa2dkKQotLSAKMi4xNC4xCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFp
bGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
