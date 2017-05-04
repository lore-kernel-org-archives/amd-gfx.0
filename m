From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/6] drm/amdgpu: fix mutex list null pointer reference
Date: Thu, 4 May 2017 14:34:23 +0800
Message-ID: <1493879668-26947-1-git-send-email-Xiangliang.Yu@amd.com>
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
Cc: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>, Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>

RnJvbTogUGl4ZWwgRGluZyA8UGl4ZWwuRGluZ0BhbWQuY29tPgoKRml4IE5VTEwgcG9pbnRlciBy
ZWZlcmVuY2UuCgpTaWduZWQtb2ZmLWJ5OiBQaXhlbCBEaW5nIDxQaXhlbC5EaW5nQGFtZC5jb20+
ClNpZ25lZC1vZmYtYnk6IFhpYW5nbGlhbmcgWXUgPFhpYW5nbGlhbmcuWXVAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCAzICsrLQogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCBlNjg1Y2E5Li5hZWYyMDE5IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0yMTE4LDcg
KzIxMTgsOCBAQCB2b2lkIGFtZGdwdV9kZXZpY2VfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKIAogCURSTV9JTkZPKCJhbWRncHU6IGZpbmlzaGluZyBkZXZpY2UuXG4iKTsKIAlhZGV2
LT5zaHV0ZG93biA9IHRydWU7Ci0JZHJtX2NydGNfZm9yY2VfZGlzYWJsZV9hbGwoYWRldi0+ZGRl
dik7CisJaWYgKGFkZXYtPmRkZXYtPm1vZGVfY29uZmlnLmZ1bmNzKQorCQlkcm1fY3J0Y19mb3Jj
ZV9kaXNhYmxlX2FsbChhZGV2LT5kZGV2KTsKIAkvKiBldmljdCB2cmFtIG1lbW9yeSAqLwogCWFt
ZGdwdV9ib19ldmljdF92cmFtKGFkZXYpOwogCWFtZGdwdV9pYl9wb29sX2ZpbmkoYWRldik7Ci0t
IAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
