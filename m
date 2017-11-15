From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amd/display: remove unnecessary cast and use kcalloc
 instead of kzalloc
Date: Wed, 15 Nov 2017 15:45:09 +0000
Message-ID: <20171115154509.18054-1-colin.king@canonical.com>
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
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Harry Wentland <harry.wentland@amd.com>, Tony Cheng <tony.cheng@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KClVzZSBrY2Fs
bG9jIGluc3RlYWQgb2Yga3phbGxvYyBhbmQgdGhlIGNhc3Qgb24gdGhlIHJldHVybiBmcm9tIGt6
YWxsb2MgaXMKdW5uZWNlc3NhcnkgYW5kIGNhbiBiZSByZW1vdmVkLgoKU2lnbmVkLW9mZi1ieTog
Q29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmFzaWNzL2xvZ2dlci5jIHwgNSArKy0tLQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmFzaWNzL2xvZ2dlci5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2Jhc2ljcy9sb2dnZXIuYwppbmRleCBlMDRlOGVjZDQ4NzQuLjJm
ZjViNDY3NjAzZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jh
c2ljcy9sb2dnZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmFzaWNz
L2xvZ2dlci5jCkBAIC03MCw5ICs3MCw4IEBAIHN0YXRpYyBib29sIGNvbnN0cnVjdChzdHJ1Y3Qg
ZGNfY29udGV4dCAqY3R4LCBzdHJ1Y3QgZGFsX2xvZ2dlciAqbG9nZ2VyLAogewogCS8qIG1hbGxv
YyBidWZmZXIgYW5kIGluaXQgb2Zmc2V0cyAqLwogCWxvZ2dlci0+bG9nX2J1ZmZlcl9zaXplID0g
REFMX0xPR0dFUl9CVUZGRVJfTUFYX1NJWkU7Ci0JbG9nZ2VyLT5sb2dfYnVmZmVyID0gKGNoYXIg
KilremFsbG9jKGxvZ2dlci0+bG9nX2J1ZmZlcl9zaXplICogc2l6ZW9mKGNoYXIpLAotCQkJCQkg
ICAgIEdGUF9LRVJORUwpOwotCisJbG9nZ2VyLT5sb2dfYnVmZmVyID0ga2NhbGxvYyhsb2dnZXIt
PmxvZ19idWZmZXJfc2l6ZSwgc2l6ZW9mKGNoYXIpLAorCQkJCSAgICAgR0ZQX0tFUk5FTCk7CiAJ
aWYgKCFsb2dnZXItPmxvZ19idWZmZXIpCiAJCXJldHVybiBmYWxzZTsKIAotLSAKMi4xNC4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwg
bWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
