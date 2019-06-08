From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 1/7] drm: drm_crtc.h self-contained
Date: Sat,  8 Jun 2019 10:02:35 +0200
Message-ID: <20190608080241.4958-2-sam@ravnborg.org>
References: <20190608080241.4958-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190608080241.4958-1-sam@ravnborg.org>
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
Cc: David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>, Maxime Ripard <maxime.ripard@bootlin.com>, Alex Deucher <alexander.deucher@amd.com>, Sam Ravnborg <sam@ravnborg.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

V2hpbGUgcmVtb3ZpbmcgZHJtUC5oIGZyb20gZHJtL3JhZGVvbiBhIGZldyBmaWxlcyBlbmRlZAp1
cCBpbmNsdWRpbmcgZHJtX2NydGMuaCBhcyB0aGUgZmlyc3QgZmlsZS4KVGhpcyBmYWlsZWQgYnVp
bGQgZHVlIHRvIGEgbWlzc2luZyBkZXBlbmRlbmN5IGluIGRybV9jcnRjLmguCgpBZGQgdGhlIG1p
c3NpbmcgaW5jbHVkZSBmaWxlLgoKU2lnbmVkLW9mZi1ieTogU2FtIFJhdm5ib3JnIDxzYW1AcmF2
bmJvcmcub3JnPgpDYzogTWFhcnRlbiBMYW5raG9yc3QgPG1hYXJ0ZW4ubGFua2hvcnN0QGxpbnV4
LmludGVsLmNvbT4KQ2M6IE1heGltZSBSaXBhcmQgPG1heGltZS5yaXBhcmRAYm9vdGxpbi5jb20+
CkNjOiBTZWFuIFBhdWwgPHNlYW5AcG9vcmx5LnJ1bj4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGll
ZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KLS0tCiBpbmNs
dWRlL2RybS9kcm1fY3J0Yy5oIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykK
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9kcm1fY3J0Yy5oIGIvaW5jbHVkZS9kcm0vZHJtX2Ny
dGMuaAppbmRleCA1OGFkOTgzZDdjZDYuLmRjNDJiOWUzNTMzMyAxMDA2NDQKLS0tIGEvaW5jbHVk
ZS9kcm0vZHJtX2NydGMuaAorKysgYi9pbmNsdWRlL2RybS9kcm1fY3J0Yy5oCkBAIC0zOSw2ICsz
OSw3IEBACiAjaW5jbHVkZSA8ZHJtL2RybV9mcmFtZWJ1ZmZlci5oPgogI2luY2x1ZGUgPGRybS9k
cm1fbW9kZXMuaD4KICNpbmNsdWRlIDxkcm0vZHJtX2Nvbm5lY3Rvci5oPgorI2luY2x1ZGUgPGRy
bS9kcm1fZGV2aWNlLmg+CiAjaW5jbHVkZSA8ZHJtL2RybV9wcm9wZXJ0eS5oPgogI2luY2x1ZGUg
PGRybS9kcm1fYnJpZGdlLmg+CiAjaW5jbHVkZSA8ZHJtL2RybV9lZGlkLmg+Ci0tIAoyLjIwLjEK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZl
bCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
