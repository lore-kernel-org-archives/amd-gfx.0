From: Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/5] drm/ttm: delete set_pages_array_wb since no one use it
 anymore
Date: Wed, 22 Nov 2017 16:06:37 +0800
Message-ID: <1511337997-26698-5-git-send-email-Hongbo.He@amd.com>
References: <1511337997-26698-1-git-send-email-Hongbo.He@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1511337997-26698-1-git-send-email-Hongbo.He-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: David1.Zhou-5C7GfCeVMHo@public.gmane.org, Roger He <Hongbo.He-5C7GfCeVMHo@public.gmane.org>, Christian.Koenig-5C7GfCeVMHo@public.gmane.org

Q2hhbmdlLUlkOiBJOWZhNDVhZjQ0N2MzYzc4ZDBiN2IyYjg5NTgwODFlNTg0YzU2MDEyMApTaWdu
ZWQtb2ZmLWJ5OiBSb2dlciBIZSA8SG9uZ2JvLkhlQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5jIHwgMTEgLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9w
YWdlX2FsbG9jLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMKaW5kZXgg
ODJkNDBjNi4uNTNmZDhlOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcGFn
ZV9hbGxvYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2MuYwpAQCAt
MjM3LDE3ICsyMzcsNiBAQCBzdGF0aWMgaW50IHNldF9wYWdlc193YihzdHJ1Y3QgcGFnZSAqcGFn
ZSwgaW50IG51bXBhZ2VzKQogCXJldHVybiAwOwogfQogCi1zdGF0aWMgaW50IHNldF9wYWdlc19h
cnJheV93YihzdHJ1Y3QgcGFnZSAqKnBhZ2VzLCBpbnQgYWRkcmluYXJyYXkpCi17Ci0jaWYgSVNf
RU5BQkxFRChDT05GSUdfQUdQKQotCWludCBpOwotCi0JZm9yIChpID0gMDsgaSA8IGFkZHJpbmFy
cmF5OyBpKyspCi0JCXVubWFwX3BhZ2VfZnJvbV9hZ3AocGFnZXNbaV0pOwotI2VuZGlmCi0JcmV0
dXJuIDA7Ci19Ci0KIHN0YXRpYyBpbnQgc2V0X3BhZ2VzX2FycmF5X3djKHN0cnVjdCBwYWdlICoq
cGFnZXMsIGludCBhZGRyaW5hcnJheSkKIHsKICNpZiBJU19FTkFCTEVEKENPTkZJR19BR1ApCi0t
IAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
