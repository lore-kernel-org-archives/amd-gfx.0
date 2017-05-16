From: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/4] drm/amd/amdgpu: Cleanup uvd_v4_2_soft_reset()
Date: Tue, 16 May 2017 08:45:29 -0400
Message-ID: <20170516124530.28683-4-tom.stdenis@amd.com>
References: <20170516124530.28683-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170516124530.28683-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

VXNlIFdSRUczMl9GSUVMRCBpbnN0ZWFkLgoKU2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0
b20uc3RkZW5pc0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92
NF8yLmMgfCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NF8yLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjRfMi5jCmluZGV4IGNkNzkzYzI2MjY3
NC4uZDRlMzVmZjhkOWNkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91
dmRfdjRfMi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NF8yLmMKQEAg
LTY2Miw4ICs2NjIsNyBAQCBzdGF0aWMgaW50IHV2ZF92NF8yX3NvZnRfcmVzZXQodm9pZCAqaGFu
ZGxlKQogCiAJdXZkX3Y0XzJfc3RvcChhZGV2KTsKIAotCVdSRUczMl9QKG1tU1JCTV9TT0ZUX1JF
U0VULCBTUkJNX1NPRlRfUkVTRVRfX1NPRlRfUkVTRVRfVVZEX01BU0ssCi0JCQl+U1JCTV9TT0ZU
X1JFU0VUX19TT0ZUX1JFU0VUX1VWRF9NQVNLKTsKKwlXUkVHMzJfRklFTEQoU1JCTV9TT0ZUX1JF
U0VULCBTT0ZUX1JFU0VUX1VWRCwgMSk7CiAJbWRlbGF5KDUpOwogCiAJcmV0dXJuIHV2ZF92NF8y
X3N0YXJ0KGFkZXYpOwotLSAKMi4xMi4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
