From: Colin King <colin.king@canonical.com>
Subject: [PATCH][drm-next] drm/amdgpu: make function
 uvd_v6_0_enc_get_destroy_msg static
Date: Wed, 11 Oct 2017 10:21:11 +0100
Message-ID: <20171011092111.16842-1-colin.king@canonical.com>
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
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>, James Zhu <James.Zhu@amd.com>, Ken Wang <Qingqing.Wang@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KClRoZSBmdW5j
dGlvbiB1dmRfdjZfMF9lbmNfZ2V0X2Rlc3Ryb3lfbXNnIGlzIGxvY2FsIHRvIHRoZSBzb3VyY2Ug
YW5kCmRvZXMgbm90IG5lZWQgdG8gYmUgaW4gZ2xvYmFsIHNjb3BlLCBzbyBtYWtlIGl0IHN0YXRp
Yy4KCkNsZWFucyB1cCBzcGFyc2Ugd2FybmluZzoKc3ltYm9sICd1dmRfdjZfMF9lbmNfZ2V0X2Rl
c3Ryb3lfbXNnJyB3YXMgbm90IGRlY2xhcmVkLiBTaG91bGQgaXQgYmUKc3RhdGljPwoKU2lnbmVk
LW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jIHwgNSArKystLQogMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdXZkX3Y2XzAuYwppbmRleCA2MGFmNzMxMGEyMzQuLjcxMjk5YzY3YzUxNyAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y2XzAuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jCkBAIC0yNjgsOCArMjY4LDkgQEAgc3RhdGlj
IGludCB1dmRfdjZfMF9lbmNfZ2V0X2NyZWF0ZV9tc2coc3RydWN0IGFtZGdwdV9yaW5nICpyaW5n
LCB1aW50MzJfdCBoYW5kbGUKICAqCiAgKiBDbG9zZSB1cCBhIHN0cmVhbSBmb3IgSFcgdGVzdCBv
ciBpZiB1c2Vyc3BhY2UgZmFpbGVkIHRvIGRvIHNvCiAgKi8KLWludCB1dmRfdjZfMF9lbmNfZ2V0
X2Rlc3Ryb3lfbXNnKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywgdWludDMyX3QgaGFuZGxlLAot
CQkJCSBib29sIGRpcmVjdCwgc3RydWN0IGRtYV9mZW5jZSAqKmZlbmNlKQorc3RhdGljIGludCB1
dmRfdjZfMF9lbmNfZ2V0X2Rlc3Ryb3lfbXNnKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKKwkJ
CQkJdWludDMyX3QgaGFuZGxlLAorCQkJCQlib29sIGRpcmVjdCwgc3RydWN0IGRtYV9mZW5jZSAq
KmZlbmNlKQogewogCWNvbnN0IHVuc2lnbmVkIGliX3NpemVfZHcgPSAxNjsKIAlzdHJ1Y3QgYW1k
Z3B1X2pvYiAqam9iOwotLSAKMi4xNC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWwK
