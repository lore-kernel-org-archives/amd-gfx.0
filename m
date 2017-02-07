From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] drm/amdgpu/virt: double free in amdgpu_map_static_csa()
Date: Tue, 7 Feb 2017 16:16:51 +0300
Message-ID: <20170207131651.GB27416@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexander.deucher@amd.com>, Monk Liu <Monk.Liu@amd.com>
Cc: kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, Xiangliang Yu <Xiangliang.Yu@amd.com>, amd-gfx@lists.freedesktop.org, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

VGhlIGFtZGdwdV92bV9ib19ybXYoKSBmdW5jdGlvbiBmcmVlcyAiYm9fdmEiIHNvIHdlIHNob3Vs
ZG4ndCBmcmVlIGl0CmEgc2Vjb25kIHRpbWUuCgpGaXhlczogNGU0YmJlNzM0M2E2ICgiZHJtL2Ft
ZGdwdTphZGQgbmV3IGZpbGUgZm9yIFNSSU9WIikKU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRl
ciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmlydC5jCmluZGV4IDNmZDk1MWM3MWQxYi4uZGNmYjdkZjNjYWY0IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMKQEAgLTgzLDcgKzgzLDYgQEAgaW50IGFt
ZGdwdV9tYXBfc3RhdGljX2NzYShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFt
ZGdwdV92bSAqdm0pCiAJCURSTV9FUlJPUigiZmFpbGVkIHRvIGRvIGJvX21hcCBvbiBzdGF0aWMg
Q1NBLCBlcnI9JWRcbiIsIHIpOwogCQlhbWRncHVfdm1fYm9fcm12KGFkZXYsIGJvX3ZhKTsKIAkJ
dHRtX2V1X2JhY2tvZmZfcmVzZXJ2YXRpb24oJnRpY2tldCwgJmxpc3QpOwotCQlrZnJlZShib192
YSk7CiAJCXJldHVybiByOwogCX0KIApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWwK
