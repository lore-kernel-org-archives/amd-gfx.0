From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v1 2/7] drm: drm_debugfs.h self-contained
Date: Sat,  8 Jun 2019 10:02:36 +0200
Message-ID: <20190608080241.4958-3-sam@ravnborg.org>
References: <20190608080241.4958-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190608080241.4958-1-sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, Maarten Lankhorst <maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

V2hpbGUgcmVtb3ZpbmcgZHJtUC5oIGZyb20gZHJtL3JhZGVvbiBhIGZldyBmaWxlcyBlbmRlZAp1
cCBpbmNsdWRpbmcgZHJtX2RlYnVnZnMuaCBhcyB0aGUgZmlyc3QgZmlsZS4KVGhpcyBmYWlsZWQg
YnVpbGQgZHVlIHRvIG1pc3NpbmcgZGVwZW5kZW5jaWVzIGluIGRybV9kZWJ1Z2ZzLmguCgpBZGQg
dGhlIG1pc3NpbmcgaW5jbHVkZSBmaWxlcy4KClNpZ25lZC1vZmYtYnk6IFNhbSBSYXZuYm9yZyA8
c2FtQHJhdm5ib3JnLm9yZz4KQ2M6IE1hYXJ0ZW4gTGFua2hvcnN0IDxtYWFydGVuLmxhbmtob3Jz
dEBsaW51eC5pbnRlbC5jb20+CkNjOiBNYXhpbWUgUmlwYXJkIDxtYXhpbWUucmlwYXJkQGJvb3Rs
aW4uY29tPgpDYzogU2VhbiBQYXVsIDxzZWFuQHBvb3JseS5ydW4+CkNjOiBEYXZpZCBBaXJsaWUg
PGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Ci0t
LQogaW5jbHVkZS9kcm0vZHJtX2RlYnVnZnMuaCB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9kcm1fZGVidWdmcy5oIGIvaW5j
bHVkZS9kcm0vZHJtX2RlYnVnZnMuaAppbmRleCBhYzBmNzVkZjFhYzkuLjc1MDFlMzIzZDM4MyAx
MDA2NDQKLS0tIGEvaW5jbHVkZS9kcm0vZHJtX2RlYnVnZnMuaAorKysgYi9pbmNsdWRlL2RybS9k
cm1fZGVidWdmcy5oCkBAIC0zMiw2ICszMiw4IEBACiAjaWZuZGVmIF9EUk1fREVCVUdGU19IXwog
I2RlZmluZSBfRFJNX0RFQlVHRlNfSF8KIAorI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+CisjaW5j
bHVkZSA8bGludXgvc2VxX2ZpbGUuaD4KIC8qKgogICogc3RydWN0IGRybV9pbmZvX2xpc3QgLSBk
ZWJ1Z2ZzIGluZm8gbGlzdCBlbnRyeQogICoKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
