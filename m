From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] drm/ttm: Add dummy *populate_and_*map_pages() functions
Date: Thu, 24 Aug 2017 06:48:17 -0400
Message-ID: <20170824104818.9973-1-tom.stdenis@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gbm9uIElPVExCL0lPTU1VIGJ1aWxkcyB0aGVzZSBmdW5jdGlvbnMgd291bGQgYmUgdW5kZWZp
bmVkLgoKU2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29tPgot
LS0KIGluY2x1ZGUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5oIHwgMTAgKysrKysrKysrKwogMSBm
aWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS90
dG0vdHRtX3BhZ2VfYWxsb2MuaCBiL2luY2x1ZGUvZHJtL3R0bS90dG1fcGFnZV9hbGxvYy5oCmlu
ZGV4IDg2OTU5MThlYTYyOS4uNDQwMGMwODE2OWNkIDEwMDY0NAotLS0gYS9pbmNsdWRlL2RybS90
dG0vdHRtX3BhZ2VfYWxsb2MuaAorKysgYi9pbmNsdWRlL2RybS90dG0vdHRtX3BhZ2VfYWxsb2Mu
aApAQCAtMTE2LDYgKzExNiwxNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgdHRtX2RtYV91bnBvcHVs
YXRlKHN0cnVjdCB0dG1fZG1hX3R0ICp0dG1fZG1hLAogCQkJCSAgICAgIHN0cnVjdCBkZXZpY2Ug
KmRldikKIHsKIH0KKworc3RhdGljIGlubGluZSBpbnQgdHRtX3BvcHVsYXRlX2FuZF9tYXBfcGFn
ZXMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgdHRtX2RtYV90dCAqdHQpCit7CisJcmV0dXJu
IDA7Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCB0dG1fdW5tYXBfYW5kX3VucG9wdWxhdGVfcGFn
ZXMoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgdHRtX2RtYV90dCAqdHQpCit7Cit9CisKICNl
bmRpZgogCiAjZW5kaWYKLS0gCjIuMTIuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
