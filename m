From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 2/5] drm/amdgpu: remove extra TT unpopulated check
Date: Fri,  2 Feb 2018 20:09:45 +0100
Message-ID: <20180202190948.2654-2-christian.koenig@amd.com>
References: <20180202190948.2654-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180202190948.2654-1-christian.koenig@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

VGhlIHN1YnN5c3RlbSBjaG91bGQgY2hlY2sgdGhhdCwgbm90IHRoZSBkcml2ZXIuCgpTaWduZWQt
b2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgMyAtLS0KIDEgZmlsZSBj
aGFuZ2VkLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90
dG0uYwppbmRleCA5NWY5OTAxNDBmMmEuLjY0OGM0NDlhYWE3OSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV90dG0uYwpAQCAtOTk3LDkgKzk5Nyw2IEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X3R0bV90dF9wb3B1bGF0ZShzdHJ1Y3QgdHRtX3R0ICp0dG0sCiAJc3RydWN0IGFtZGdwdV90
dG1fdHQgKmd0dCA9ICh2b2lkICopdHRtOwogCWJvb2wgc2xhdmUgPSAhISh0dG0tPnBhZ2VfZmxh
Z3MgJiBUVE1fUEFHRV9GTEFHX1NHKTsKIAotCWlmICh0dG0tPnN0YXRlICE9IHR0X3VucG9wdWxh
dGVkKQotCQlyZXR1cm4gMDsKLQogCWlmIChndHQgJiYgZ3R0LT51c2VycHRyKSB7CiAJCXR0bS0+
c2cgPSBremFsbG9jKHNpemVvZihzdHJ1Y3Qgc2dfdGFibGUpLCBHRlBfS0VSTkVMKTsKIAkJaWYg
KCF0dG0tPnNnKQotLSAKMi4xNC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWwK
