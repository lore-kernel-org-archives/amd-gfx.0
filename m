From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/amdgpu/virt: fix double kfree on bo_va
Date: Fri,  3 Feb 2017 20:23:42 +0000
Message-ID: <20170203202342.13128-1-colin.king@canonical.com>
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
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Monk Liu <Monk.Liu@amd.com>, Xiangliang Yu <Xiangliang.Yu@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KCmJvX3ZhIGlz
IGJlaW5nIGtmcmVlJ2QgdHdpY2UsIG9uY2UgaW4gdGhlIGNhbGwgdG8gYW1kZ3B1X3ZtX2JvX3Jt
dgphbmQgdGhlbiBhIHNob3J0IHdoaWxlIGxhdGVyLiBGaXggdGhpcyBkb3VibGUgZnJlZSBieSBy
ZW1vdmluZwp0aGUgMm5kIGtmcmVlLgoKRGV0ZWN0ZWQgYnkgQ292ZXJpdHlTY2FuLCBDSUQjMTM5
OTUyNCAoIkRvdWJsZSBGcmVlIikKClNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xp
bi5raW5nQGNhbm9uaWNhbC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZpcnQuYyB8IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYwppbmRleCAzZmQ5NTFjLi5kY2ZiN2RmIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMKQEAgLTgzLDcgKzgzLDYg
QEAgaW50IGFtZGdwdV9tYXBfc3RhdGljX2NzYShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwg
c3RydWN0IGFtZGdwdV92bSAqdm0pCiAJCURSTV9FUlJPUigiZmFpbGVkIHRvIGRvIGJvX21hcCBv
biBzdGF0aWMgQ1NBLCBlcnI9JWRcbiIsIHIpOwogCQlhbWRncHVfdm1fYm9fcm12KGFkZXYsIGJv
X3ZhKTsKIAkJdHRtX2V1X2JhY2tvZmZfcmVzZXJ2YXRpb24oJnRpY2tldCwgJmxpc3QpOwotCQlr
ZnJlZShib192YSk7CiAJCXJldHVybiByOwogCX0KIAotLSAKMi4xMC4yCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0
CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
