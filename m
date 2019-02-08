From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Subject: [PATCH v2 0/2] drm/drv: Rework drm_dev_unplug() (was: Remove
 drm_dev_unplug())
Date: Fri,  8 Feb 2019 15:01:01 +0100
Message-ID: <20190208140103.28919-1-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: David1.Zhou-5C7GfCeVMHo@public.gmane.org, Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org, oleksandr_andrushchenko-uRwfk40T5oI@public.gmane.org, daniel.vetter-/w4YWyX8dFk@public.gmane.org, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, alexander.deucher-5C7GfCeVMHo@public.gmane.org, airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

VGhpcyBzZXJpZXMgbWFrZXMgZHJtX2Rldl91bnBsdWcoKSBjb21wYXRpYmxlIHdpdGggdGhlIHVw
Y29taW5nCmRldm1fZHJtX2Rldl9pbml0KCksIGZpeGVzIGEgZG91YmxlIGRybV9kZXZfdW5yZWdp
c3RlcigpIHNpdHVhdGlvbiBhbmQKc2ltcGxpZmllcyB0aGUgZHJtX2RldmljZSByZWYgaGFuZGxp
bmcgd3J0IHRvIHRoZSBsYXN0IGZkIGNsb3NlZCBhZnRlcgp1bnJlZ2lzdGVyLgoKVGhlIGZpcnN0
IHZlcnNpb24gb2YgdGhpcyBwYXRjaHNldCByZW1vdmVkIGRybV9kZXZfdW5wbHVnKCksIHNlZSBo
ZXJlCmZvciB0aGUgZGlzY3Vzc2lvbiBhcyB0byB3aHkgaXQgaXMga2VwdCBmb3IgdGhlIHRpbWUg
YmVpbmc6CgpbMi82XSBkcm0vZHJ2OiBQcmVwYXJlIHRvIHJlbW92ZSBkcm1fZGV2X3VucGx1Zygp
Cmh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9wYXRjaC8yODI5MDIvCgpOb3JhbGYu
CgpOb3JhbGYgVHLDuG5uZXMgKDIpOgogIGRybTogRml4IGRybV9yZWxlYXNlKCkgYW5kIGRldmlj
ZSB1bnBsdWcKICBkcm0vZHJ2OiBkcm1fZGV2X3VucGx1ZygpOiBNb3ZlIG91dCBkcm1fZGV2X3B1
dCgpIGNhbGwKCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCAxICsK
IGRyaXZlcnMvZ3B1L2RybS9kcm1fZHJ2LmMgICAgICAgICAgICAgICB8IDUgLS0tLS0KIGRyaXZl
cnMvZ3B1L2RybS9kcm1fZmlsZS5jICAgICAgICAgICAgICB8IDYgKystLS0tCiBkcml2ZXJzL2dw
dS9kcm0vdWRsL3VkbF9kcnYuYyAgICAgICAgICAgfCAxICsKIGRyaXZlcnMvZ3B1L2RybS94ZW4v
eGVuX2RybV9mcm9udC5jICAgICB8IDEgKwogNSBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pCgotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
