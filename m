From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: use REG32_PCIE wrapper instead for psp
Date: Mon, 25 Feb 2019 15:11:40 +0800
Message-ID: <1551078700-1558-2-git-send-email-ray.huang@amd.com>
References: <1551078700-1558-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1551078700-1558-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Hawking Zhang <hawking.zhang-5C7GfCeVMHo@public.gmane.org>

VGhpcyBwYXRjaCB1c2VzIFJFRzMyX1BDSUUgd3JhcHBlciBpbnN0ZWFkIG9mIHdyaXR0aW5nIHBj
aV9pbmRleDIgYW5kIHJlYWRpbmcKcGNpX2RhdGEyIGZvciBwc3AuIFRoaXMgc2VxdWVuY2Ugc2hv
dWxkIGJlIHByb3RlY3RlZCBieSBwY2llX2lkeF9sb2NrLgoKU3VnZ2VzdGVkLWJ5OiBIYXdraW5n
IFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8
cmF5Lmh1YW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3Yz
XzEuYyB8IDQgKy0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92M18xLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjNfMS5jCmluZGV4IDM4ZGViNTcuLjU0
OTI2YTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92M18xLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YzXzEuYwpAQCAtNTAwLDkgKzUw
MCw3IEBAIHN0YXRpYyBib29sIHBzcF92M18xX3NtdV9yZWxvYWRfcXVpcmsoc3RydWN0IHBzcF9j
b250ZXh0ICpwc3ApCiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBwc3AtPmFkZXY7CiAJ
dWludDMyX3QgcmVnOwogCi0JcmVnID0gc21uTVAxX0ZJUk1XQVJFX0ZMQUdTIHwgMHgwM2IwMDAw
MDsKLQlXUkVHMzJfU09DMTUoTkJJTywgMCwgbW1QQ0lFX0lOREVYMiwgcmVnKTsKLQlyZWcgPSBS
UkVHMzJfU09DMTUoTkJJTywgMCwgbW1QQ0lFX0RBVEEyKTsKKwlyZWcgPSBSUkVHMzJfUENJRShz
bW5NUDFfRklSTVdBUkVfRkxBR1MgfCAweDAzYjAwMDAwKTsKIAlyZXR1cm4gKHJlZyAmIE1QMV9G
SVJNV0FSRV9GTEFHU19fSU5URVJSVVBUU19FTkFCTEVEX01BU0spID8gdHJ1ZSA6IGZhbHNlOwog
fQogCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
