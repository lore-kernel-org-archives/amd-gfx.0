From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 01/10] drm: fix build errors with drm_print.h
Date: Mon, 10 Jun 2019 00:07:48 +0200
Message-ID: <20190609220757.10862-2-sam@ravnborg.org>
References: <20190609220757.10862-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190609220757.10862-1-sam@ravnborg.org>
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

ZHJtX3ByaW50LmggcmVxdWlyZXMgPGRybS9kcm0uaD4gdG8gZml4IGJ1aWxkIHdoZW4gbWFjcm9z
IGFyZSB1c2VkLgpQdWxsIGluIHRoZSBoZWFkZXIgZmlsZSBpbiBkcm1fcHJpbnQuaCBzbyB1c2Vy
cyBkbyBub3QgaGF2ZSB0byBkbyBpdC4KClNpZ25lZC1vZmYtYnk6IFNhbSBSYXZuYm9yZyA8c2Ft
QHJhdm5ib3JnLm9yZz4KQ2M6IE1hYXJ0ZW4gTGFua2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBs
aW51eC5pbnRlbC5jb20+CkNjOiBNYXhpbWUgUmlwYXJkIDxtYXhpbWUucmlwYXJkQGJvb3RsaW4u
Y29tPgpDYzogU2VhbiBQYXVsIDxzZWFuQHBvb3JseS5ydW4+CkNjOiBEYXZpZCBBaXJsaWUgPGFp
cmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Ci0tLQog
aW5jbHVkZS9kcm0vZHJtX3ByaW50LmggfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZHJtX3ByaW50LmggYi9pbmNsdWRlL2Ry
bS9kcm1fcHJpbnQuaAppbmRleCAzYTQyNDczMTllNjMuLmE1ZDZmMmYzZTQzMCAxMDA2NDQKLS0t
IGEvaW5jbHVkZS9kcm0vZHJtX3ByaW50LmgKKysrIGIvaW5jbHVkZS9kcm0vZHJtX3ByaW50LmgK
QEAgLTMyLDYgKzMyLDggQEAKICNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4KICNpbmNsdWRlIDxs
aW51eC9kZWJ1Z2ZzLmg+CiAKKyNpbmNsdWRlIDxkcm0vZHJtLmg+CisKIC8qKgogICogRE9DOiBw
cmludAogICoKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
ZHJpLWRldmVs
